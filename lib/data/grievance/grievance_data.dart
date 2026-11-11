import 'dart:math';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../db/app_database.dart';
import '../sync/sync_data.dart';

/// What a grievance is about. Kept to the local-body subjects a halqa panchayat
/// or block can actually act on (PLAN.md §4).
enum GrievanceCategory {
  water,
  road,
  electricity,
  rations,
  mgnrega,
  pension,
  health,
  other;

  static GrievanceCategory? tryParse(String value) {
    for (final category in values) {
      if (category.name == value) return category;
    }
    return null;
  }

  String get labelKey => switch (this) {
        GrievanceCategory.water => 'categoryWater',
        GrievanceCategory.road => 'categoryRoad',
        GrievanceCategory.electricity => 'categoryElectricity',
        GrievanceCategory.rations => 'categoryRations',
        GrievanceCategory.mgnrega => 'categoryMgnrega',
        GrievanceCategory.pension => 'categoryPension',
        GrievanceCategory.health => 'categoryHealth',
        GrievanceCategory.other => 'categoryOther',
      };
}

enum GrievanceStatus {
  open,
  inProgress,
  resolved,
  closed;

  static GrievanceStatus? tryParse(String value) {
    for (final status in values) {
      if (status.name == value) return status;
    }
    return null;
  }

  bool get isClosed => this == resolved || this == closed;

  String get labelKey => switch (this) {
        GrievanceStatus.open => 'statusOpen',
        GrievanceStatus.inProgress => 'statusInProgress',
        GrievanceStatus.resolved => 'statusResolved',
        GrievanceStatus.closed => 'statusClosed',
      };
}

enum GrievanceEventType {
  created,
  statusChange,
  note;

  static GrievanceEventType? tryParse(String value) {
    for (final type in values) {
      if (type.name == value) return type;
    }
    return null;
  }
}

/// SLA policy for Jan Sunwai (PLAN.md §4): resolve within 5 days, escalate to
/// the block after 3 days and to the district after 7 while still open.
class GrievanceSla {
  const GrievanceSla._();

  static const resolveIn = Duration(days: 5);
  static const escalateToBlockAfter = Duration(days: 3);
  static const escalateToDistrictAfter = Duration(days: 7);

  static DateTime dueDateFor(DateTime createdAt) => createdAt.add(resolveIn);

  /// 0 = with the halqa representative, 1 = escalated to the block,
  /// 2 = escalated to the district.
  ///
  /// Derived at read time from the stored facts, so an escalation level can
  /// never go stale while the device is offline.
  static int escalationLevel({
    required DateTime createdAt,
    required DateTime? resolvedAt,
    required DateTime now,
  }) {
    if (resolvedAt != null) return 0;
    final age = now.difference(createdAt);
    if (age > escalateToDistrictAfter) return 2;
    if (age > escalateToBlockAfter) return 1;
    return 0;
  }
}

class Grievance {
  const Grievance({
    required this.id,
    required this.refCode,
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    required this.createdAt,
    this.unitId,
    this.reporterName,
    this.reporterPhone,
    this.resolvedAt,
    this.resolutionNote,
  });

  final String id;

  /// Human-quotable reference, e.g. `JK-G-261017-001`.
  final String refCode;
  final String title;
  final String description;
  final GrievanceCategory category;
  final GrievanceStatus status;
  final String? unitId;
  final String? reporterName;
  final String? reporterPhone;
  final DateTime createdAt;
  final DateTime? resolvedAt;
  final String? resolutionNote;

  DateTime get dueDate => GrievanceSla.dueDateFor(createdAt);

  int escalationLevelAt(DateTime now) => GrievanceSla.escalationLevel(
        createdAt: createdAt,
        resolvedAt: resolvedAt,
        now: now,
      );

  bool get isOpen => !status.isClosed;

  /// What leaves the device for this row.
  Map<String, Object?> toSyncPayload() => {
        'id': id,
        'refCode': refCode,
        'title': title,
        'description': description,
        'category': category.name,
        'status': status.name,
        'unitId': unitId,
        'reporterName': reporterName,
        'reporterPhone': reporterPhone,
        'createdAt': createdAt.toIso8601String(),
        'resolvedAt': resolvedAt?.toIso8601String(),
        'resolutionNote': resolutionNote,
      };

