import 'package:flutter_test/flutter_test.dart';
import 'package:rgprs_jk/data/org/jk_geo_master.dart';
import 'package:rgprs_jk/data/org/org_models.dart';

void main() {
  group('RGPRS & INC J&K Organization Hierarchy Tests', () {
    test('jkGeoMaster contains complete 4-tier structure (State, Division, 20 Districts, Blocks, Halqas)', () {
      final stateUnits = jkGeoMaster.where((u) => u.type == OrgUnitType.state).toList();
      expect(stateUnits.length, 1);
      expect(stateUnits.first.id, jkStateUnitId);

      final divisions = jkGeoMaster.where((u) => u.type == OrgUnitType.division).toList();
      expect(divisions.length, 2);

      final districts = jkGeoMaster.where((u) => u.type == OrgUnitType.district).toList();
      expect(districts.length, 20);

      final blocks = jkGeoMaster.where((u) => u.type == OrgUnitType.block).toList();
      expect(blocks.length, greaterThanOrEqualTo(20));

      final halqas = jkGeoMaster.where((u) => u.type == OrgUnitType.halqa).toList();
      expect(halqas.length, greaterThan(0));
    });

    test('All 20 districts have child blocks populated', () {
      final districts = jkGeoMaster.where((u) => u.type == OrgUnitType.district).toList();
      for (final dist in districts) {
        final childBlocks = jkGeoMaster.where((u) => u.parentId == dist.id).toList();
        expect(
          childBlocks.isNotEmpty,
          isTrue,
          reason: 'District ${dist.nameEn} (${dist.id}) must have sub-unit blocks',
        );
      }
    });

    test('getDccOffice returns leadership and official headquarters for all 20 districts', () {
      for (final distName in jkDistrictNames) {
        final office = getDccOffice(distName);
        expect(office, isNotNull, reason: 'DCC office info must exist for $distName');
        expect(office!.president.isNotEmpty, isTrue);
        expect(office.phone.isNotEmpty, isTrue);
        expect(office.officeAddress.isNotEmpty, isTrue);
      }
    });
  });
}

