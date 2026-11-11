import '../../core/l10n/app_strings.dart';

/// The six tiers of the J&K panchayati raj organisation tree.
///
/// Order is meaningful: state → division → district → block → halqa → ward.
enum OrgUnitType {
  state,
  division,
  district,
  block,
  halqa,
  ward;

  static OrgUnitType? tryParse(String value) {
    for (final type in values) {
      if (type.name == value) return type;
    }
    return null;
  }

  /// Parent of [type], or null when [type] is the root.
  OrgUnitType? get parentType {
    final i = index;
    return i == 0 ? null : values[i - 1];
  }

  /// The tier directly below [type], or null when [type] is the lowest.
  OrgUnitType? get childType {
    final i = index;
    return i == values.length - 1 ? null : values[i + 1];
  }

  /// Plural label key for this tier (resolved through [AppStrings.t]).
  String get labelKey => switch (this) {
        OrgUnitType.state => 'jammuKashmir',
        OrgUnitType.division => 'divisions',
        OrgUnitType.district => 'districts',
        OrgUnitType.block => 'blocks',
        OrgUnitType.halqa => 'halqas',
        OrgUnitType.ward => 'wards',
      };

  String label(AppStrings strings) => strings.t(labelKey);
}

/// One node of the organisation tree (state, division, district, block,
/// halqa panchayat or ward).
class OrgUnit {
  const OrgUnit({
    required this.id,
    required this.type,
    required this.nameEn,
    this.nameHi,
    this.nameUr,
    this.parentId,
    this.geoCode,
    this.centroid,
  });

  final String id;
  final OrgUnitType type;
  final String nameEn;
  final String? nameHi;
  final String? nameUr;

  /// Parent node id; null only for the state root.
  final String? parentId;

  /// Official geo/LSGD code from the master data, when known.
  final String? geoCode;

  /// "lat,lng" of the unit centroid — coarse by design (see PLAN.md §9):
  /// never store an individual's coordinates here.
  final String? centroid;

  /// Name in [strings]' locale, falling back to English.
  ///
  /// Note for translators: Urdu place names in the seed master need local
  /// proofreading before release (flagged in PLAN.md §2).
  String localizedName(AppStrings strings) => switch (strings.locale) {
        'hi' => nameHi ?? nameEn,
        'ur' => nameUr ?? nameEn,
        _ => nameEn,
      };

  OrgUnit copyWith({String? nameHi, String? nameUr}) => OrgUnit(
        id: id,
        type: type,
        nameEn: nameEn,
        nameHi: nameHi ?? this.nameHi,
        nameUr: nameUr ?? this.nameUr,
        parentId: parentId,
        geoCode: geoCode,
        centroid: centroid,
      );

  @override
  bool operator ==(Object other) => other is OrgUnit && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'OrgUnit(${type.name}: $nameEn)';
}