  @override
  bool operator ==(Object other) => other is Grievance && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Grievance($refCode, ${status.name})';
}

class GrievanceEvent {
  const GrievanceEvent({
    required this.id,
    required this.grievanceId,
    required this.type,
    required this.note,
    required this.createdAt,
    this.actorName,
  });

  final String id;
  final String grievanceId;
  final GrievanceEventType type;
  final String note;
  final String? actorName;
  final DateTime createdAt;

  Map<String, Object?> toSyncPayload() => {
        'id': id,
        'grievanceId': grievanceId,
        'type': type.name,
        'note': note,
        'actorName': actorName,
        'createdAt': createdAt.toIso8601String(),
      };

  @override
  bool operator ==(Object other) => other is GrievanceEvent && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

abstract class GrievanceRepository {
  /// Files a grievance and writes its first timeline entry atomically.
  Future<Grievance> create({
    required String title,
    required String description,
    required GrievanceCategory category,
    String? unitId,
    String? reporterName,
    String? reporterPhone,
  });

  Future<List<Grievance>> all();

  Future<Grievance?> byId(String id);

  /// Moves a grievance to a new status, stamping the resolution facts when it
  /// is closed and appending a timeline entry.
  Future<void> changeStatus(
    String id,
    GrievanceStatus status, {
    String? note,
  });

  Future<void> addNote(String id, String note);

  Future<List<GrievanceEvent>> eventsFor(String grievanceId);
}

final grievanceRepositoryProvider = Provider<GrievanceRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftGrievanceRepository(db, SyncOutboxWriter(db));
});

final grievanceListProvider =
    FutureProvider.autoDispose<List<Grievance>>((ref) {
  return ref.watch(grievanceRepositoryProvider).all();
});

final grievanceProvider =
    FutureProvider.autoDispose.family<Grievance?, String>((ref, id) {
  return ref.watch(grievanceRepositoryProvider).byId(id);
});

final grievanceEventsProvider =
    FutureProvider.autoDispose.family<List<GrievanceEvent>, String>(
  (ref, id) => ref.watch(grievanceRepositoryProvider).eventsFor(id),
);

class DriftGrievanceRepository implements GrievanceRepository {
  DriftGrievanceRepository(
    this._db,
    this._outbox, {
    DateTime Function()? now,
    Random? random,
  })  : _now = now ?? DateTime.now,
        _random = random ?? Random();

  final AppDatabase _db;
  final SyncOutboxWriter _outbox;
  final DateTime Function() _now;
  final Random _random;

  @override
  Future<Grievance> create({
    required String title,
    required String description,
    required GrievanceCategory category,
    String? unitId,
    String? reporterName,
    String? reporterPhone,
  }) {
    return _db.transaction(() async {
      final now = _now();
      final id = _newId(now);
      final refCode = await _nextRefCode(now);

      await _db.into(_db.grievances).insert(
            GrievancesCompanion.insert(
              id: id,
              refCode: refCode,
              title: title,
              description: description,
              category: category.name,
              status: GrievanceStatus.open.name,
              createdAt: now,
              unitId: Value(unitId),
              reporterName: Value(reporterName),
              reporterPhone: Value(reporterPhone),
            ),
          );

      await _db.into(_db.grievanceEvents).insert(
            GrievanceEventsCompanion.insert(
              id: _newId(now),
              grievanceId: id,
              type: GrievanceEventType.created.name,
              note: '',
              createdAt: now,
            ),
          );

      final grievance = Grievance(
        id: id,
        refCode: refCode,
        title: title,
        description: description,
        category: category,
        status: GrievanceStatus.open,
        createdAt: now,
        unitId: unitId,
        reporterName: reporterName,
        reporterPhone: reporterPhone,
      );

      await _outbox.enqueue(
        entity: 'grievance',
        entityId: id,
        op: 'upsert',
        payload: grievance.toSyncPayload(),
      );

      return grievance;
    });
  }

