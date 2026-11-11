import 'dart:convert';
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api_client.dart';
import '../../core/providers.dart';
import '../../db/app_database.dart';

/// One queued local change, in the order it must be sent.
class SyncOp {
  const SyncOp({
    required this.clientUuid,
    required this.entity,
    required this.entityId,
    required this.op,
    required this.payload,
    required this.createdAt,
    this.attempts = 0,
    this.lastError,
  });

  final String clientUuid;
  final String entity;
  final String entityId;
  final String op;

  /// JSON snapshot of the row as it was when the change was queued.
  final Map<String, Object?> payload;
  final int attempts;
  final String? lastError;
  final DateTime createdAt;

  Map<String, Object?> toJson() => {
        'clientUuid': clientUuid,
        'entity': entity,
        'entityId': entityId,
        'op': op,
        'payload': payload,
        'createdAt': createdAt.toIso8601String(),
      };
}

/// Result of draining the outbox.
class SyncDrainResult {
  const SyncDrainResult({required this.accepted, this.error});

  /// How many ops the transport confirmed. Oldest-first.
  final int accepted;

  /// Set when the transport failed; the head op keeps its place.
  final String? error;

  bool get isEmpty => accepted == 0 && error == null;
}

/// Where queued changes go. There is no server yet (PLAN.md Phase 1), so the
/// default transport accepts nothing and the queue simply waits.
abstract class SyncTransport {
  /// Push [ops] (oldest first) and return how many were accepted. Throwing
  /// marks the attempt failed; the ops stay queued for the next attempt.
  Future<int> push(List<SyncOp> ops);
}

class UnconfiguredSyncTransport implements SyncTransport {
  const UnconfiguredSyncTransport();

  @override
  Future<int> push(List<SyncOp> ops) async => 0;
}

/// Production HTTP sync transport connecting to RGPRS J&K Control Room server.
class HttpSyncTransport implements SyncTransport {
  const HttpSyncTransport();

  final String primaryUrl = 'http://localhost:4040/api/sync';
  final String emulatorUrl = 'http://10.0.2.2:4040/api/sync';

  @override
  Future<int> push(List<SyncOp> ops) async {
    if (ops.isEmpty) return 0;
    final jsonOps = ops.map((op) => op.toJson()).toList();
    return ApiClient.pushSync(jsonOps);
  }
}

/// Writes outbox rows. Call inside the same drift transaction as the row you
/// changed, so the edit and its queued op commit together.
class SyncOutboxWriter {
  SyncOutboxWriter(this._db, {DateTime Function()? now, Random? random})
      : _now = now ?? DateTime.now,
        _random = random ?? Random();

  final AppDatabase _db;
  final DateTime Function() _now;
  final Random _random;

  /// Queues an [op] for one row. Replaces any earlier queued op for the same
  /// row and operation: only the newest state matters to the server.
  Future<void> enqueue({
    required String entity,
    required String entityId,
    required String op,
    required Map<String, Object?> payload,
  }) async {
    await (_db.delete(_db.syncOutbox)
          ..where((t) =>
              t.entity.equals(entity) &
              t.entityId.equals(entityId) &
              t.op.equals(op)))
        .go();

    await _db.into(_db.syncOutbox).insert(
          SyncOutboxCompanion.insert(
            clientUuid: _newUuid(),
            entity: entity,
            entityId: entityId,
            op: op,
            payload: jsonEncode(payload),
            createdAt: _now(),
          ),
        );
  }

  String _newUuid() =>
      'op-${_now().microsecondsSinceEpoch.toRadixString(36)}'
      '-${_random.nextInt(0x7fffffff).toRadixString(36)}';
}

/// Drains the outbox through a [SyncTransport], oldest first, in batches.
class SyncEngine {
  SyncEngine(this._db, this._transport, {this.batchSize = 25});

  final AppDatabase _db;
  final SyncTransport _transport;
  final int batchSize;

  Future<int> pendingCount() async {
    final count = _db.syncOutbox.clientUuid.count();
    final query = _db.selectOnly(_db.syncOutbox)..addColumns([count]);
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }

  Future<List<SyncOp>> pending() async {
    final rows = await (_db.select(_db.syncOutbox)
          ..orderBy([
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.asc),
          ])
          ..limit(batchSize))
        .get();
    return [for (final row in rows) _fromRow(row)];
  }

  /// One attempt. Stops at the first failure or when the transport accepts
  /// nothing, so an unconfigured or unreachable server never spins.
  Future<SyncDrainResult> drainOnce() async {
    final ops = await pending();
    if (ops.isEmpty) return const SyncDrainResult(accepted: 0);

    int accepted;
    try {
      accepted = await _transport.push(ops);
    } catch (error) {
      await _markFailed(ops.first.clientUuid, '$error');
      return SyncDrainResult(accepted: 0, error: '$error');
    }

    if (accepted > 0) {
      final ids = ops.take(accepted).map((op) => op.clientUuid).toList();
      await (_db.delete(_db.syncOutbox)..where((t) => t.clientUuid.isIn(ids))).go();
    }
    return SyncDrainResult(accepted: accepted);
  }

  Future<void> _markFailed(String clientUuid, String error) async {
    final row = await (_db.select(_db.syncOutbox)
          ..where((t) => t.clientUuid.equals(clientUuid)))
        .getSingleOrNull();
    if (row == null) return;

    await (_db.update(_db.syncOutbox)
          ..where((t) => t.clientUuid.equals(clientUuid)))
        .write(SyncOutboxCompanion(
      attempts: Value(row.attempts + 1),
      lastError: Value(error),
    ));
  }

  SyncOp _fromRow(SyncOpRow row) => SyncOp(
        clientUuid: row.clientUuid,
        entity: row.entity,
        entityId: row.entityId,
        op: row.op,
        payload: (jsonDecode(row.payload) as Map).cast<String, Object?>(),
        attempts: row.attempts,
        lastError: row.lastError,
        createdAt: row.createdAt,
      );
}

final syncTransportProvider = Provider<SyncTransport>(
  (ref) => HttpSyncTransport(),
);

final syncOutboxProvider = Provider<SyncOutboxWriter>((ref) {
  return SyncOutboxWriter(ref.watch(appDatabaseProvider));
});

final syncEngineProvider = Provider<SyncEngine>((ref) {
  return SyncEngine(
    ref.watch(appDatabaseProvider),
    ref.watch(syncTransportProvider),
  );
});

/// How many local changes are still waiting to reach the server.
final pendingSyncCountProvider = FutureProvider.autoDispose<int>((ref) {
  return ref.watch(syncEngineProvider).pendingCount();
});
