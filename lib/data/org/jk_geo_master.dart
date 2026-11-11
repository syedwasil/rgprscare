/// Seed geography and party organisational structure for the J&K organisation tree.
///
/// Complete organizational hierarchy:
/// State Unit (PCC / State RGPRS)
///   -> Division Units (Kashmir & Jammu)
///     -> 20 District Units (DCC & District Panchayati Raj Sangathan)
///       -> Block Units (BCC & Block Panchayati Raj Sangathan)
///         -> Halqa Panchayats (Village Councils)
library;

import 'org_models.dart';

const String jkStateUnitId = 'unit-jk';

const List<String> jkDivisionIds = <String>['unit-div-kashmir', 'unit-div-jammu'];

/// DCC & RGPRS District Headquarters information
class DccOfficeInfo {
  const DccOfficeInfo({
    required this.districtId,
    required this.districtName,
    required this.president,
    required this.officeAddress,
    required this.phone,
    required this.rgprsCoordinator,
    required this.totalHalqas,
    required this.totalBlocks,
  });

  final String districtId;
  final String districtName;
  final String president;
  final String officeAddress;
  final String phone;
  final String rgprsCoordinator;
  final int totalHalqas;
  final int totalBlocks;
}

const Map<String, DccOfficeInfo> jkDccOffices = {
  'unit-dist-srinagar': DccOfficeInfo(
    districtId: 'unit-dist-srinagar',
    districtName: 'Srinagar',
    president: 'DCC President Srinagar / RGPRS J&K Cell',
    officeAddress: 'Congress Bhawan, M.A. Road, Srinagar, J&K 190001',
    phone: '0191-2578085',
    rgprsCoordinator: 'Panchayat Seva & Grievance Desk, Srinagar',
    totalHalqas: 146,
    totalBlocks: 6,
  ),
  'unit-dist-anantnag': DccOfficeInfo(
    districtId: 'unit-dist-anantnag',
    districtName: 'Anantnag',
    president: 'Peerzada Mohammad Syed / DCC President',
    officeAddress: 'District Congress Bhawan, K.P. Road, Anantnag, J&K 192101',
    phone: '0191-2578085',
    rgprsCoordinator: 'RGPRS District Coordinator, Anantnag',
    totalHalqas: 335,
    totalBlocks: 9,
  ),
  'unit-dist-baramulla': DccOfficeInfo(
    districtId: 'unit-dist-baramulla',
    districtName: 'Baramulla',
    president: 'DCC President Baramulla / RGPRS In-charge',
    officeAddress: 'Congress Office, Tehsil Road, Baramulla, J&K 193101',
    phone: '0191-2578085',
    rgprsCoordinator: 'Panchayati Raj Legal Aid Cell, Baramulla',
    totalHalqas: 402,
    totalBlocks: 7,
  ),
  'unit-dist-kupwara': DccOfficeInfo(
    districtId: 'unit-dist-kupwara',
    districtName: 'Kupwara',
    president: 'Haji Farooq Mir / DCC President Kupwara',
    officeAddress: 'DCC Congress Office, Bypass Road, Kupwara, J&K 193222',
    phone: '0191-2578085',
    rgprsCoordinator: 'Frontier Tribal & Border Welfare Desk',
    totalHalqas: 385,
    totalBlocks: 7,
  ),
  'unit-dist-pulwama': DccOfficeInfo(
    districtId: 'unit-dist-pulwama',
    districtName: 'Pulwama',
    president: 'DCC President Pulwama / RGPRS Council',
    officeAddress: 'District Congress Office, Rajpora Road, Pulwama 192301',
    phone: '0191-2578085',
    rgprsCoordinator: 'Saffron & Rural Workers Cell, Pulwama',
    totalHalqas: 190,
    totalBlocks: 6,
  ),
  'unit-dist-budgam': DccOfficeInfo(
    districtId: 'unit-dist-budgam',
    districtName: 'Budgam',
    president: 'DCC President Budgam / Central Coordination',
    officeAddress: 'Congress Office, Main Market, Budgam, J&K 191111',
    phone: '0191-2578085',
    rgprsCoordinator: 'Gram Sabha Empowerment Cell, Budgam',
    totalHalqas: 296,
    totalBlocks: 7,
  ),
  'unit-dist-kulgam': DccOfficeInfo(
    districtId: 'unit-dist-kulgam',
    districtName: 'Kulgam',
    president: 'DCC President Kulgam / RGPRS Council',
    officeAddress: 'Congress Office, Near Bus Stand, Kulgam, J&K 192231',
    phone: '0191-2578085',
    rgprsCoordinator: 'Panchayat Grievance Cell, Kulgam',
    totalHalqas: 178,
    totalBlocks: 6,
  ),
  'unit-dist-shopian': DccOfficeInfo(
    districtId: 'unit-dist-shopian',
    districtName: 'Shopian',
    president: 'DCC President Shopian / RGPRS In-charge',
    officeAddress: 'Congress Office, Main Chowk, Shopian, J&K 192303',
    phone: '0191-2578085',
    rgprsCoordinator: 'Apple Farmers & Panchayat Desk, Shopian',
    totalHalqas: 98,
    totalBlocks: 4,
  ),
  'unit-dist-ganderbal': DccOfficeInfo(
    districtId: 'unit-dist-ganderbal',
    districtName: 'Ganderbal',
    president: 'DCC President Ganderbal / RGPRS Mission',
    officeAddress: 'District Congress Office, Beehama, Ganderbal 191201',
    phone: '0191-2578085',
    rgprsCoordinator: 'Sindh Valley Rural Assistance Cell',
    totalHalqas: 126,
    totalBlocks: 5,
  ),
  'unit-dist-bandipora': DccOfficeInfo(
    districtId: 'unit-dist-bandipora',
    districtName: 'Bandipora',
    president: 'DCC President Bandipora / RGPRS Mission',
    officeAddress: 'Congress Office, Gulshan Chowk, Bandipora 193502',
    phone: '0191-2578085',
    rgprsCoordinator: 'Gurez & Sonawari Public Relief Cell',
    totalHalqas: 151,
    totalBlocks: 5,
  ),
  'unit-dist-jammu': DccOfficeInfo(
    districtId: 'unit-dist-jammu',
    districtName: 'Jammu',
    president: 'Yogesh Sawhney / DCC President Jammu',
    officeAddress: 'District Congress Bhawan, Shaheedi Chowk, Jammu 180001',
    phone: '0191-2578085',
    rgprsCoordinator: 'RGPRS Jammu Division Regional Headquarters',
    totalHalqas: 305,
    totalBlocks: 9,
  ),
  'unit-dist-kathua': DccOfficeInfo(
    districtId: 'unit-dist-kathua',
    districtName: 'Kathua',
    president: 'DCC President Kathua / RGPRS Council',
    officeAddress: 'Congress Bhawan, College Road, Kathua, J&K 184101',
    phone: '0191-2578085',
    rgprsCoordinator: 'Border Halqa & Karyakarta Cell, Kathua',
    totalHalqas: 257,
    totalBlocks: 8,
  ),
  'unit-dist-samba': DccOfficeInfo(
    districtId: 'unit-dist-samba',
    districtName: 'Samba',
    president: 'DCC President Samba / RGPRS Unit',
    officeAddress: 'Congress Office, National Highway, Samba 184121',
    phone: '0191-2578085',
    rgprsCoordinator: 'Industrial & Border Villages Coordination',
    totalHalqas: 101,
    totalBlocks: 6,
  ),
  'unit-dist-udhampur': DccOfficeInfo(
    districtId: 'unit-dist-udhampur',
    districtName: 'Udhampur',
    president: 'DCC President Udhampur / RGPRS Council',
    officeAddress: 'Congress Office, Mukherji Bazar, Udhampur 182101',
    phone: '0191-2578085',
    rgprsCoordinator: 'Panchayat & Rural Public Aid Desk',
    totalHalqas: 236,
    totalBlocks: 7,
  ),
  'unit-dist-reasi': DccOfficeInfo(
    districtId: 'unit-dist-reasi',
    districtName: 'Reasi',
    president: 'DCC President Reasi / RGPRS Unit',
    officeAddress: 'District Congress Office, Main Bus Stand, Reasi 182311',
    phone: '0191-2578085',
    rgprsCoordinator: 'Pahari & Hill Area Public Welfare Cell',
    totalHalqas: 147,
    totalBlocks: 7,
  ),
  'unit-dist-rajouri': DccOfficeInfo(
    districtId: 'unit-dist-rajouri',
    districtName: 'Rajouri',
    president: 'DCC President Rajouri / RGPRS Council',
    officeAddress: 'Congress Office, Gujjar Mandi, Rajouri, J&K 185131',
    phone: '0191-2578085',
    rgprsCoordinator: 'Tribal & Border Halqa Rights Mission',
    totalHalqas: 312,
    totalBlocks: 8,
  ),
  'unit-dist-poonch': DccOfficeInfo(
    districtId: 'unit-dist-poonch',
    districtName: 'Poonch',
    president: 'DCC President Poonch / RGPRS Unit',
    officeAddress: 'Congress Office, Fort Road, Poonch, J&K 185101',
    phone: '0191-2578085',
    rgprsCoordinator: 'Pir Panjal Panchayati Raj Cell',
    totalHalqas: 229,
    totalBlocks: 6,
  ),
  'unit-dist-doda': DccOfficeInfo(
    districtId: 'unit-dist-doda',
    districtName: 'Doda',
    president: 'DCC President Doda / RGPRS Council',
    officeAddress: 'Congress Office, Pul Doda / Bus Stand, Doda 182202',
    phone: '0191-2578085',
    rgprsCoordinator: 'Chenab Valley Remote Panchayat Desk',
    totalHalqas: 232,
    totalBlocks: 8,
  ),
  'unit-dist-kishtwar': DccOfficeInfo(
    districtId: 'unit-dist-kishtwar',
    districtName: 'Kishtwar',
    president: 'DCC President Kishtwar / RGPRS Unit',
    officeAddress: 'Congress Office, Chowgan Ground, Kishtwar 182204',
    phone: '0191-2578085',
    rgprsCoordinator: 'Marwah-Warwan-Paddar Relief Desk',
    totalHalqas: 156,
    totalBlocks: 7,
  ),
  'unit-dist-ramban': DccOfficeInfo(
    districtId: 'unit-dist-ramban',
    districtName: 'Ramban',
    president: 'DCC President Ramban / RGPRS Council',
    officeAddress: 'Congress Office, Main Bazar, Banihal / Ramban 182144',
    phone: '0191-2578085',
    rgprsCoordinator: 'Banihal & Highway Panchayati Raj Cell',
    totalHalqas: 142,
    totalBlocks: 7,
  ),
};

