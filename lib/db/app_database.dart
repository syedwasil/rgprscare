import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

/// Organisation tree rows. Local-only in Phase 1: this is the offline copy of
/// the master data that syncs with the server in later phases.
@DataClassName('OrgUnitRow')
class OrgUnits extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()();
  TextColumn get nameEn => text()();
  TextColumn get nameHi => text().nullable()();
  TextColumn get nameUr => text().nullable()();
  TextColumn get parentId => text().nullable()();
  TextColumn get geoCode => text().nullable()();

  /// Coarse "lat,lng" centroid — never an individual's coordinates.
  TextColumn get centroid => text().nullable()();
  IntColumn get revision => integer().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Per-device sync cursor (PLAN.md §6: pull by `revision > last_seen`).
@DataClassName('SyncCursorRow')
class SyncCursors extends Table {
  TextColumn get deviceKey => text()();
  IntColumn get lastRevision => integer().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {deviceKey};
}

/// One grievance filed through Jan Sunwai.
///
/// Written on the device first (offline-first) and synced later. Only source
/// facts are stored — the SLA clock and escalation level are derived from
/// [createdAt] and [status] at read time, so a stale derived value is
/// impossible.
@DataClassName('GrievanceRow')
class Grievances extends Table {
  TextColumn get id => text()();
  TextColumn get refCode => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get category => text()();

  /// Org unit this belongs to (district today, halqa once master data lands).
  TextColumn get unitId => text().nullable()();
  TextColumn get status => text()();

  /// Citizen the worker reports on behalf of. Optional and never published.
  TextColumn get reporterName => text().nullable()();
  TextColumn get reporterPhone => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get resolvedAt => dateTime().nullable()();
  TextColumn get resolutionNote => text().nullable()();
  IntColumn get revision => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Append-only timeline of a grievance (created, status change, note).
@DataClassName('GrievanceEventRow')
class GrievanceEvents extends Table {
  TextColumn get id => text()();
  TextColumn get grievanceId => text()();
  TextColumn get type => text()();
  TextColumn get note => text()();
  TextColumn get actorName => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get revision => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// The device owner's own RGPRS profile, used by the offline membership card.
/// Directory rows for other members arrive with the server sync.
@DataClassName('MemberRow')
class Members extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get role => text()();
  TextColumn get unitId => text().nullable()();

  /// pending until a block office bearer verifies it.
  TextColumn get status => text()();
  TextColumn get memberCode => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get verifiedAt => dateTime().nullable()();
  IntColumn get revision => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Queued local change waiting for the sync layer (PLAN.md §6): every write
/// that must eventually reach the server lands here first, inside the same
/// transaction as the row itself, so a crash can never lose an edit.
@DataClassName('SyncOpRow')
class SyncOutbox extends Table {
  /// Idempotency key — the server can safely apply the same op twice.
  TextColumn get clientUuid => text()();
  TextColumn get entity => text()();
  TextColumn get entityId => text()();
  TextColumn get op => text()();
  TextColumn get payload => text()();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {clientUuid};
}

/// In-app notice broadcast to a unit, composed on the device by an office
/// bearer and queued for delivery. Received notices arrive here after sync.
@DataClassName('NoticeRow')
class Notices extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get body => text()();
  TextColumn get priority => text()();

  /// Audience: an org unit id, or null for every unit.
  TextColumn get unitId => text().nullable()();
  TextColumn get authorName => text()();
  DateTimeColumn get createdAt => dateTime()();

  /// Device-local read receipt — never uploaded.
  DateTimeColumn get readAt => dateTime().nullable()();
  IntColumn get revision => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    OrgUnits,
    SyncCursors,
    Grievances,
    GrievanceEvents,
    Members,
    SyncOutbox,
    Notices,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'rgprs_jk'));

  /// Used by tests with an in-memory executor.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          // v1 contained only org_units + sync_cursors.
          if (from < 2) {
            await m.createTable(grievances);
            await m.createTable(grievanceEvents);
            await m.createTable(members);
          }
          // v3 added the sync outbox and the notices inbox.
          if (from < 3) {
            await m.createTable(syncOutbox);
            await m.createTable(notices);
          }
        },
      );
}
