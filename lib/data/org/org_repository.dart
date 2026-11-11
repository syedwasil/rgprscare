import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../db/app_database.dart';
import 'jk_geo_master.dart';
import 'org_models.dart';

/// Read side of the organisation tree.
///
/// Every method is async and served from the local database: the app must
/// work with the radio off (PLAN.md §5). The sync layer that pulls newer rows
/// from the server lands in Phase 1 and will sit behind this interface.
abstract class OrgRepository {
  Future<OrgUnit?> byId(String id);

  /// Direct children of [parentId], alphabetically ordered.
  /// Pass null to get the state root.
  Future<List<OrgUnit>> childrenOf(String? parentId);

  /// How many units of [type] exist locally.
  Future<int> countOfType(OrgUnitType type);

  /// Writes [units] if the local copy is empty. Idempotent.
  Future<void> ensureSeeded(List<OrgUnit> units);
}

final orgRepositoryProvider = Provider<OrgRepository>((ref) {
  return DriftOrgRepository(ref.watch(appDatabaseProvider));
});

/// Children of [parentId]; watching a different key re-queries only that node.
final orgChildrenProvider =
    FutureProvider.family<List<OrgUnit>, String?>((ref, parentId) async {
  final repo = ref.watch(orgRepositoryProvider);
  await repo.ensureSeeded(jkGeoMaster);
  return repo.childrenOf(parentId);
});

/// A single unit by id.
final orgUnitProvider = FutureProvider.family<OrgUnit?, String>((ref, id) async {
  final repo = ref.watch(orgRepositoryProvider);
  await repo.ensureSeeded(jkGeoMaster);
  return repo.byId(id);
});

/// Count of units of a given tier — used by the home dashboard.
final orgTypeCountProvider = FutureProvider.family<int, OrgUnitType>(
  (ref, type) => ref.watch(orgRepositoryProvider).countOfType(type),
);

/// Every district of J&K, flattened across both divisions and sorted.
/// Used by the grievance area picker and the membership form.
final districtsProvider = FutureProvider.autoDispose<List<OrgUnit>>(
  (ref) async {
    final repository = ref.watch(orgRepositoryProvider);
    try {
      await repository.ensureSeeded(jkGeoMaster);
      final divisions = await repository.childrenOf(jkStateUnitId);
      final districts = <OrgUnit>[
        for (final division in divisions)
          ...await repository.childrenOf(division.id),
      ];
      if (districts.isNotEmpty) {
        districts.sort(
          (a, b) => a.nameEn.toLowerCase().compareTo(b.nameEn.toLowerCase()),
        );
        return districts;
      }
    } catch (_) {}
    return jkAllDistricts;
  },
);

class DriftOrgRepository implements OrgRepository {
  DriftOrgRepository(this._db);

  final AppDatabase _db;

  @override
  Future<OrgUnit?> byId(String id) async {
    final row = await (_db.select(_db.orgUnits)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _fromRow(row);
  }

  @override
  Future<List<OrgUnit>> childrenOf(String? parentId) async {
    final query = _db.select(_db.orgUnits);
    if (parentId == null) {
      query.where((t) => t.parentId.isNull());
    } else {
      query.where((t) => t.parentId.equals(parentId));
    }
    query.orderBy([
      (t) => OrderingTerm(expression: t.nameEn, mode: OrderingMode.asc),
    ]);
    final rows = await query.get();
    return [for (final row in rows) _fromRow(row)];
  }

  @override
  Future<int> countOfType(OrgUnitType type) async {
    final count = _db.orgUnits.id.count();
    final query = _db.selectOnly(_db.orgUnits)
      ..addColumns([count])
      ..where(_db.orgUnits.type.equals(type.name));
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }

  @override
  Future<void> ensureSeeded(List<OrgUnit> units) {
    return _db.transaction(() async {
      final countRow = await _db.customSelect(
        'SELECT COUNT(*) as c FROM org_units',
        readsFrom: {_db.orgUnits},
      ).getSingle();
      final count = countRow.read<int>('c');
      if (count >= units.length) return;

      await _db.batch((batch) {
        batch.insertAllOnConflictUpdate(
          _db.orgUnits,
          [for (final unit in units) _toCompanion(unit)],
        );
      });
    });
  }

  OrgUnit _fromRow(OrgUnitRow row) {
    final type = OrgUnitType.tryParse(row.type);
    if (type == null) {
      throw StateError('org_units row ${row.id} has unknown type "${row.type}"');
    }
    return OrgUnit(
      id: row.id,
      type: type,
      nameEn: row.nameEn,
      nameHi: row.nameHi,
      nameUr: row.nameUr,
      parentId: row.parentId,
      geoCode: row.geoCode,
      centroid: row.centroid,
    );
  }

  OrgUnitsCompanion _toCompanion(OrgUnit unit) => OrgUnitsCompanion.insert(
        id: unit.id,
        type: unit.type.name,
        nameEn: unit.nameEn,
        nameHi: Value(unit.nameHi),
        nameUr: Value(unit.nameUr),
        parentId: Value(unit.parentId),
        geoCode: Value(unit.geoCode),
        centroid: Value(unit.centroid),
      );
}