DccOfficeInfo? getDccOffice(String unitIdOrName) {
  if (jkDccOffices.containsKey(unitIdOrName)) {
    return jkDccOffices[unitIdOrName];
  }
  for (final office in jkDccOffices.values) {
    if (office.districtName.toLowerCase() == unitIdOrName.toLowerCase()) {
      return office;
    }
  }
  return null;
}

const List<OrgUnit> jkGeoMaster = <OrgUnit>[
  // ---- Root -------------------------------------------------------------
  OrgUnit(
    id: jkStateUnitId,
    type: OrgUnitType.state,
    nameEn: 'Jammu & Kashmir',
    nameHi: 'जम्मू और कश्मीर',
    nameUr: 'جموں و کشمیر',
    centroid: '33.7782,76.5762',
  ),

  // ---- Division: Kashmir (10 districts) --------------------------------
  OrgUnit(
    id: 'unit-div-kashmir',
    type: OrgUnitType.division,
    nameEn: 'Kashmir Division',
    nameHi: 'कश्मीर मंडल',
    nameUr: 'کشمیر شعبہ',
    parentId: jkStateUnitId,
    centroid: '34.0837,74.7973',
  ),
  OrgUnit(
    id: 'unit-dist-srinagar',
    type: OrgUnitType.district,
    nameEn: 'Srinagar',
    nameHi: 'श्रीनगर',
    nameUr: 'سرینگر',
    parentId: 'unit-div-kashmir',
    centroid: '34.0837,74.7973',
  ),
  OrgUnit(
    id: 'unit-dist-anantnag',
    type: OrgUnitType.district,
    nameEn: 'Anantnag',
    nameHi: 'अनंतनाग',
    nameUr: 'اننتھنگ',
    parentId: 'unit-div-kashmir',
    centroid: '33.7311,75.1487',
  ),
  OrgUnit(
    id: 'unit-dist-kulgam',
    type: OrgUnitType.district,
    nameEn: 'Kulgam',
    nameHi: 'कुलगाम',
    nameUr: 'کلگام',
    parentId: 'unit-div-kashmir',
    centroid: '33.6411,75.0200',
  ),
  OrgUnit(
    id: 'unit-dist-shopian',
    type: OrgUnitType.district,
    nameEn: 'Shopian',
    nameHi: 'शोपियां',
    nameUr: 'شوپیاں',
    parentId: 'unit-div-kashmir',
    centroid: '33.7100,74.8300',
  ),
  OrgUnit(
    id: 'unit-dist-pulwama',
    type: OrgUnitType.district,
    nameEn: 'Pulwama',
    nameHi: 'पुलवामा',
    nameUr: 'پلواں',
    parentId: 'unit-div-kashmir',
    centroid: '33.8741,74.8991',
  ),
  OrgUnit(
    id: 'unit-dist-budgam',
    type: OrgUnitType.district,
    nameEn: 'Budgam',
    nameHi: 'बडगाम',
    nameUr: 'بڈگام',
    parentId: 'unit-div-kashmir',
    centroid: '33.9100,74.5800',
  ),
  OrgUnit(
    id: 'unit-dist-baramulla',
    type: OrgUnitType.district,
    nameEn: 'Baramulla',
    nameHi: 'बारामुला',
    nameUr: 'بارہ مُلہ',
    parentId: 'unit-div-kashmir',
    centroid: '34.2084,74.3425',
  ),
  OrgUnit(
    id: 'unit-dist-kupwara',
    type: OrgUnitType.district,
    nameEn: 'Kupwara',
    nameHi: 'कुपवाड़ा',
    nameUr: 'کپورہ',
    parentId: 'unit-div-kashmir',
    centroid: '34.5269,74.1844',
  ),
  OrgUnit(
    id: 'unit-dist-bandipora',
    type: OrgUnitType.district,
    nameEn: 'Bandipora',
    nameHi: 'बांदीपोरा',
    nameUr: 'بندی پورہ',
    parentId: 'unit-div-kashmir',
    centroid: '34.4170,74.6400',
  ),
  OrgUnit(
    id: 'unit-dist-ganderbal',
    type: OrgUnitType.district,
    nameEn: 'Ganderbal',
    nameHi: 'गंदरबल',
    nameUr: 'گندربال',
    parentId: 'unit-div-kashmir',
    centroid: '34.1700,74.8000',
  ),

  // ---- Division: Jammu (10 districts) ----------------------------------
  OrgUnit(
    id: 'unit-div-jammu',
    type: OrgUnitType.division,
    nameEn: 'Jammu Division',
    nameHi: 'जम्मू मंडल',
    nameUr: 'جموں شعبہ',
    parentId: jkStateUnitId,
    centroid: '32.7266,74.8570',
  ),
  OrgUnit(
    id: 'unit-dist-jammu',
    type: OrgUnitType.district,
    nameEn: 'Jammu',
    nameHi: 'जम्मू',
    nameUr: 'جموں',
    parentId: 'unit-div-jammu',
    centroid: '32.7266,74.8570',
  ),
  OrgUnit(
    id: 'unit-dist-kathua',
    type: OrgUnitType.district,
    nameEn: 'Kathua',
    nameHi: 'कठुआ',
    nameUr: 'کٹھوا',
    parentId: 'unit-div-jammu',
    centroid: '32.3850,75.5200',
  ),
  OrgUnit(
    id: 'unit-dist-samba',
    type: OrgUnitType.district,
    nameEn: 'Samba',
    nameHi: 'सांबा',
    nameUr: 'سمبہ',
    parentId: 'unit-div-jammu',
    centroid: '32.4100,75.1000',
  ),
  OrgUnit(
    id: 'unit-dist-udhampur',
    type: OrgUnitType.district,
    nameEn: 'Udhampur',
    nameHi: 'उधमपुर',
    nameUr: 'ادھم پور',
    parentId: 'unit-div-jammu',
    centroid: '32.9200,75.3100',
  ),
  OrgUnit(
    id: 'unit-dist-reasi',
    type: OrgUnitType.district,
    nameEn: 'Reasi',
    nameHi: 'रियासी',
    nameUr: 'ریاسی',
    parentId: 'unit-div-jammu',
    centroid: '33.1000,74.8000',
  ),
  OrgUnit(
    id: 'unit-dist-rajouri',
    type: OrgUnitType.district,
    nameEn: 'Rajouri',
    nameHi: 'राजौरी',
    nameUr: 'راجوری',
    parentId: 'unit-div-jammu',
    centroid: '33.3800,74.3000',
  ),
  OrgUnit(
    id: 'unit-dist-poonch',
    type: OrgUnitType.district,
    nameEn: 'Poonch',
    nameHi: 'पुंछ',
    nameUr: 'پُنچ',
    parentId: 'unit-div-jammu',
    centroid: '33.7600,74.1000',
  ),
  OrgUnit(
    id: 'unit-dist-doda',
    type: OrgUnitType.district,
    nameEn: 'Doda',
    nameHi: 'डोडा',
    nameUr: 'ڈوڈہ',
    parentId: 'unit-div-jammu',
    centroid: '33.1500,75.5400',
  ),
  OrgUnit(
    id: 'unit-dist-kishtwar',
    type: OrgUnitType.district,
    nameEn: 'Kishtwar',
    nameHi: 'किश्तवाड़',
    nameUr: 'کشتواڑ',
    parentId: 'unit-div-jammu',
    centroid: '33.3100,75.7700',
  ),
  OrgUnit(
    id: 'unit-dist-ramban',
    type: OrgUnitType.district,
    nameEn: 'Ramban',
    nameHi: 'रामबाण',
    nameUr: 'رام بان',
    parentId: 'unit-div-jammu',
    centroid: '33.3200,75.1900',
  ),

  // =========================================================================
  // BLOCKS (Block Congress Committees & RGPRS Blocks)
  // =========================================================================

  // --- Srinagar Blocks ---
  OrgUnit(
    id: 'unit-blk-srn-central',
    type: OrgUnitType.block,
    nameEn: 'Srinagar Central Block',
    nameUr: 'سرینگر سینٹرل بلاک',
    parentId: 'unit-dist-srinagar',
  ),
  OrgUnit(
    id: 'unit-blk-srn-batamaloo',
    type: OrgUnitType.block,
    nameEn: 'Batamaloo Block',
    nameUr: 'بٹہ مالو بلاک',
    parentId: 'unit-dist-srinagar',
  ),
  OrgUnit(
    id: 'unit-blk-srn-hazratbal',
    type: OrgUnitType.block,
    nameEn: 'Hazratbal Block',
    nameUr: 'حضرت بل بلاک',
    parentId: 'unit-dist-srinagar',
  ),
  OrgUnit(
    id: 'unit-blk-srn-zadibal',
    type: OrgUnitType.block,
    nameEn: 'Zadibal Block',
    nameUr: 'ژادئ بل بلاک',
    parentId: 'unit-dist-srinagar',
  ),
  OrgUnit(
    id: 'unit-blk-srn-eidgah',
    type: OrgUnitType.block,
    nameEn: 'Eidgah Block',
    nameUr: 'عیدگاہ بلاک',
    parentId: 'unit-dist-srinagar',
  ),

  // --- Anantnag Blocks ---
  OrgUnit(
    id: 'unit-blk-ant-anantnag',
    type: OrgUnitType.block,
    nameEn: 'Anantnag Block',
    nameUr: 'اننت ناگ بلاک',
    parentId: 'unit-dist-anantnag',
  ),
  OrgUnit(
    id: 'unit-blk-ant-bijbehara',
    type: OrgUnitType.block,
    nameEn: 'Bijbehara Block',
    nameUr: 'بجبہاڑہ بلاک',
    parentId: 'unit-dist-anantnag',
  ),
  OrgUnit(
    id: 'unit-blk-ant-pahalgam',
    type: OrgUnitType.block,
    nameEn: 'Pahalgam Block',
    nameUr: 'پہلگام بلاک',
    parentId: 'unit-dist-anantnag',
  ),
  OrgUnit(
    id: 'unit-blk-ant-dooru',
    type: OrgUnitType.block,
    nameEn: 'Dooru Block',
    nameUr: 'ڈورو شاہ آباد بلاک',
    parentId: 'unit-dist-anantnag',
  ),
  OrgUnit(
    id: 'unit-blk-ant-kokernag',
    type: OrgUnitType.block,
    nameEn: 'Kokernag Block',
    nameUr: 'کوکرناگ بلاک',
    parentId: 'unit-dist-anantnag',
  ),
  OrgUnit(
    id: 'unit-blk-ant-shangus',
    type: OrgUnitType.block,
    nameEn: 'Shangus Block',
    nameUr: 'شانگس بلاک',
    parentId: 'unit-dist-anantnag',
  ),
  OrgUnit(
    id: 'unit-blk-ant-mattan',
    type: OrgUnitType.block,
    nameEn: 'Mattan Block',
    nameUr: 'متن بلاک',
    parentId: 'unit-dist-anantnag',
  ),

  // --- Baramulla Blocks ---
  OrgUnit(
    id: 'unit-blk-bar-baramulla',
    type: OrgUnitType.block,
    nameEn: 'Baramulla Block',
    nameUr: 'بارہمولہ بلاک',
    parentId: 'unit-dist-baramulla',
  ),
  OrgUnit(
    id: 'unit-blk-bar-sopore',
    type: OrgUnitType.block,
    nameEn: 'Sopore Block',
    nameUr: 'سوپور بلاک',
    parentId: 'unit-dist-baramulla',
  ),
  OrgUnit(
    id: 'unit-blk-bar-uri',
    type: OrgUnitType.block,
    nameEn: 'Uri Block',
    nameUr: 'اوڑی بلاک',
    parentId: 'unit-dist-baramulla',
  ),
  OrgUnit(
    id: 'unit-blk-bar-pattan',
    type: OrgUnitType.block,
    nameEn: 'Pattan Block',
    nameUr: 'پٹن بلاک',
    parentId: 'unit-dist-baramulla',
  ),
  OrgUnit(
    id: 'unit-blk-bar-tangmarg',
    type: OrgUnitType.block,
    nameEn: 'Tangmarg (Gulmarg) Block',
    nameUr: 'ٹنگمرگ بلاک',
    parentId: 'unit-dist-baramulla',
  ),
  OrgUnit(
    id: 'unit-blk-bar-rafiabad',
    type: OrgUnitType.block,
    nameEn: 'Rafiabad Block',
    nameUr: 'رفیع آباد بلاک',
    parentId: 'unit-dist-baramulla',
  ),

  // --- Kupwara Blocks ---
  OrgUnit(
    id: 'unit-blk-kup-kupwara',
    type: OrgUnitType.block,
    nameEn: 'Kupwara Block',
    nameUr: 'کپواڑہ بلاک',
    parentId: 'unit-dist-kupwara',
  ),
  OrgUnit(
    id: 'unit-blk-kup-handwara',
    type: OrgUnitType.block,
    nameEn: 'Handwara Block',
    nameUr: 'ہندواڑہ بلاک',
    parentId: 'unit-dist-kupwara',
  ),
  OrgUnit(
    id: 'unit-blk-kup-karnah',
    type: OrgUnitType.block,
    nameEn: 'Karnah (Tangdhar) Block',
    nameUr: 'کرناہ تیتوال بلاک',
    parentId: 'unit-dist-kupwara',
  ),
  OrgUnit(
    id: 'unit-blk-kup-sogam',
    type: OrgUnitType.block,
    nameEn: 'Sogam (Lolab) Block',
    nameUr: 'سوگام لولاب بلاک',
    parentId: 'unit-dist-kupwara',
  ),
  OrgUnit(
    id: 'unit-blk-kup-trehgam',
    type: OrgUnitType.block,
    nameEn: 'Trehgam Block',
    nameUr: 'ترہگام بلاک',
    parentId: 'unit-dist-kupwara',
  ),

  // --- Pulwama Blocks ---
  OrgUnit(
    id: 'unit-blk-pul-pulwama',
    type: OrgUnitType.block,
    nameEn: 'Pulwama Block',
    nameUr: 'پلوامہ بلاک',
    parentId: 'unit-dist-pulwama',
  ),
  OrgUnit(
    id: 'unit-blk-pul-pampore',
    type: OrgUnitType.block,
    nameEn: 'Pampore Block',
    nameUr: 'پامپور بلاک',
    parentId: 'unit-dist-pulwama',
  ),
  OrgUnit(
    id: 'unit-blk-pul-tral',
    type: OrgUnitType.block,
    nameEn: 'Tral Block',
    nameUr: 'ترال بلاک',
    parentId: 'unit-dist-pulwama',
  ),
  OrgUnit(
    id: 'unit-blk-pul-kakapora',
    type: OrgUnitType.block,
    nameEn: 'Kakapora Block',
    nameUr: 'کاکاپورہ بلاک',
    parentId: 'unit-dist-pulwama',
  ),

  // --- Budgam Blocks ---
  OrgUnit(
    id: 'unit-blk-bud-budgam',
    type: OrgUnitType.block,
    nameEn: 'Budgam Block',
    nameUr: 'بڈگام بلاک',
    parentId: 'unit-dist-budgam',
  ),
  OrgUnit(
    id: 'unit-blk-bud-chadoora',
    type: OrgUnitType.block,
    nameEn: 'Chadoora Block',
    nameUr: 'چڈورہ بلاک',
    parentId: 'unit-dist-budgam',
  ),
  OrgUnit(
    id: 'unit-blk-bud-beerwah',
    type: OrgUnitType.block,
    nameEn: 'Beerwah Block',
    nameUr: 'بیروہ بلاک',
    parentId: 'unit-dist-budgam',
  ),
  OrgUnit(
    id: 'unit-blk-bud-khansahib',
    type: OrgUnitType.block,
    nameEn: 'Khansahib Block',
    nameUr: 'خان صاحب بلاک',
    parentId: 'unit-dist-budgam',
  ),

  // --- Kulgam Blocks ---
  OrgUnit(
    id: 'unit-blk-kul-kulgam',
    type: OrgUnitType.block,
    nameEn: 'Kulgam Block',
    nameUr: 'کلگام بلاک',
    parentId: 'unit-dist-kulgam',
  ),
  OrgUnit(
    id: 'unit-blk-kul-devsar',
    type: OrgUnitType.block,
    nameEn: 'Devsar Block',
    nameUr: 'دیوسر بلاک',
    parentId: 'unit-dist-kulgam',
  ),
  OrgUnit(
    id: 'unit-blk-kul-dhpora',
    type: OrgUnitType.block,
    nameEn: 'D.H. Pora Block',
    nameUr: 'ڈی ایچ پورہ بلاک',
    parentId: 'unit-dist-kulgam',
  ),
  OrgUnit(
    id: 'unit-blk-kul-yaripora',
    type: OrgUnitType.block,
    nameEn: 'Yaripora Block',
    nameUr: 'یاری پورہ بلاک',
    parentId: 'unit-dist-kulgam',
  ),

  // --- Shopian Blocks ---
  OrgUnit(
    id: 'unit-blk-shp-shopian',
    type: OrgUnitType.block,
    nameEn: 'Shopian Block',
    nameUr: 'شپیاں بلاک',
    parentId: 'unit-dist-shopian',
  ),
  OrgUnit(
    id: 'unit-blk-shp-keller',
    type: OrgUnitType.block,
    nameEn: 'Keller Block',
    nameUr: 'کیلر بلاک',
    parentId: 'unit-dist-shopian',
  ),
  OrgUnit(
    id: 'unit-blk-shp-zainapora',
    type: OrgUnitType.block,
    nameEn: 'Zainapora Block',
    nameUr: 'زینہ پورہ بلاک',
    parentId: 'unit-dist-shopian',
  ),

  // --- Ganderbal Blocks ---
  OrgUnit(
    id: 'unit-blk-gan-ganderbal',
    type: OrgUnitType.block,
    nameEn: 'Ganderbal Block',
    nameUr: 'گندربل بلاک',
    parentId: 'unit-dist-ganderbal',
  ),
  OrgUnit(
    id: 'unit-blk-gan-kangan',
    type: OrgUnitType.block,
    nameEn: 'Kangan Block',
    nameUr: 'کنگن بلاک',
    parentId: 'unit-dist-ganderbal',
  ),
  OrgUnit(
    id: 'unit-blk-gan-lar',
    type: OrgUnitType.block,
    nameEn: 'Lar Block',
    nameUr: 'لار بلاک',
    parentId: 'unit-dist-ganderbal',
  ),

  // --- Bandipora Blocks ---
  OrgUnit(
    id: 'unit-blk-bdp-bandipora',
    type: OrgUnitType.block,
    nameEn: 'Bandipora Block',
    nameUr: 'باندی پورہ بلاک',
    parentId: 'unit-dist-bandipora',
  ),
  OrgUnit(
    id: 'unit-blk-bdp-sonawari',
    type: OrgUnitType.block,
    nameEn: 'Sonawari (Sumbal) Block',
    nameUr: 'سوناوری بلاک',
    parentId: 'unit-dist-bandipora',
  ),
  OrgUnit(
    id: 'unit-blk-bdp-gurez',
    type: OrgUnitType.block,
    nameEn: 'Gurez & Tulail Block',
    nameUr: 'گریز تلیل بلاک',
    parentId: 'unit-dist-bandipora',
  ),

  // --- Jammu Blocks ---
  OrgUnit(
    id: 'unit-blk-jam-north',
    type: OrgUnitType.block,
    nameEn: 'Jammu North Block',
    nameUr: 'جموں نارتھ بلاک',
    parentId: 'unit-dist-jammu',
  ),
  OrgUnit(
    id: 'unit-blk-jam-south',
    type: OrgUnitType.block,
    nameEn: 'Jammu South Block',
    nameUr: 'جموں ساؤتھ بلاک',
    parentId: 'unit-dist-jammu',
  ),
  OrgUnit(
    id: 'unit-blk-jam-akhnoor',
    type: OrgUnitType.block,
    nameEn: 'Akhnoor Block',
    nameUr: 'اخنور بلاک',
    parentId: 'unit-dist-jammu',
  ),
  OrgUnit(
    id: 'unit-blk-jam-rspura',
    type: OrgUnitType.block,
    nameEn: 'R.S. Pura Block',
    nameUr: 'آر ایس پورہ بلاک',
    parentId: 'unit-dist-jammu',
  ),
  OrgUnit(
    id: 'unit-blk-jam-bishnah',
    type: OrgUnitType.block,
    nameEn: 'Bishnah Block',
    nameUr: 'بشناہ بلاک',
    parentId: 'unit-dist-jammu',
  ),
  OrgUnit(
    id: 'unit-blk-jam-marh',
    type: OrgUnitType.block,
    nameEn: 'Marh Block',
    nameUr: 'مڑھ بلاک',
    parentId: 'unit-dist-jammu',
  ),
  OrgUnit(
    id: 'unit-blk-jam-nagrota',
    type: OrgUnitType.block,
    nameEn: 'Nagrota Block',
    nameUr: 'نگروٹہ بلاک',
    parentId: 'unit-dist-jammu',
  ),

  // --- Kathua Blocks ---
  OrgUnit(
    id: 'unit-blk-kat-kathua',
    type: OrgUnitType.block,
    nameEn: 'Kathua Block',
    nameUr: 'کٹھوعہ بلاک',
    parentId: 'unit-dist-kathua',
  ),
  OrgUnit(
    id: 'unit-blk-kat-hiranagar',
    type: OrgUnitType.block,
    nameEn: 'Hiranagar Block',
    nameUr: 'ہیرانگر بلاک',
    parentId: 'unit-dist-kathua',
  ),
  OrgUnit(
    id: 'unit-blk-kat-billawar',
    type: OrgUnitType.block,
    nameEn: 'Billawar Block',
    nameUr: 'بلاور بلاک',
    parentId: 'unit-dist-kathua',
  ),
  OrgUnit(
    id: 'unit-blk-kat-basohli',
    type: OrgUnitType.block,
    nameEn: 'Basohli Block',
    nameUr: 'بسوپلی بلاک',
    parentId: 'unit-dist-kathua',
  ),
  OrgUnit(
    id: 'unit-blk-kat-bani',
    type: OrgUnitType.block,
    nameEn: 'Bani Block',
    nameUr: 'بنی بلاک',
    parentId: 'unit-dist-kathua',
  ),

  // --- Samba Blocks ---
  OrgUnit(
    id: 'unit-blk-sam-samba',
    type: OrgUnitType.block,
    nameEn: 'Samba Block',
    nameUr: 'سامبا بلاک',
    parentId: 'unit-dist-samba',
  ),
  OrgUnit(
    id: 'unit-blk-sam-vijaypur',
    type: OrgUnitType.block,
    nameEn: 'Vijaypur Block',
    nameUr: 'وجے پور بلاک',
    parentId: 'unit-dist-samba',
  ),
  OrgUnit(
    id: 'unit-blk-sam-ramgarh',
    type: OrgUnitType.block,
    nameEn: 'Ramgarh Block',
    nameUr: 'رام گڑھ بلاک',
    parentId: 'unit-dist-samba',
  ),

  // --- Udhampur Blocks ---
  OrgUnit(
    id: 'unit-blk-udh-udhampur',
    type: OrgUnitType.block,
    nameEn: 'Udhampur Block',
    nameUr: 'ادھم پور بلاک',
    parentId: 'unit-dist-udhampur',
  ),
  OrgUnit(
    id: 'unit-blk-udh-ramnagar',
    type: OrgUnitType.block,
    nameEn: 'Ramnagar Block',
    nameUr: 'رام نگر بلاک',
    parentId: 'unit-dist-udhampur',
  ),
  OrgUnit(
    id: 'unit-blk-udh-chenani',
    type: OrgUnitType.block,
    nameEn: 'Chenani Block',
    nameUr: 'چینانی بلاک',
    parentId: 'unit-dist-udhampur',
  ),
  OrgUnit(
    id: 'unit-blk-udh-majalta',
    type: OrgUnitType.block,
    nameEn: 'Majalta Block',
    nameUr: 'مجلتہ بلاک',
    parentId: 'unit-dist-udhampur',
  ),

  // --- Reasi Blocks ---
  OrgUnit(
    id: 'unit-blk-rea-reasi',
    type: OrgUnitType.block,
    nameEn: 'Reasi Block',
    nameUr: 'ریاسی بلاک',
    parentId: 'unit-dist-reasi',
  ),
  OrgUnit(
    id: 'unit-blk-rea-katra',
    type: OrgUnitType.block,
    nameEn: 'Katra Block',
    nameUr: 'کٹرا بلاک',
    parentId: 'unit-dist-reasi',
  ),
  OrgUnit(
    id: 'unit-blk-rea-mahore',
    type: OrgUnitType.block,
    nameEn: 'Mahore Block',
    nameUr: 'ماہور بلاک',
    parentId: 'unit-dist-reasi',
  ),
  OrgUnit(
    id: 'unit-blk-rea-pouni',
    type: OrgUnitType.block,
    nameEn: 'Pouni Block',
    nameUr: 'پونی بلاک',
    parentId: 'unit-dist-reasi',
  ),

  // --- Rajouri Blocks ---
  OrgUnit(
    id: 'unit-blk-raj-rajouri',
    type: OrgUnitType.block,
    nameEn: 'Rajouri Block',
    nameUr: 'راجوری بلاک',
    parentId: 'unit-dist-rajouri',
  ),
  OrgUnit(
    id: 'unit-blk-raj-thanamandi',
    type: OrgUnitType.block,
    nameEn: 'Thanamandi Block',
    nameUr: 'تھنہ منڈی بلاک',
    parentId: 'unit-dist-rajouri',
  ),
  OrgUnit(
    id: 'unit-blk-raj-nowshera',
    type: OrgUnitType.block,
    nameEn: 'Nowshera Block',
    nameUr: 'نوشہرہ بلاک',
    parentId: 'unit-dist-rajouri',
  ),
  OrgUnit(
    id: 'unit-blk-raj-sunderbani',
    type: OrgUnitType.block,
    nameEn: 'Sunderbani Block',
    nameUr: 'سندر بنی بلاک',
    parentId: 'unit-dist-rajouri',
  ),
  OrgUnit(
    id: 'unit-blk-raj-kotranka',
    type: OrgUnitType.block,
    nameEn: 'Kotranka (Budhal) Block',
    nameUr: 'کوٹرنکہ بدھل بلاک',
    parentId: 'unit-dist-rajouri',
  ),

  // --- Poonch Blocks ---
  OrgUnit(
    id: 'unit-blk-pnc-poonch',
    type: OrgUnitType.block,
    nameEn: 'Poonch Haveli Block',
    nameUr: 'پونچھ حویلی بلاک',
    parentId: 'unit-dist-poonch',
  ),
  OrgUnit(
    id: 'unit-blk-pnc-mendhar',
    type: OrgUnitType.block,
    nameEn: 'Mendhar Block',
    nameUr: 'مینڈھر بلاک',
    parentId: 'unit-dist-poonch',
  ),
  OrgUnit(
    id: 'unit-blk-pnc-surankote',
    type: OrgUnitType.block,
    nameEn: 'Surankote Block',
    nameUr: 'سرنکوٹ بلاک',
    parentId: 'unit-dist-poonch',
  ),
  OrgUnit(
    id: 'unit-blk-pnc-mandi',
    type: OrgUnitType.block,
    nameEn: 'Mandi Block',
    nameUr: 'منڈی بلاک',
    parentId: 'unit-dist-poonch',
  ),

  // --- Doda Blocks ---
  OrgUnit(
    id: 'unit-blk-dda-doda',
    type: OrgUnitType.block,
    nameEn: 'Doda Block',
    nameUr: 'ڈوڈہ بلاک',
    parentId: 'unit-dist-doda',
  ),
  OrgUnit(
    id: 'unit-blk-dda-bhaderwah',
    type: OrgUnitType.block,
    nameEn: 'Bhaderwah Block',
    nameUr: 'بھدرواہ بلاک',
    parentId: 'unit-dist-doda',
  ),
  OrgUnit(
    id: 'unit-blk-dda-gandoh',
    type: OrgUnitType.block,
    nameEn: 'Gandoh (Bhalessa) Block',
    nameUr: 'گندوہ بھلیسہ بلاک',
    parentId: 'unit-dist-doda',
  ),
  OrgUnit(
    id: 'unit-blk-dda-thathri',
    type: OrgUnitType.block,
    nameEn: 'Thathri Block',
    nameUr: 'تھاٹھری بلاک',
    parentId: 'unit-dist-doda',
  ),

  // --- Kishtwar Blocks ---
  OrgUnit(
    id: 'unit-blk-kis-kishtwar',
    type: OrgUnitType.block,
    nameEn: 'Kishtwar Block',
    nameUr: 'کشتواڑ بلاک',
    parentId: 'unit-dist-kishtwar',
  ),
  OrgUnit(
    id: 'unit-blk-kis-paddar',
    type: OrgUnitType.block,
    nameEn: 'Paddar Block',
    nameUr: 'پاڈر بلاک',
    parentId: 'unit-dist-kishtwar',
  ),
  OrgUnit(
    id: 'unit-blk-kis-chhatroo',
    type: OrgUnitType.block,
    nameEn: 'Chhatroo Block',
    nameUr: 'چھاترو بلاک',
    parentId: 'unit-dist-kishtwar',
  ),
  OrgUnit(
    id: 'unit-blk-kis-marwah',
    type: OrgUnitType.block,
    nameEn: 'Marwah & Warwan Block',
    nameUr: 'مڑواہ وروان بلاک',
    parentId: 'unit-dist-kishtwar',
  ),

  // --- Ramban Blocks ---
  OrgUnit(
    id: 'unit-blk-rmb-ramban',
    type: OrgUnitType.block,
    nameEn: 'Ramban Block',
    nameUr: 'رام بن بلاک',
    parentId: 'unit-dist-ramban',
  ),
  OrgUnit(
    id: 'unit-blk-rmb-banihal',
    type: OrgUnitType.block,
    nameEn: 'Banihal Block',
    nameUr: 'بانہال بلاک',
    parentId: 'unit-dist-ramban',
  ),
  OrgUnit(
    id: 'unit-blk-rmb-gool',
    type: OrgUnitType.block,
    nameEn: 'Gool Block',
    nameUr: 'گول بلاک',
    parentId: 'unit-dist-ramban',
  ),
  OrgUnit(
    id: 'unit-blk-rmb-batote',
    type: OrgUnitType.block,
    nameEn: 'Batote Block',
    nameUr: 'بٹوٹ بلاک',
    parentId: 'unit-dist-ramban',
  ),

  // =========================================================================
  // MODEL HALQA PANCHAYATS
  // =========================================================================
  OrgUnit(
    id: 'unit-hlq-ant-bij-waghama',
    type: OrgUnitType.halqa,
    nameEn: 'Waghama Halqa Panchayat',
    nameUr: 'واگہامہ حلقہ پنچایت',
    parentId: 'unit-blk-ant-bijbehara',
  ),
  OrgUnit(
    id: 'unit-hlq-ant-bij-kanelwan',
    type: OrgUnitType.halqa,
    nameEn: 'Kanelwan Halqa Panchayat',
    nameUr: 'کنیلوان حلقہ پنچایت',
    parentId: 'unit-blk-ant-bijbehara',
  ),
  OrgUnit(
    id: 'unit-hlq-ant-ant-dialgam',
    type: OrgUnitType.halqa,
    nameEn: 'Dialgam Halqa Panchayat',
    nameUr: 'ڈیالگام حلقہ پنچایت',
    parentId: 'unit-blk-ant-anantnag',
  ),
  OrgUnit(
    id: 'unit-hlq-bar-bar-kanispora',
    type: OrgUnitType.halqa,
    nameEn: 'Kanispora Halqa Panchayat',
    nameUr: 'کنی پورہ حلقہ پنچایت',
    parentId: 'unit-blk-bar-baramulla',
  ),
  OrgUnit(
    id: 'unit-hlq-bar-sop-tujjar',
    type: OrgUnitType.halqa,
    nameEn: 'Tujjar Sharief Halqa',
    nameUr: 'تجر شریف حلقہ پنچایت',
    parentId: 'unit-blk-bar-sopore',
  ),
  OrgUnit(
    id: 'unit-hlq-jam-akh-sohal',
    type: OrgUnitType.halqa,
    nameEn: 'Sohal Halqa Panchayat',
    nameUr: 'سوہل حلقہ پنچایت',
    parentId: 'unit-blk-jam-akhnoor',
  ),
  OrgUnit(
    id: 'unit-hlq-jam-rsp-dablehar',
    type: OrgUnitType.halqa,
    nameEn: 'Dablehar Halqa Panchayat',
    nameUr: 'ڈبلہار حلقہ پنچایت',
    parentId: 'unit-blk-jam-rspura',
  ),
];