  @override
  Future<List<Grievance>> all() async {
    final query = _db.select(_db.grievances)
      ..orderBy([
        (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
      ]);
    return [for (final row in await query.get()) _fromRow(row)];
  }

  @override
  Future<Grievance?> byId(String id) async {
    final row = await (_db.select(_db.grievances)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _fromRow(row);
  }

  @override
  Future<void> changeStatus(
    String id,
    GrievanceStatus status, {
    String? note,
  }) {
    return _db.transaction(() async {
      final row = await (_db.select(_db.grievances)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (row == null) {
        throw StateError('grievance $id not found');
      }
      if (row.status == status.name) return;

      final now = _now();
      final closed = status.isClosed;

      await (_db.update(_db.grievances)..where((t) => t.id.equals(id))).write(
        GrievancesCompanion(
          status: Value(status.name),
          resolvedAt: Value(closed ? now : null),
          resolutionNote: Value(closed ? (note ?? row.resolutionNote) : row.resolutionNote),
        ),
      );

      final event = GrievanceEvent(
        id: _newId(now),
        grievanceId: id,
        type: GrievanceEventType.statusChange,
        note: note ?? '',
        createdAt: now,
      );

      await _db.into(_db.grievanceEvents).insert(
            GrievanceEventsCompanion.insert(
              id: event.id,
              grievanceId: event.grievanceId,
              type: event.type.name,
              note: event.note,
              createdAt: event.createdAt,
            ),
          );

      final updated = await (_db.select(_db.grievances)
            ..where((t) => t.id.equals(id)))
          .getSingle();
      await _outbox.enqueue(
        entity: 'grievance',
        entityId: id,
        op: 'upsert',
        payload: _fromRow(updated).toSyncPayload(),
      );
      await _outbox.enqueue(
        entity: 'grievance_event',
        entityId: event.id,
        op: 'upsert',
        payload: event.toSyncPayload(),
      );
    });
  }

  @override
  Future<void> addNote(String id, String note) {
    return _db.transaction(() async {
      final now = _now();
      final event = GrievanceEvent(
        id: _newId(now),
        grievanceId: id,
        type: GrievanceEventType.note,
        note: note,
        createdAt: now,
      );

      await _db.into(_db.grievanceEvents).insert(
            GrievanceEventsCompanion.insert(
              id: event.id,
              grievanceId: event.grievanceId,
              type: event.type.name,
              note: event.note,
              createdAt: event.createdAt,
            ),
          );

      await _outbox.enqueue(
        entity: 'grievance_event',
        entityId: event.id,
        op: 'upsert',
        payload: event.toSyncPayload(),
      );
    });
  }

  @override
  Future<List<GrievanceEvent>> eventsFor(String grievanceId) async {
    final query = _db.select(_db.grievanceEvents)
      ..where((t) => t.grievanceId.equals(grievanceId))
      ..orderBy([
        (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.asc),
      ]);
    return [
      for (final row in await query.get())
        GrievanceEvent(
          id: row.id,
          grievanceId: row.grievanceId,
          type: GrievanceEventType.tryParse(row.type) ?? GrievanceEventType.note,
          note: row.note,
          actorName: row.actorName,
          createdAt: row.createdAt,
        )
    ];
  }

  /// `JK-G-YYMMDD-NNN`, counting what has already been filed that day, so a
  /// worker can read it out over the phone. Server-side allocation replaces
  /// this when sync lands (PLAN.md §6).
  Future<String> _nextRefCode(DateTime now) async {
    final stamp =
        '${now.year.toString().substring(2)}${_two(now.month)}${_two(now.day)}';
    final prefix = 'JK-G-$stamp-';
    final filedToday = await (_db.select(_db.grievances)
          ..where((t) => t.refCode.like('$prefix%')))
        .get();
    return '$prefix${(filedToday.length + 1).toString().padLeft(3, '0')}';
  }

  String _two(int value) => value.toString().padLeft(2, '0');

  String _newId(DateTime now) =>
      'grv-${now.microsecondsSinceEpoch.toRadixString(36)}'
      '-${_random.nextInt(0x7fffffff).toRadixString(36)}';

  Grievance _fromRow(GrievanceRow row) => Grievance(
        id: row.id,
        refCode: row.refCode,
        title: row.title,
        description: row.description,
        category: GrievanceCategory.tryParse(row.category) ??
            GrievanceCategory.other,
        status: GrievanceStatus.tryParse(row.status) ?? GrievanceStatus.open,
        createdAt: row.createdAt,
        unitId: row.unitId,
        reporterName: row.reporterName,
        reporterPhone: row.reporterPhone,
        resolvedAt: row.resolvedAt,
        resolutionNote: row.resolutionNote,
      );
}
