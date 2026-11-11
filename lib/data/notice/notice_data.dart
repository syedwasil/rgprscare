import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api_client.dart';
import '../../core/providers.dart';
import '../../db/app_database.dart';
import '../sync/sync_data.dart';

enum NoticePriority {
  normal,
  urgent;

  static NoticePriority? tryParse(String value) {
    for (final priority in values) {
      if (priority.name == value) return priority;
    }
    return null;
  }

  String get labelKey => switch (this) {
        NoticePriority.normal => 'priorityNormal',
        NoticePriority.urgent => 'priorityUrgent',
      };
}

class Notice {
  const Notice({
    required this.id,
    required this.title,
    required this.body,
    required this.priority,
    required this.authorName,
    required this.createdAt,
    this.unitId,
    this.readAt,
  });

  final String id;
  final String title;
  final String body;
  final NoticePriority priority;

  /// Audience scope: an org unit id, or null meaning every unit.
  final String? unitId;
  final String authorName;
  final DateTime createdAt;

  /// Device-local read receipt; never uploaded.
  final DateTime? readAt;

  bool get isRead => readAt != null;

  /// What leaves the device: everything except the local read receipt.
  Map<String, Object?> toSyncPayload() => {
        'id': id,
        'title': title,
        'body': body,
        'priority': priority.name,
        'unitId': unitId,
        'authorName': authorName,
        'createdAt': createdAt.toIso8601String(),
      };

  @override
  bool operator ==(Object other) => other is Notice && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

abstract class NoticeRepository {
  /// Composes a notice and queues it for delivery in the same transaction.
  Future<Notice> create({
    required String title,
    required String body,
    required NoticePriority priority,
    required String authorName,
    String? unitId,
  });

  Future<List<Notice>> all();