/// All 20 canonical districts of Jammu & Kashmir across both divisions.
const List<String> jkDistrictNames = <String>[
  // Kashmir Division (10)
  'Srinagar',
  'Ganderbal',
  'Budgam',
  'Anantnag',
  'Kulgam',
  'Pulwama',
  'Shopian',
  'Baramulla',
  'Kupwara',
  'Bandipora',
  // Jammu Division (10)
  'Jammu',
  'Samba',
  'Kathua',
  'Udhampur',
  'Reasi',
  'Rajouri',
  'Poonch',
  'Doda',
  'Ramban',
  'Kishtwar',
];

/// All 20 district OrgUnits from master data, always available synchronously offline.
List<OrgUnit> get jkAllDistricts => [
      for (final unit in jkGeoMaster)
        if (unit.type == OrgUnitType.district) unit,
    ]..sort((a, b) => a.nameEn.compareTo(b.nameEn));

/// All districts of [divisionId], sorted alphabetically.
List<OrgUnit> districtsOfDivision(String divisionId) => [
      for (final unit in jkGeoMaster)
        if (unit.type == OrgUnitType.district && unit.parentId == divisionId)
          unit,
    ]..sort((a, b) => a.nameEn.toLowerCase().compareTo(b.nameEn.toLowerCase()));