  /// Records a local read receipt. Device-local only: who opened what is not
  /// uploaded (PLAN.md §8 privacy tiers).
  Future<void> markRead(String id, {DateTime? at});
}

final noticeRepositoryProvider = Provider<NoticeRepository>((ref) {
  return DriftNoticeRepository(
    ref.watch(appDatabaseProvider),
    SyncOutboxWriter(ref.watch(appDatabaseProvider)),
  );
});

final noticeListProvider = FutureProvider.autoDispose<List<Notice>>((ref) {
  return ref.watch(noticeRepositoryProvider).all();
});

final noticeProvider = FutureProvider.autoDispose.family<Notice?, String>(
  (ref, id) async {
    final all = await ref.watch(noticeRepositoryProvider).all();
    for (final notice in all) {
      if (notice.id == id) return notice;
    }
    return null;
  },
);

class DriftNoticeRepository implements NoticeRepository {
  DriftNoticeRepository(
    this._db,
    this._outbox, {
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  final AppDatabase _db;
  final SyncOutboxWriter _outbox;
  final DateTime Function() _now;

  @override
  Future<Notice> create({
    required String title,
    required String body,
    required NoticePriority priority,
    required String authorName,
    String? unitId,
  }) {
    return _db.transaction(() async {
      final now = _now();
      final id = 'ntc-${now.microsecondsSinceEpoch.toRadixString(36)}';

      await _db.into(_db.notices).insert(
            NoticesCompanion.insert(
              id: id,
              title: title,
              body: body,
              priority: priority.name,
              authorName: authorName,
              createdAt: now,
              unitId: Value(unitId),
            ),
          );

      final notice = Notice(
        id: id,
        title: title,
        body: body,
        priority: priority,
        authorName: authorName,
        createdAt: now,
        unitId: unitId,
      );

      await _outbox.enqueue(
        entity: 'notice',
        entityId: id,
        op: 'upsert',
        payload: notice.toSyncPayload(),
      );

      return notice;
    });
  }

  @override
  Future<List<Notice>> all() async {
    final query = _db.select(_db.notices)
      ..orderBy([
        (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
      ]);
    final initial = await query.get();
    if (initial.isEmpty) {
      await _seedDefaultNotices();
    }

    try {
      await syncRemoteNotices().timeout(const Duration(milliseconds: 2500));
    } catch (_) {}

    final rows = await query.get();
    return [for (final row in rows) _fromRow(row)];
  }

  Future<void> syncRemoteNotices() async {
    final str = await ApiClient.get('/api/notices');
    if (str == null) return;
    try {
      final list = (jsonDecode(str) as List).cast<Map<String, dynamic>>();
      for (final item in list) {
        final id = item['id'] as String? ?? '';
        if (id.isEmpty) continue;
        final existing = await (_db.select(_db.notices)..where((t) => t.id.equals(id))).getSingleOrNull();
        final prioStr = item['priority'] as String? ?? 'normal';
        final prio = (prioStr.toLowerCase() == 'urgent' || prioStr.toLowerCase() == 'high' || prioStr.toLowerCase() == 'critical')
            ? NoticePriority.urgent
            : NoticePriority.normal;
        DateTime createdAt;
        try {
          createdAt = DateTime.parse(item['createdAt'] as String);
        } catch (_) {
          createdAt = _now();
        }

        if (existing == null) {
          await _db.into(_db.notices).insert(
            NoticesCompanion.insert(
              id: id,
              title: item['title'] as String? ?? 'Official Notice',
              body: item['body'] as String? ?? '',
              priority: prio.name,
              authorName: item['authorName'] as String? ?? 'JKPCC & RGPRS HQ',
              createdAt: createdAt,
              unitId: Value(item['unitId'] as String?),
            ),
          );
        } else {
          await (_db.update(_db.notices)..where((t) => t.id.equals(id))).write(
            NoticesCompanion(
              title: Value(item['title'] as String? ?? existing.title),
              body: Value(item['body'] as String? ?? existing.body),
              priority: Value(prio.name),
              authorName: Value(item['authorName'] as String? ?? existing.authorName),
            ),
          );
        }
      }
    } catch (_) {}
  }

  Future<void> _seedDefaultNotices() async {
    final seeds = [
      (
        id: 'ntc-winter-sos-01',
        title: 'Chilla-i-Kalan Emergency Snow Clearance & Stretcher Helpline 24x7',
        body:
            'All 20 District Congress & RGPRS Control Rooms are operational across high-altitude cut-off passes (Sadhna, Razdan, Sinthan, Mughal Road). Village stretcher squads are on standby to transport patients to nearest SDH/GMC.',
        priority: NoticePriority.urgent,
        author: 'RGPRS & JKPCC Citizen Care HQ',
        hoursAgo: 2,
      ),
      (
        id: 'ntc-meter-dispute-02',
        title: 'Resolution on Smart Meter Billing Grievances & PDD Representation',
        body:
            'Citizens facing inflated electric bills or faulty digital meters can register disputes directly through the app. RGPRS legal coordinators are filing joint representations before the Joint Electricity Regulatory Commission and DC offices.',
        priority: NoticePriority.normal,
        author: 'JKPCC Energy & Public Welfare Cell',
        hoursAgo: 14,
      ),
      (
        id: 'ntc-youth-jobs-03',
        title: '1-Lakh Vacancy Restoration Youth Assembly Petition Drive',
        body:
            'Sign the youth memorandum in the Education & Youth wing of the app demanding immediate advertisement of vacant posts in JKSSB and JKPSC, strict anti-paper leak enforcement, and ₹3,000 monthly educated youth allowance.',
        priority: NoticePriority.normal,
        author: 'Rajiv Gandhi Panchayati Raj Sangathan Youth Mission',
        hoursAgo: 28,
      ),
    ];

    for (final s in seeds) {
      final created = _now().subtract(Duration(hours: s.hoursAgo));
      await _db.into(_db.notices).insert(
            NoticesCompanion.insert(
              id: s.id,
              title: s.title,
              body: s.body,
              priority: s.priority.name,
              authorName: s.author,
              createdAt: created,
            ),
          );
    }
  }

  @override
  Future<void> markRead(String id, {DateTime? at}) async {
    await (_db.update(_db.notices)..where((t) => t.id.equals(id))).write(
      NoticesCompanion(readAt: Value(at ?? _now())),
    );
  }

  Notice _fromRow(NoticeRow row) => Notice(
        id: row.id,
        title: row.title,
        body: row.body,
        priority: NoticePriority.tryParse(row.priority) ?? NoticePriority.normal,
        authorName: row.authorName,
        createdAt: row.createdAt,
        unitId: row.unitId,
        readAt: row.readAt,
      );
}
