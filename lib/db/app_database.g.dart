// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $OrgUnitsTable extends OrgUnits
    with TableInfo<$OrgUnitsTable, OrgUnitRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrgUnitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameHiMeta = const VerificationMeta('nameHi');
  @override
  late final GeneratedColumn<String> nameHi = GeneratedColumn<String>(
    'name_hi',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameUrMeta = const VerificationMeta('nameUr');
  @override
  late final GeneratedColumn<String> nameUr = GeneratedColumn<String>(
    'name_ur',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _geoCodeMeta = const VerificationMeta(
    'geoCode',
  );
  @override
  late final GeneratedColumn<String> geoCode = GeneratedColumn<String>(
    'geo_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _centroidMeta = const VerificationMeta(
    'centroid',
  );
  @override
  late final GeneratedColumn<String> centroid = GeneratedColumn<String>(
    'centroid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    nameEn,
    nameHi,
    nameUr,
    parentId,
    geoCode,
    centroid,
    revision,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'org_units';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrgUnitRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_hi')) {
      context.handle(
        _nameHiMeta,
        nameHi.isAcceptableOrUnknown(data['name_hi']!, _nameHiMeta),
      );
    }
    if (data.containsKey('name_ur')) {
      context.handle(
        _nameUrMeta,
        nameUr.isAcceptableOrUnknown(data['name_ur']!, _nameUrMeta),
      );
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    if (data.containsKey('geo_code')) {
      context.handle(
        _geoCodeMeta,
        geoCode.isAcceptableOrUnknown(data['geo_code']!, _geoCodeMeta),
      );
    }
    if (data.containsKey('centroid')) {
      context.handle(
        _centroidMeta,
        centroid.isAcceptableOrUnknown(data['centroid']!, _centroidMeta),
      );
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrgUnitRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrgUnitRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameHi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_hi'],
      ),
      nameUr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ur'],
      ),
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_id'],
      ),
      geoCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}geo_code'],
      ),
      centroid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}centroid'],
      ),
      revision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $OrgUnitsTable createAlias(String alias) {
    return $OrgUnitsTable(attachedDatabase, alias);
  }
}

class OrgUnitRow extends DataClass implements Insertable<OrgUnitRow> {
  final String id;
  final String type;
  final String nameEn;
  final String? nameHi;
  final String? nameUr;
  final String? parentId;
  final String? geoCode;

  /// Coarse "lat,lng" centroid — never an individual's coordinates.
  final String? centroid;
  final int revision;
  final DateTime? updatedAt;
  const OrgUnitRow({
    required this.id,
    required this.type,
    required this.nameEn,
    this.nameHi,
    this.nameUr,
    this.parentId,
    this.geoCode,
    this.centroid,
    required this.revision,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['name_en'] = Variable<String>(nameEn);
    if (!nullToAbsent || nameHi != null) {
      map['name_hi'] = Variable<String>(nameHi);
    }
    if (!nullToAbsent || nameUr != null) {
      map['name_ur'] = Variable<String>(nameUr);
    }
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    if (!nullToAbsent || geoCode != null) {
      map['geo_code'] = Variable<String>(geoCode);
    }
    if (!nullToAbsent || centroid != null) {
      map['centroid'] = Variable<String>(centroid);
    }
    map['revision'] = Variable<int>(revision);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  OrgUnitsCompanion toCompanion(bool nullToAbsent) {
    return OrgUnitsCompanion(
      id: Value(id),
      type: Value(type),
      nameEn: Value(nameEn),
      nameHi: nameHi == null && nullToAbsent
          ? const Value.absent()
          : Value(nameHi),
      nameUr: nameUr == null && nullToAbsent
          ? const Value.absent()
          : Value(nameUr),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      geoCode: geoCode == null && nullToAbsent
          ? const Value.absent()
          : Value(geoCode),
      centroid: centroid == null && nullToAbsent
          ? const Value.absent()
          : Value(centroid),
      revision: Value(revision),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory OrgUnitRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrgUnitRow(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameHi: serializer.fromJson<String?>(json['nameHi']),
      nameUr: serializer.fromJson<String?>(json['nameUr']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      geoCode: serializer.fromJson<String?>(json['geoCode']),
      centroid: serializer.fromJson<String?>(json['centroid']),
      revision: serializer.fromJson<int>(json['revision']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameHi': serializer.toJson<String?>(nameHi),
      'nameUr': serializer.toJson<String?>(nameUr),
      'parentId': serializer.toJson<String?>(parentId),
      'geoCode': serializer.toJson<String?>(geoCode),
      'centroid': serializer.toJson<String?>(centroid),
      'revision': serializer.toJson<int>(revision),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  OrgUnitRow copyWith({
    String? id,
    String? type,
    String? nameEn,
    Value<String?> nameHi = const Value.absent(),
    Value<String?> nameUr = const Value.absent(),
    Value<String?> parentId = const Value.absent(),
    Value<String?> geoCode = const Value.absent(),
    Value<String?> centroid = const Value.absent(),
    int? revision,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => OrgUnitRow(
    id: id ?? this.id,
    type: type ?? this.type,
    nameEn: nameEn ?? this.nameEn,
    nameHi: nameHi.present ? nameHi.value : this.nameHi,
    nameUr: nameUr.present ? nameUr.value : this.nameUr,
    parentId: parentId.present ? parentId.value : this.parentId,
    geoCode: geoCode.present ? geoCode.value : this.geoCode,
    centroid: centroid.present ? centroid.value : this.centroid,
    revision: revision ?? this.revision,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  OrgUnitRow copyWithCompanion(OrgUnitsCompanion data) {
    return OrgUnitRow(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameHi: data.nameHi.present ? data.nameHi.value : this.nameHi,
      nameUr: data.nameUr.present ? data.nameUr.value : this.nameUr,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      geoCode: data.geoCode.present ? data.geoCode.value : this.geoCode,
      centroid: data.centroid.present ? data.centroid.value : this.centroid,
      revision: data.revision.present ? data.revision.value : this.revision,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrgUnitRow(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameHi: $nameHi, ')
          ..write('nameUr: $nameUr, ')
          ..write('parentId: $parentId, ')
          ..write('geoCode: $geoCode, ')
          ..write('centroid: $centroid, ')
          ..write('revision: $revision, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    nameEn,
    nameHi,
    nameUr,
    parentId,
    geoCode,
    centroid,
    revision,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrgUnitRow &&
          other.id == this.id &&
          other.type == this.type &&
          other.nameEn == this.nameEn &&
          other.nameHi == this.nameHi &&
          other.nameUr == this.nameUr &&
          other.parentId == this.parentId &&
          other.geoCode == this.geoCode &&
          other.centroid == this.centroid &&
          other.revision == this.revision &&
          other.updatedAt == this.updatedAt);
}

class OrgUnitsCompanion extends UpdateCompanion<OrgUnitRow> {
  final Value<String> id;
  final Value<String> type;
  final Value<String> nameEn;
  final Value<String?> nameHi;
  final Value<String?> nameUr;
  final Value<String?> parentId;
  final Value<String?> geoCode;
  final Value<String?> centroid;
  final Value<int> revision;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const OrgUnitsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameHi = const Value.absent(),
    this.nameUr = const Value.absent(),
    this.parentId = const Value.absent(),
    this.geoCode = const Value.absent(),
    this.centroid = const Value.absent(),
    this.revision = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrgUnitsCompanion.insert({
    required String id,
    required String type,
    required String nameEn,
    this.nameHi = const Value.absent(),
    this.nameUr = const Value.absent(),
    this.parentId = const Value.absent(),
    this.geoCode = const Value.absent(),
    this.centroid = const Value.absent(),
    this.revision = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       nameEn = Value(nameEn);
  static Insertable<OrgUnitRow> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? nameEn,
    Expression<String>? nameHi,
    Expression<String>? nameUr,
    Expression<String>? parentId,
    Expression<String>? geoCode,
    Expression<String>? centroid,
    Expression<int>? revision,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (nameEn != null) 'name_en': nameEn,
      if (nameHi != null) 'name_hi': nameHi,
      if (nameUr != null) 'name_ur': nameUr,
      if (parentId != null) 'parent_id': parentId,
      if (geoCode != null) 'geo_code': geoCode,
      if (centroid != null) 'centroid': centroid,
      if (revision != null) 'revision': revision,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrgUnitsCompanion copyWith({
    Value<String>? id,
    Value<String>? type,
    Value<String>? nameEn,
    Value<String?>? nameHi,
    Value<String?>? nameUr,
    Value<String?>? parentId,
    Value<String?>? geoCode,
    Value<String?>? centroid,
    Value<int>? revision,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return OrgUnitsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      nameEn: nameEn ?? this.nameEn,
      nameHi: nameHi ?? this.nameHi,
      nameUr: nameUr ?? this.nameUr,
      parentId: parentId ?? this.parentId,
      geoCode: geoCode ?? this.geoCode,
      centroid: centroid ?? this.centroid,
      revision: revision ?? this.revision,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameHi.present) {
      map['name_hi'] = Variable<String>(nameHi.value);
    }
    if (nameUr.present) {
      map['name_ur'] = Variable<String>(nameUr.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (geoCode.present) {
      map['geo_code'] = Variable<String>(geoCode.value);
    }
    if (centroid.present) {
      map['centroid'] = Variable<String>(centroid.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrgUnitsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameHi: $nameHi, ')
          ..write('nameUr: $nameUr, ')
          ..write('parentId: $parentId, ')
          ..write('geoCode: $geoCode, ')
          ..write('centroid: $centroid, ')
          ..write('revision: $revision, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncCursorsTable extends SyncCursors
    with TableInfo<$SyncCursorsTable, SyncCursorRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncCursorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _deviceKeyMeta = const VerificationMeta(
    'deviceKey',
  );
  @override
  late final GeneratedColumn<String> deviceKey = GeneratedColumn<String>(
    'device_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastRevisionMeta = const VerificationMeta(
    'lastRevision',
  );
  @override
  late final GeneratedColumn<int> lastRevision = GeneratedColumn<int>(
    'last_revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [deviceKey, lastRevision, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_cursors';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncCursorRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('device_key')) {
      context.handle(
        _deviceKeyMeta,
        deviceKey.isAcceptableOrUnknown(data['device_key']!, _deviceKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceKeyMeta);
    }
    if (data.containsKey('last_revision')) {
      context.handle(
        _lastRevisionMeta,
        lastRevision.isAcceptableOrUnknown(
          data['last_revision']!,
          _lastRevisionMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {deviceKey};
  @override
  SyncCursorRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncCursorRow(
      deviceKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_key'],
      )!,
      lastRevision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_revision'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $SyncCursorsTable createAlias(String alias) {
    return $SyncCursorsTable(attachedDatabase, alias);
  }
}

class SyncCursorRow extends DataClass implements Insertable<SyncCursorRow> {
  final String deviceKey;
  final int lastRevision;
  final DateTime? updatedAt;
  const SyncCursorRow({
    required this.deviceKey,
    required this.lastRevision,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['device_key'] = Variable<String>(deviceKey);
    map['last_revision'] = Variable<int>(lastRevision);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  SyncCursorsCompanion toCompanion(bool nullToAbsent) {
    return SyncCursorsCompanion(
      deviceKey: Value(deviceKey),
      lastRevision: Value(lastRevision),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory SyncCursorRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncCursorRow(
      deviceKey: serializer.fromJson<String>(json['deviceKey']),
      lastRevision: serializer.fromJson<int>(json['lastRevision']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'deviceKey': serializer.toJson<String>(deviceKey),
      'lastRevision': serializer.toJson<int>(lastRevision),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  SyncCursorRow copyWith({
    String? deviceKey,
    int? lastRevision,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => SyncCursorRow(
    deviceKey: deviceKey ?? this.deviceKey,
    lastRevision: lastRevision ?? this.lastRevision,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  SyncCursorRow copyWithCompanion(SyncCursorsCompanion data) {
    return SyncCursorRow(
      deviceKey: data.deviceKey.present ? data.deviceKey.value : this.deviceKey,
      lastRevision: data.lastRevision.present
          ? data.lastRevision.value
          : this.lastRevision,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncCursorRow(')
          ..write('deviceKey: $deviceKey, ')
          ..write('lastRevision: $lastRevision, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(deviceKey, lastRevision, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncCursorRow &&
          other.deviceKey == this.deviceKey &&
          other.lastRevision == this.lastRevision &&
          other.updatedAt == this.updatedAt);
}

class SyncCursorsCompanion extends UpdateCompanion<SyncCursorRow> {
  final Value<String> deviceKey;
  final Value<int> lastRevision;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const SyncCursorsCompanion({
    this.deviceKey = const Value.absent(),
    this.lastRevision = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncCursorsCompanion.insert({
    required String deviceKey,
    this.lastRevision = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : deviceKey = Value(deviceKey);
  static Insertable<SyncCursorRow> custom({
    Expression<String>? deviceKey,
    Expression<int>? lastRevision,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (deviceKey != null) 'device_key': deviceKey,
      if (lastRevision != null) 'last_revision': lastRevision,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncCursorsCompanion copyWith({
    Value<String>? deviceKey,
    Value<int>? lastRevision,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return SyncCursorsCompanion(
      deviceKey: deviceKey ?? this.deviceKey,
      lastRevision: lastRevision ?? this.lastRevision,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (deviceKey.present) {
      map['device_key'] = Variable<String>(deviceKey.value);
    }
    if (lastRevision.present) {
      map['last_revision'] = Variable<int>(lastRevision.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncCursorsCompanion(')
          ..write('deviceKey: $deviceKey, ')
          ..write('lastRevision: $lastRevision, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GrievancesTable extends Grievances
    with TableInfo<$GrievancesTable, GrievanceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GrievancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _refCodeMeta = const VerificationMeta(
    'refCode',
  );
  @override
  late final GeneratedColumn<String> refCode = GeneratedColumn<String>(
    'ref_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<String> unitId = GeneratedColumn<String>(
    'unit_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reporterNameMeta = const VerificationMeta(
    'reporterName',
  );
  @override
  late final GeneratedColumn<String> reporterName = GeneratedColumn<String>(
    'reporter_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reporterPhoneMeta = const VerificationMeta(
    'reporterPhone',
  );
  @override
  late final GeneratedColumn<String> reporterPhone = GeneratedColumn<String>(
    'reporter_phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resolvedAtMeta = const VerificationMeta(
    'resolvedAt',
  );
  @override
  late final GeneratedColumn<DateTime> resolvedAt = GeneratedColumn<DateTime>(
    'resolved_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _resolutionNoteMeta = const VerificationMeta(
    'resolutionNote',
  );
  @override
  late final GeneratedColumn<String> resolutionNote = GeneratedColumn<String>(
    'resolution_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    refCode,
    title,
    description,
    category,
    unitId,
    status,
    reporterName,
    reporterPhone,
    createdAt,
    resolvedAt,
    resolutionNote,
    revision,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'grievances';
  @override
  VerificationContext validateIntegrity(
    Insertable<GrievanceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('ref_code')) {
      context.handle(
        _refCodeMeta,
        refCode.isAcceptableOrUnknown(data['ref_code']!, _refCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_refCodeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('unit_id')) {
      context.handle(
        _unitIdMeta,
        unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('reporter_name')) {
      context.handle(
        _reporterNameMeta,
        reporterName.isAcceptableOrUnknown(
          data['reporter_name']!,
          _reporterNameMeta,
        ),
      );
    }
    if (data.containsKey('reporter_phone')) {
      context.handle(
        _reporterPhoneMeta,
        reporterPhone.isAcceptableOrUnknown(
          data['reporter_phone']!,
          _reporterPhoneMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('resolved_at')) {
      context.handle(
        _resolvedAtMeta,
        resolvedAt.isAcceptableOrUnknown(data['resolved_at']!, _resolvedAtMeta),
      );
    }
    if (data.containsKey('resolution_note')) {
      context.handle(
        _resolutionNoteMeta,
        resolutionNote.isAcceptableOrUnknown(
          data['resolution_note']!,
          _resolutionNoteMeta,
        ),
      );
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GrievanceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GrievanceRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      refCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ref_code'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      unitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_id'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      reporterName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reporter_name'],
      ),
      reporterPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reporter_phone'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      resolvedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}resolved_at'],
      ),
      resolutionNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}resolution_note'],
      ),
      revision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision'],
      )!,
    );
  }

  @override
  $GrievancesTable createAlias(String alias) {
    return $GrievancesTable(attachedDatabase, alias);
  }
}

class GrievanceRow extends DataClass implements Insertable<GrievanceRow> {
  final String id;
  final String refCode;
  final String title;
  final String description;
  final String category;

  /// Org unit this belongs to (district today, halqa once master data lands).
  final String? unitId;
  final String status;

  /// Citizen the worker reports on behalf of. Optional and never published.
  final String? reporterName;
  final String? reporterPhone;
  final DateTime createdAt;
  final DateTime? resolvedAt;
  final String? resolutionNote;
  final int revision;
  const GrievanceRow({
    required this.id,
    required this.refCode,
    required this.title,
    required this.description,
    required this.category,
    this.unitId,
    required this.status,
    this.reporterName,
    this.reporterPhone,
    required this.createdAt,
    this.resolvedAt,
    this.resolutionNote,
    required this.revision,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['ref_code'] = Variable<String>(refCode);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || unitId != null) {
      map['unit_id'] = Variable<String>(unitId);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || reporterName != null) {
      map['reporter_name'] = Variable<String>(reporterName);
    }
    if (!nullToAbsent || reporterPhone != null) {
      map['reporter_phone'] = Variable<String>(reporterPhone);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || resolvedAt != null) {
      map['resolved_at'] = Variable<DateTime>(resolvedAt);
    }
    if (!nullToAbsent || resolutionNote != null) {
      map['resolution_note'] = Variable<String>(resolutionNote);
    }
    map['revision'] = Variable<int>(revision);
    return map;
  }

  GrievancesCompanion toCompanion(bool nullToAbsent) {
    return GrievancesCompanion(
      id: Value(id),
      refCode: Value(refCode),
      title: Value(title),
      description: Value(description),
      category: Value(category),
      unitId: unitId == null && nullToAbsent
          ? const Value.absent()
          : Value(unitId),
      status: Value(status),
      reporterName: reporterName == null && nullToAbsent
          ? const Value.absent()
          : Value(reporterName),
      reporterPhone: reporterPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(reporterPhone),
      createdAt: Value(createdAt),
      resolvedAt: resolvedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(resolvedAt),
      resolutionNote: resolutionNote == null && nullToAbsent
          ? const Value.absent()
          : Value(resolutionNote),
      revision: Value(revision),
    );
  }

  factory GrievanceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GrievanceRow(
      id: serializer.fromJson<String>(json['id']),
      refCode: serializer.fromJson<String>(json['refCode']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      category: serializer.fromJson<String>(json['category']),
      unitId: serializer.fromJson<String?>(json['unitId']),
      status: serializer.fromJson<String>(json['status']),
      reporterName: serializer.fromJson<String?>(json['reporterName']),
      reporterPhone: serializer.fromJson<String?>(json['reporterPhone']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      resolvedAt: serializer.fromJson<DateTime?>(json['resolvedAt']),
      resolutionNote: serializer.fromJson<String?>(json['resolutionNote']),
      revision: serializer.fromJson<int>(json['revision']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'refCode': serializer.toJson<String>(refCode),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'category': serializer.toJson<String>(category),
      'unitId': serializer.toJson<String?>(unitId),
      'status': serializer.toJson<String>(status),
      'reporterName': serializer.toJson<String?>(reporterName),
      'reporterPhone': serializer.toJson<String?>(reporterPhone),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'resolvedAt': serializer.toJson<DateTime?>(resolvedAt),
      'resolutionNote': serializer.toJson<String?>(resolutionNote),
      'revision': serializer.toJson<int>(revision),
    };
  }

  GrievanceRow copyWith({
    String? id,
    String? refCode,
    String? title,
    String? description,
    String? category,
    Value<String?> unitId = const Value.absent(),
    String? status,
    Value<String?> reporterName = const Value.absent(),
    Value<String?> reporterPhone = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> resolvedAt = const Value.absent(),
    Value<String?> resolutionNote = const Value.absent(),
    int? revision,
  }) => GrievanceRow(
    id: id ?? this.id,
    refCode: refCode ?? this.refCode,
    title: title ?? this.title,
    description: description ?? this.description,
    category: category ?? this.category,
    unitId: unitId.present ? unitId.value : this.unitId,
    status: status ?? this.status,
    reporterName: reporterName.present ? reporterName.value : this.reporterName,
    reporterPhone: reporterPhone.present
        ? reporterPhone.value
        : this.reporterPhone,
    createdAt: createdAt ?? this.createdAt,
    resolvedAt: resolvedAt.present ? resolvedAt.value : this.resolvedAt,
    resolutionNote: resolutionNote.present
        ? resolutionNote.value
        : this.resolutionNote,
    revision: revision ?? this.revision,
  );
  GrievanceRow copyWithCompanion(GrievancesCompanion data) {
    return GrievanceRow(
      id: data.id.present ? data.id.value : this.id,
      refCode: data.refCode.present ? data.refCode.value : this.refCode,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      category: data.category.present ? data.category.value : this.category,
      unitId: data.unitId.present ? data.unitId.value : this.unitId,
      status: data.status.present ? data.status.value : this.status,
      reporterName: data.reporterName.present
          ? data.reporterName.value
          : this.reporterName,
      reporterPhone: data.reporterPhone.present
          ? data.reporterPhone.value
          : this.reporterPhone,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      resolvedAt: data.resolvedAt.present
          ? data.resolvedAt.value
          : this.resolvedAt,
      resolutionNote: data.resolutionNote.present
          ? data.resolutionNote.value
          : this.resolutionNote,
      revision: data.revision.present ? data.revision.value : this.revision,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GrievanceRow(')
          ..write('id: $id, ')
          ..write('refCode: $refCode, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('unitId: $unitId, ')
          ..write('status: $status, ')
          ..write('reporterName: $reporterName, ')
          ..write('reporterPhone: $reporterPhone, ')
          ..write('createdAt: $createdAt, ')
          ..write('resolvedAt: $resolvedAt, ')
          ..write('resolutionNote: $resolutionNote, ')
          ..write('revision: $revision')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    refCode,
    title,
    description,
    category,
    unitId,
    status,
    reporterName,
    reporterPhone,
    createdAt,
    resolvedAt,
    resolutionNote,
    revision,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GrievanceRow &&
          other.id == this.id &&
          other.refCode == this.refCode &&
          other.title == this.title &&
          other.description == this.description &&
          other.category == this.category &&
          other.unitId == this.unitId &&
          other.status == this.status &&
          other.reporterName == this.reporterName &&
          other.reporterPhone == this.reporterPhone &&
          other.createdAt == this.createdAt &&
          other.resolvedAt == this.resolvedAt &&
          other.resolutionNote == this.resolutionNote &&
          other.revision == this.revision);
}

class GrievancesCompanion extends UpdateCompanion<GrievanceRow> {
  final Value<String> id;
  final Value<String> refCode;
  final Value<String> title;
  final Value<String> description;
  final Value<String> category;
  final Value<String?> unitId;
  final Value<String> status;
  final Value<String?> reporterName;
  final Value<String?> reporterPhone;
  final Value<DateTime> createdAt;
  final Value<DateTime?> resolvedAt;
  final Value<String?> resolutionNote;
  final Value<int> revision;
  final Value<int> rowid;
  const GrievancesCompanion({
    this.id = const Value.absent(),
    this.refCode = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.unitId = const Value.absent(),
    this.status = const Value.absent(),
    this.reporterName = const Value.absent(),
    this.reporterPhone = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.resolvedAt = const Value.absent(),
    this.resolutionNote = const Value.absent(),
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GrievancesCompanion.insert({
    required String id,
    required String refCode,
    required String title,
    required String description,
    required String category,
    this.unitId = const Value.absent(),
    required String status,
    this.reporterName = const Value.absent(),
    this.reporterPhone = const Value.absent(),
    required DateTime createdAt,
    this.resolvedAt = const Value.absent(),
    this.resolutionNote = const Value.absent(),
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       refCode = Value(refCode),
       title = Value(title),
       description = Value(description),
       category = Value(category),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<GrievanceRow> custom({
    Expression<String>? id,
    Expression<String>? refCode,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? category,
    Expression<String>? unitId,
    Expression<String>? status,
    Expression<String>? reporterName,
    Expression<String>? reporterPhone,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? resolvedAt,
    Expression<String>? resolutionNote,
    Expression<int>? revision,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (refCode != null) 'ref_code': refCode,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (unitId != null) 'unit_id': unitId,
      if (status != null) 'status': status,
      if (reporterName != null) 'reporter_name': reporterName,
      if (reporterPhone != null) 'reporter_phone': reporterPhone,
      if (createdAt != null) 'created_at': createdAt,
      if (resolvedAt != null) 'resolved_at': resolvedAt,
      if (resolutionNote != null) 'resolution_note': resolutionNote,
      if (revision != null) 'revision': revision,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GrievancesCompanion copyWith({
    Value<String>? id,
    Value<String>? refCode,
    Value<String>? title,
    Value<String>? description,
    Value<String>? category,
    Value<String?>? unitId,
    Value<String>? status,
    Value<String?>? reporterName,
    Value<String?>? reporterPhone,
    Value<DateTime>? createdAt,
    Value<DateTime?>? resolvedAt,
    Value<String?>? resolutionNote,
    Value<int>? revision,
    Value<int>? rowid,
  }) {
    return GrievancesCompanion(
      id: id ?? this.id,
      refCode: refCode ?? this.refCode,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      unitId: unitId ?? this.unitId,
      status: status ?? this.status,
      reporterName: reporterName ?? this.reporterName,
      reporterPhone: reporterPhone ?? this.reporterPhone,
      createdAt: createdAt ?? this.createdAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      resolutionNote: resolutionNote ?? this.resolutionNote,
      revision: revision ?? this.revision,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (refCode.present) {
      map['ref_code'] = Variable<String>(refCode.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<String>(unitId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (reporterName.present) {
      map['reporter_name'] = Variable<String>(reporterName.value);
    }
    if (reporterPhone.present) {
      map['reporter_phone'] = Variable<String>(reporterPhone.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (resolvedAt.present) {
      map['resolved_at'] = Variable<DateTime>(resolvedAt.value);
    }
    if (resolutionNote.present) {
      map['resolution_note'] = Variable<String>(resolutionNote.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GrievancesCompanion(')
          ..write('id: $id, ')
          ..write('refCode: $refCode, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('unitId: $unitId, ')
          ..write('status: $status, ')
          ..write('reporterName: $reporterName, ')
          ..write('reporterPhone: $reporterPhone, ')
          ..write('createdAt: $createdAt, ')
          ..write('resolvedAt: $resolvedAt, ')
          ..write('resolutionNote: $resolutionNote, ')
          ..write('revision: $revision, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GrievanceEventsTable extends GrievanceEvents
    with TableInfo<$GrievanceEventsTable, GrievanceEventRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GrievanceEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _grievanceIdMeta = const VerificationMeta(
    'grievanceId',
  );
  @override
  late final GeneratedColumn<String> grievanceId = GeneratedColumn<String>(
    'grievance_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actorNameMeta = const VerificationMeta(
    'actorName',
  );
  @override
  late final GeneratedColumn<String> actorName = GeneratedColumn<String>(
    'actor_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    grievanceId,
    type,
    note,
    actorName,
    createdAt,
    revision,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'grievance_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<GrievanceEventRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('grievance_id')) {
      context.handle(
        _grievanceIdMeta,
        grievanceId.isAcceptableOrUnknown(
          data['grievance_id']!,
          _grievanceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_grievanceIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    if (data.containsKey('actor_name')) {
      context.handle(
        _actorNameMeta,
        actorName.isAcceptableOrUnknown(data['actor_name']!, _actorNameMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GrievanceEventRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GrievanceEventRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      grievanceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grievance_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
      actorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actor_name'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      revision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision'],
      )!,
    );
  }

  @override
  $GrievanceEventsTable createAlias(String alias) {
    return $GrievanceEventsTable(attachedDatabase, alias);
  }
}

class GrievanceEventRow extends DataClass
    implements Insertable<GrievanceEventRow> {
  final String id;
  final String grievanceId;
  final String type;
  final String note;
  final String? actorName;
  final DateTime createdAt;
  final int revision;
  const GrievanceEventRow({
    required this.id,
    required this.grievanceId,
    required this.type,
    required this.note,
    this.actorName,
    required this.createdAt,
    required this.revision,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['grievance_id'] = Variable<String>(grievanceId);
    map['type'] = Variable<String>(type);
    map['note'] = Variable<String>(note);
    if (!nullToAbsent || actorName != null) {
      map['actor_name'] = Variable<String>(actorName);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['revision'] = Variable<int>(revision);
    return map;
  }

  GrievanceEventsCompanion toCompanion(bool nullToAbsent) {
    return GrievanceEventsCompanion(
      id: Value(id),
      grievanceId: Value(grievanceId),
      type: Value(type),
      note: Value(note),
      actorName: actorName == null && nullToAbsent
          ? const Value.absent()
          : Value(actorName),
      createdAt: Value(createdAt),
      revision: Value(revision),
    );
  }

  factory GrievanceEventRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GrievanceEventRow(
      id: serializer.fromJson<String>(json['id']),
      grievanceId: serializer.fromJson<String>(json['grievanceId']),
      type: serializer.fromJson<String>(json['type']),
      note: serializer.fromJson<String>(json['note']),
      actorName: serializer.fromJson<String?>(json['actorName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      revision: serializer.fromJson<int>(json['revision']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'grievanceId': serializer.toJson<String>(grievanceId),
      'type': serializer.toJson<String>(type),
      'note': serializer.toJson<String>(note),
      'actorName': serializer.toJson<String?>(actorName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'revision': serializer.toJson<int>(revision),
    };
  }

  GrievanceEventRow copyWith({
    String? id,
    String? grievanceId,
    String? type,
    String? note,
    Value<String?> actorName = const Value.absent(),
    DateTime? createdAt,
    int? revision,
  }) => GrievanceEventRow(
    id: id ?? this.id,
    grievanceId: grievanceId ?? this.grievanceId,
    type: type ?? this.type,
    note: note ?? this.note,
    actorName: actorName.present ? actorName.value : this.actorName,
    createdAt: createdAt ?? this.createdAt,
    revision: revision ?? this.revision,
  );
  GrievanceEventRow copyWithCompanion(GrievanceEventsCompanion data) {
    return GrievanceEventRow(
      id: data.id.present ? data.id.value : this.id,
      grievanceId: data.grievanceId.present
          ? data.grievanceId.value
          : this.grievanceId,
      type: data.type.present ? data.type.value : this.type,
      note: data.note.present ? data.note.value : this.note,
      actorName: data.actorName.present ? data.actorName.value : this.actorName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      revision: data.revision.present ? data.revision.value : this.revision,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GrievanceEventRow(')
          ..write('id: $id, ')
          ..write('grievanceId: $grievanceId, ')
          ..write('type: $type, ')
          ..write('note: $note, ')
          ..write('actorName: $actorName, ')
          ..write('createdAt: $createdAt, ')
          ..write('revision: $revision')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, grievanceId, type, note, actorName, createdAt, revision);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GrievanceEventRow &&
          other.id == this.id &&
          other.grievanceId == this.grievanceId &&
          other.type == this.type &&
          other.note == this.note &&
          other.actorName == this.actorName &&
          other.createdAt == this.createdAt &&
          other.revision == this.revision);
}

class GrievanceEventsCompanion extends UpdateCompanion<GrievanceEventRow> {
  final Value<String> id;
  final Value<String> grievanceId;
  final Value<String> type;
  final Value<String> note;
  final Value<String?> actorName;
  final Value<DateTime> createdAt;
  final Value<int> revision;
  final Value<int> rowid;
  const GrievanceEventsCompanion({
    this.id = const Value.absent(),
    this.grievanceId = const Value.absent(),
    this.type = const Value.absent(),
    this.note = const Value.absent(),
    this.actorName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GrievanceEventsCompanion.insert({
    required String id,
    required String grievanceId,
    required String type,
    required String note,
    this.actorName = const Value.absent(),
    required DateTime createdAt,
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       grievanceId = Value(grievanceId),
       type = Value(type),
       note = Value(note),
       createdAt = Value(createdAt);
  static Insertable<GrievanceEventRow> custom({
    Expression<String>? id,
    Expression<String>? grievanceId,
    Expression<String>? type,
    Expression<String>? note,
    Expression<String>? actorName,
    Expression<DateTime>? createdAt,
    Expression<int>? revision,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (grievanceId != null) 'grievance_id': grievanceId,
      if (type != null) 'type': type,
      if (note != null) 'note': note,
      if (actorName != null) 'actor_name': actorName,
      if (createdAt != null) 'created_at': createdAt,
      if (revision != null) 'revision': revision,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GrievanceEventsCompanion copyWith({
    Value<String>? id,
    Value<String>? grievanceId,
    Value<String>? type,
    Value<String>? note,
    Value<String?>? actorName,
    Value<DateTime>? createdAt,
    Value<int>? revision,
    Value<int>? rowid,
  }) {
    return GrievanceEventsCompanion(
      id: id ?? this.id,
      grievanceId: grievanceId ?? this.grievanceId,
      type: type ?? this.type,
      note: note ?? this.note,
      actorName: actorName ?? this.actorName,
      createdAt: createdAt ?? this.createdAt,
      revision: revision ?? this.revision,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (grievanceId.present) {
      map['grievance_id'] = Variable<String>(grievanceId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (actorName.present) {
      map['actor_name'] = Variable<String>(actorName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GrievanceEventsCompanion(')
          ..write('id: $id, ')
          ..write('grievanceId: $grievanceId, ')
          ..write('type: $type, ')
          ..write('note: $note, ')
          ..write('actorName: $actorName, ')
          ..write('createdAt: $createdAt, ')
          ..write('revision: $revision, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MembersTable extends Members with TableInfo<$MembersTable, MemberRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<String> unitId = GeneratedColumn<String>(
    'unit_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _memberCodeMeta = const VerificationMeta(
    'memberCode',
  );
  @override
  late final GeneratedColumn<String> memberCode = GeneratedColumn<String>(
    'member_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _verifiedAtMeta = const VerificationMeta(
    'verifiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> verifiedAt = GeneratedColumn<DateTime>(
    'verified_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    phone,
    role,
    unitId,
    status,
    memberCode,
    createdAt,
    verifiedAt,
    revision,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'members';
  @override
  VerificationContext validateIntegrity(
    Insertable<MemberRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('unit_id')) {
      context.handle(
        _unitIdMeta,
        unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('member_code')) {
      context.handle(
        _memberCodeMeta,
        memberCode.isAcceptableOrUnknown(data['member_code']!, _memberCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_memberCodeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('verified_at')) {
      context.handle(
        _verifiedAtMeta,
        verifiedAt.isAcceptableOrUnknown(data['verified_at']!, _verifiedAtMeta),
      );
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MemberRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemberRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      unitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_id'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      memberCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_code'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      verifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}verified_at'],
      ),
      revision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision'],
      )!,
    );
  }

  @override
  $MembersTable createAlias(String alias) {
    return $MembersTable(attachedDatabase, alias);
  }
}

class MemberRow extends DataClass implements Insertable<MemberRow> {
  final String id;
  final String name;
  final String? phone;
  final String role;
  final String? unitId;

  /// pending until a block office bearer verifies it.
  final String status;
  final String memberCode;
  final DateTime createdAt;
  final DateTime? verifiedAt;
  final int revision;
  const MemberRow({
    required this.id,
    required this.name,
    this.phone,
    required this.role,
    this.unitId,
    required this.status,
    required this.memberCode,
    required this.createdAt,
    this.verifiedAt,
    required this.revision,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || unitId != null) {
      map['unit_id'] = Variable<String>(unitId);
    }
    map['status'] = Variable<String>(status);
    map['member_code'] = Variable<String>(memberCode);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || verifiedAt != null) {
      map['verified_at'] = Variable<DateTime>(verifiedAt);
    }
    map['revision'] = Variable<int>(revision);
    return map;
  }

  MembersCompanion toCompanion(bool nullToAbsent) {
    return MembersCompanion(
      id: Value(id),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      role: Value(role),
      unitId: unitId == null && nullToAbsent
          ? const Value.absent()
          : Value(unitId),
      status: Value(status),
      memberCode: Value(memberCode),
      createdAt: Value(createdAt),
      verifiedAt: verifiedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(verifiedAt),
      revision: Value(revision),
    );
  }

  factory MemberRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemberRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      role: serializer.fromJson<String>(json['role']),
      unitId: serializer.fromJson<String?>(json['unitId']),
      status: serializer.fromJson<String>(json['status']),
      memberCode: serializer.fromJson<String>(json['memberCode']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      verifiedAt: serializer.fromJson<DateTime?>(json['verifiedAt']),
      revision: serializer.fromJson<int>(json['revision']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'role': serializer.toJson<String>(role),
      'unitId': serializer.toJson<String?>(unitId),
      'status': serializer.toJson<String>(status),
      'memberCode': serializer.toJson<String>(memberCode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'verifiedAt': serializer.toJson<DateTime?>(verifiedAt),
      'revision': serializer.toJson<int>(revision),
    };
  }

  MemberRow copyWith({
    String? id,
    String? name,
    Value<String?> phone = const Value.absent(),
    String? role,
    Value<String?> unitId = const Value.absent(),
    String? status,
    String? memberCode,
    DateTime? createdAt,
    Value<DateTime?> verifiedAt = const Value.absent(),
    int? revision,
  }) => MemberRow(
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    role: role ?? this.role,
    unitId: unitId.present ? unitId.value : this.unitId,
    status: status ?? this.status,
    memberCode: memberCode ?? this.memberCode,
    createdAt: createdAt ?? this.createdAt,
    verifiedAt: verifiedAt.present ? verifiedAt.value : this.verifiedAt,
    revision: revision ?? this.revision,
  );
  MemberRow copyWithCompanion(MembersCompanion data) {
    return MemberRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      role: data.role.present ? data.role.value : this.role,
      unitId: data.unitId.present ? data.unitId.value : this.unitId,
      status: data.status.present ? data.status.value : this.status,
      memberCode: data.memberCode.present
          ? data.memberCode.value
          : this.memberCode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      verifiedAt: data.verifiedAt.present
          ? data.verifiedAt.value
          : this.verifiedAt,
      revision: data.revision.present ? data.revision.value : this.revision,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MemberRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('role: $role, ')
          ..write('unitId: $unitId, ')
          ..write('status: $status, ')
          ..write('memberCode: $memberCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('verifiedAt: $verifiedAt, ')
          ..write('revision: $revision')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    phone,
    role,
    unitId,
    status,
    memberCode,
    createdAt,
    verifiedAt,
    revision,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemberRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.role == this.role &&
          other.unitId == this.unitId &&
          other.status == this.status &&
          other.memberCode == this.memberCode &&
          other.createdAt == this.createdAt &&
          other.verifiedAt == this.verifiedAt &&
          other.revision == this.revision);
}

class MembersCompanion extends UpdateCompanion<MemberRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String> role;
  final Value<String?> unitId;
  final Value<String> status;
  final Value<String> memberCode;
  final Value<DateTime> createdAt;
  final Value<DateTime?> verifiedAt;
  final Value<int> revision;
  final Value<int> rowid;
  const MembersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.role = const Value.absent(),
    this.unitId = const Value.absent(),
    this.status = const Value.absent(),
    this.memberCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.verifiedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MembersCompanion.insert({
    required String id,
    required String name,
    this.phone = const Value.absent(),
    required String role,
    this.unitId = const Value.absent(),
    required String status,
    required String memberCode,
    required DateTime createdAt,
    this.verifiedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       role = Value(role),
       status = Value(status),
       memberCode = Value(memberCode),
       createdAt = Value(createdAt);
  static Insertable<MemberRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? role,
    Expression<String>? unitId,
    Expression<String>? status,
    Expression<String>? memberCode,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? verifiedAt,
    Expression<int>? revision,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (role != null) 'role': role,
      if (unitId != null) 'unit_id': unitId,
      if (status != null) 'status': status,
      if (memberCode != null) 'member_code': memberCode,
      if (createdAt != null) 'created_at': createdAt,
      if (verifiedAt != null) 'verified_at': verifiedAt,
      if (revision != null) 'revision': revision,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MembersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? phone,
    Value<String>? role,
    Value<String?>? unitId,
    Value<String>? status,
    Value<String>? memberCode,
    Value<DateTime>? createdAt,
    Value<DateTime?>? verifiedAt,
    Value<int>? revision,
    Value<int>? rowid,
  }) {
    return MembersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      unitId: unitId ?? this.unitId,
      status: status ?? this.status,
      memberCode: memberCode ?? this.memberCode,
      createdAt: createdAt ?? this.createdAt,
      verifiedAt: verifiedAt ?? this.verifiedAt,
      revision: revision ?? this.revision,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<String>(unitId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (memberCode.present) {
      map['member_code'] = Variable<String>(memberCode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (verifiedAt.present) {
      map['verified_at'] = Variable<DateTime>(verifiedAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MembersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('role: $role, ')
          ..write('unitId: $unitId, ')
          ..write('status: $status, ')
          ..write('memberCode: $memberCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('verifiedAt: $verifiedAt, ')
          ..write('revision: $revision, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncOutboxTable extends SyncOutbox
    with TableInfo<$SyncOutboxTable, SyncOpRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncOutboxTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _clientUuidMeta = const VerificationMeta(
    'clientUuid',
  );
  @override
  late final GeneratedColumn<String> clientUuid = GeneratedColumn<String>(
    'client_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityMeta = const VerificationMeta('entity');
  @override
  late final GeneratedColumn<String> entity = GeneratedColumn<String>(
    'entity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _opMeta = const VerificationMeta('op');
  @override
  late final GeneratedColumn<String> op = GeneratedColumn<String>(
    'op',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    clientUuid,
    entity,
    entityId,
    op,
    payload,
    attempts,
    lastError,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_outbox';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncOpRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('client_uuid')) {
      context.handle(
        _clientUuidMeta,
        clientUuid.isAcceptableOrUnknown(data['client_uuid']!, _clientUuidMeta),
      );
    } else if (isInserting) {
      context.missing(_clientUuidMeta);
    }
    if (data.containsKey('entity')) {
      context.handle(
        _entityMeta,
        entity.isAcceptableOrUnknown(data['entity']!, _entityMeta),
      );
    } else if (isInserting) {
      context.missing(_entityMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('op')) {
      context.handle(_opMeta, op.isAcceptableOrUnknown(data['op']!, _opMeta));
    } else if (isInserting) {
      context.missing(_opMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clientUuid};
  @override
  SyncOpRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncOpRow(
      clientUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_uuid'],
      )!,
      entity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      op: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}op'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      attempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempts'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SyncOutboxTable createAlias(String alias) {
    return $SyncOutboxTable(attachedDatabase, alias);
  }
}

class SyncOpRow extends DataClass implements Insertable<SyncOpRow> {
  /// Idempotency key — the server can safely apply the same op twice.
  final String clientUuid;
  final String entity;
  final String entityId;
  final String op;
  final String payload;
  final int attempts;
  final String? lastError;
  final DateTime createdAt;
  const SyncOpRow({
    required this.clientUuid,
    required this.entity,
    required this.entityId,
    required this.op,
    required this.payload,
    required this.attempts,
    this.lastError,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['client_uuid'] = Variable<String>(clientUuid);
    map['entity'] = Variable<String>(entity);
    map['entity_id'] = Variable<String>(entityId);
    map['op'] = Variable<String>(op);
    map['payload'] = Variable<String>(payload);
    map['attempts'] = Variable<int>(attempts);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SyncOutboxCompanion toCompanion(bool nullToAbsent) {
    return SyncOutboxCompanion(
      clientUuid: Value(clientUuid),
      entity: Value(entity),
      entityId: Value(entityId),
      op: Value(op),
      payload: Value(payload),
      attempts: Value(attempts),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      createdAt: Value(createdAt),
    );
  }

  factory SyncOpRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncOpRow(
      clientUuid: serializer.fromJson<String>(json['clientUuid']),
      entity: serializer.fromJson<String>(json['entity']),
      entityId: serializer.fromJson<String>(json['entityId']),
      op: serializer.fromJson<String>(json['op']),
      payload: serializer.fromJson<String>(json['payload']),
      attempts: serializer.fromJson<int>(json['attempts']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clientUuid': serializer.toJson<String>(clientUuid),
      'entity': serializer.toJson<String>(entity),
      'entityId': serializer.toJson<String>(entityId),
      'op': serializer.toJson<String>(op),
      'payload': serializer.toJson<String>(payload),
      'attempts': serializer.toJson<int>(attempts),
      'lastError': serializer.toJson<String?>(lastError),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SyncOpRow copyWith({
    String? clientUuid,
    String? entity,
    String? entityId,
    String? op,
    String? payload,
    int? attempts,
    Value<String?> lastError = const Value.absent(),
    DateTime? createdAt,
  }) => SyncOpRow(
    clientUuid: clientUuid ?? this.clientUuid,
    entity: entity ?? this.entity,
    entityId: entityId ?? this.entityId,
    op: op ?? this.op,
    payload: payload ?? this.payload,
    attempts: attempts ?? this.attempts,
    lastError: lastError.present ? lastError.value : this.lastError,
    createdAt: createdAt ?? this.createdAt,
  );
  SyncOpRow copyWithCompanion(SyncOutboxCompanion data) {
    return SyncOpRow(
      clientUuid: data.clientUuid.present
          ? data.clientUuid.value
          : this.clientUuid,
      entity: data.entity.present ? data.entity.value : this.entity,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      op: data.op.present ? data.op.value : this.op,
      payload: data.payload.present ? data.payload.value : this.payload,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncOpRow(')
          ..write('clientUuid: $clientUuid, ')
          ..write('entity: $entity, ')
          ..write('entityId: $entityId, ')
          ..write('op: $op, ')
          ..write('payload: $payload, ')
          ..write('attempts: $attempts, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    clientUuid,
    entity,
    entityId,
    op,
    payload,
    attempts,
    lastError,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncOpRow &&
          other.clientUuid == this.clientUuid &&
          other.entity == this.entity &&
          other.entityId == this.entityId &&
          other.op == this.op &&
          other.payload == this.payload &&
          other.attempts == this.attempts &&
          other.lastError == this.lastError &&
          other.createdAt == this.createdAt);
}

class SyncOutboxCompanion extends UpdateCompanion<SyncOpRow> {
  final Value<String> clientUuid;
  final Value<String> entity;
  final Value<String> entityId;
  final Value<String> op;
  final Value<String> payload;
  final Value<int> attempts;
  final Value<String?> lastError;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SyncOutboxCompanion({
    this.clientUuid = const Value.absent(),
    this.entity = const Value.absent(),
    this.entityId = const Value.absent(),
    this.op = const Value.absent(),
    this.payload = const Value.absent(),
    this.attempts = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncOutboxCompanion.insert({
    required String clientUuid,
    required String entity,
    required String entityId,
    required String op,
    required String payload,
    this.attempts = const Value.absent(),
    this.lastError = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : clientUuid = Value(clientUuid),
       entity = Value(entity),
       entityId = Value(entityId),
       op = Value(op),
       payload = Value(payload),
       createdAt = Value(createdAt);
  static Insertable<SyncOpRow> custom({
    Expression<String>? clientUuid,
    Expression<String>? entity,
    Expression<String>? entityId,
    Expression<String>? op,
    Expression<String>? payload,
    Expression<int>? attempts,
    Expression<String>? lastError,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clientUuid != null) 'client_uuid': clientUuid,
      if (entity != null) 'entity': entity,
      if (entityId != null) 'entity_id': entityId,
      if (op != null) 'op': op,
      if (payload != null) 'payload': payload,
      if (attempts != null) 'attempts': attempts,
      if (lastError != null) 'last_error': lastError,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncOutboxCompanion copyWith({
    Value<String>? clientUuid,
    Value<String>? entity,
    Value<String>? entityId,
    Value<String>? op,
    Value<String>? payload,
    Value<int>? attempts,
    Value<String?>? lastError,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SyncOutboxCompanion(
      clientUuid: clientUuid ?? this.clientUuid,
      entity: entity ?? this.entity,
      entityId: entityId ?? this.entityId,
      op: op ?? this.op,
      payload: payload ?? this.payload,
      attempts: attempts ?? this.attempts,
      lastError: lastError ?? this.lastError,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clientUuid.present) {
      map['client_uuid'] = Variable<String>(clientUuid.value);
    }
    if (entity.present) {
      map['entity'] = Variable<String>(entity.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (op.present) {
      map['op'] = Variable<String>(op.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncOutboxCompanion(')
          ..write('clientUuid: $clientUuid, ')
          ..write('entity: $entity, ')
          ..write('entityId: $entityId, ')
          ..write('op: $op, ')
          ..write('payload: $payload, ')
          ..write('attempts: $attempts, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NoticesTable extends Notices with TableInfo<$NoticesTable, NoticeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NoticesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<String> unitId = GeneratedColumn<String>(
    'unit_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _authorNameMeta = const VerificationMeta(
    'authorName',
  );
  @override
  late final GeneratedColumn<String> authorName = GeneratedColumn<String>(
    'author_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _readAtMeta = const VerificationMeta('readAt');
  @override
  late final GeneratedColumn<DateTime> readAt = GeneratedColumn<DateTime>(
    'read_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    body,
    priority,
    unitId,
    authorName,
    createdAt,
    readAt,
    revision,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notices';
  @override
  VerificationContext validateIntegrity(
    Insertable<NoticeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('unit_id')) {
      context.handle(
        _unitIdMeta,
        unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta),
      );
    }
    if (data.containsKey('author_name')) {
      context.handle(
        _authorNameMeta,
        authorName.isAcceptableOrUnknown(data['author_name']!, _authorNameMeta),
      );
    } else if (isInserting) {
      context.missing(_authorNameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('read_at')) {
      context.handle(
        _readAtMeta,
        readAt.isAcceptableOrUnknown(data['read_at']!, _readAtMeta),
      );
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NoticeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NoticeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
      unitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_id'],
      ),
      authorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      readAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}read_at'],
      ),
      revision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision'],
      )!,
    );
  }

  @override
  $NoticesTable createAlias(String alias) {
    return $NoticesTable(attachedDatabase, alias);
  }
}

class NoticeRow extends DataClass implements Insertable<NoticeRow> {
  final String id;
  final String title;
  final String body;
  final String priority;

  /// Audience: an org unit id, or null for every unit.
  final String? unitId;
  final String authorName;
  final DateTime createdAt;

  /// Device-local read receipt — never uploaded.
  final DateTime? readAt;
  final int revision;
  const NoticeRow({
    required this.id,
    required this.title,
    required this.body,
    required this.priority,
    this.unitId,
    required this.authorName,
    required this.createdAt,
    this.readAt,
    required this.revision,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    map['priority'] = Variable<String>(priority);
    if (!nullToAbsent || unitId != null) {
      map['unit_id'] = Variable<String>(unitId);
    }
    map['author_name'] = Variable<String>(authorName);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || readAt != null) {
      map['read_at'] = Variable<DateTime>(readAt);
    }
    map['revision'] = Variable<int>(revision);
    return map;
  }

  NoticesCompanion toCompanion(bool nullToAbsent) {
    return NoticesCompanion(
      id: Value(id),
      title: Value(title),
      body: Value(body),
      priority: Value(priority),
      unitId: unitId == null && nullToAbsent
          ? const Value.absent()
          : Value(unitId),
      authorName: Value(authorName),
      createdAt: Value(createdAt),
      readAt: readAt == null && nullToAbsent
          ? const Value.absent()
          : Value(readAt),
      revision: Value(revision),
    );
  }

  factory NoticeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoticeRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      priority: serializer.fromJson<String>(json['priority']),
      unitId: serializer.fromJson<String?>(json['unitId']),
      authorName: serializer.fromJson<String>(json['authorName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      readAt: serializer.fromJson<DateTime?>(json['readAt']),
      revision: serializer.fromJson<int>(json['revision']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'priority': serializer.toJson<String>(priority),
      'unitId': serializer.toJson<String?>(unitId),
      'authorName': serializer.toJson<String>(authorName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'readAt': serializer.toJson<DateTime?>(readAt),
      'revision': serializer.toJson<int>(revision),
    };
  }

  NoticeRow copyWith({
    String? id,
    String? title,
    String? body,
    String? priority,
    Value<String?> unitId = const Value.absent(),
    String? authorName,
    DateTime? createdAt,
    Value<DateTime?> readAt = const Value.absent(),
    int? revision,
  }) => NoticeRow(
    id: id ?? this.id,
    title: title ?? this.title,
    body: body ?? this.body,
    priority: priority ?? this.priority,
    unitId: unitId.present ? unitId.value : this.unitId,
    authorName: authorName ?? this.authorName,
    createdAt: createdAt ?? this.createdAt,
    readAt: readAt.present ? readAt.value : this.readAt,
    revision: revision ?? this.revision,
  );
  NoticeRow copyWithCompanion(NoticesCompanion data) {
    return NoticeRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      priority: data.priority.present ? data.priority.value : this.priority,
      unitId: data.unitId.present ? data.unitId.value : this.unitId,
      authorName: data.authorName.present
          ? data.authorName.value
          : this.authorName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      readAt: data.readAt.present ? data.readAt.value : this.readAt,
      revision: data.revision.present ? data.revision.value : this.revision,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NoticeRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('priority: $priority, ')
          ..write('unitId: $unitId, ')
          ..write('authorName: $authorName, ')
          ..write('createdAt: $createdAt, ')
          ..write('readAt: $readAt, ')
          ..write('revision: $revision')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    body,
    priority,
    unitId,
    authorName,
    createdAt,
    readAt,
    revision,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoticeRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.body == this.body &&
          other.priority == this.priority &&
          other.unitId == this.unitId &&
          other.authorName == this.authorName &&
          other.createdAt == this.createdAt &&
          other.readAt == this.readAt &&
          other.revision == this.revision);
}

class NoticesCompanion extends UpdateCompanion<NoticeRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> body;
  final Value<String> priority;
  final Value<String?> unitId;
  final Value<String> authorName;
  final Value<DateTime> createdAt;
  final Value<DateTime?> readAt;
  final Value<int> revision;
  final Value<int> rowid;
  const NoticesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.priority = const Value.absent(),
    this.unitId = const Value.absent(),
    this.authorName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.readAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NoticesCompanion.insert({
    required String id,
    required String title,
    required String body,
    required String priority,
    this.unitId = const Value.absent(),
    required String authorName,
    required DateTime createdAt,
    this.readAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       body = Value(body),
       priority = Value(priority),
       authorName = Value(authorName),
       createdAt = Value(createdAt);
  static Insertable<NoticeRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? body,
    Expression<String>? priority,
    Expression<String>? unitId,
    Expression<String>? authorName,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? readAt,
    Expression<int>? revision,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (priority != null) 'priority': priority,
      if (unitId != null) 'unit_id': unitId,
      if (authorName != null) 'author_name': authorName,
      if (createdAt != null) 'created_at': createdAt,
      if (readAt != null) 'read_at': readAt,
      if (revision != null) 'revision': revision,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NoticesCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? body,
    Value<String>? priority,
    Value<String?>? unitId,
    Value<String>? authorName,
    Value<DateTime>? createdAt,
    Value<DateTime?>? readAt,
    Value<int>? revision,
    Value<int>? rowid,
  }) {
    return NoticesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      priority: priority ?? this.priority,
      unitId: unitId ?? this.unitId,
      authorName: authorName ?? this.authorName,
      createdAt: createdAt ?? this.createdAt,
      readAt: readAt ?? this.readAt,
      revision: revision ?? this.revision,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<String>(unitId.value);
    }
    if (authorName.present) {
      map['author_name'] = Variable<String>(authorName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (readAt.present) {
      map['read_at'] = Variable<DateTime>(readAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NoticesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('priority: $priority, ')
          ..write('unitId: $unitId, ')
          ..write('authorName: $authorName, ')
          ..write('createdAt: $createdAt, ')
          ..write('readAt: $readAt, ')
          ..write('revision: $revision, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $OrgUnitsTable orgUnits = $OrgUnitsTable(this);
  late final $SyncCursorsTable syncCursors = $SyncCursorsTable(this);
  late final $GrievancesTable grievances = $GrievancesTable(this);
  late final $GrievanceEventsTable grievanceEvents = $GrievanceEventsTable(
    this,
  );
  late final $MembersTable members = $MembersTable(this);
  late final $SyncOutboxTable syncOutbox = $SyncOutboxTable(this);
  late final $NoticesTable notices = $NoticesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    orgUnits,
    syncCursors,
    grievances,
    grievanceEvents,
    members,
    syncOutbox,
    notices,
  ];
}

typedef $$OrgUnitsTableCreateCompanionBuilder = OrgUnitsCompanion Function({
  required String id,
  required String type,
  required String nameEn,
  Value<String?> nameHi,
  Value<String?> nameUr,
  Value<String?> parentId,
  Value<String?> geoCode,
  Value<String?> centroid,
  Value<int> revision,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$OrgUnitsTableUpdateCompanionBuilder = OrgUnitsCompanion Function({
  Value<String> id,
  Value<String> type,
  Value<String> nameEn,
  Value<String?> nameHi,
  Value<String?> nameUr,
  Value<String?> parentId,
  Value<String?> geoCode,
  Value<String?> centroid,
  Value<int> revision,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

class $$OrgUnitsTableFilterComposer
    extends Composer<_$AppDatabase, $OrgUnitsTable> {
  $$OrgUnitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameHi => $composableBuilder(
    column: $table.nameHi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameUr => $composableBuilder(
    column: $table.nameUr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get geoCode => $composableBuilder(
    column: $table.geoCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get centroid => $composableBuilder(
    column: $table.centroid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OrgUnitsTableOrderingComposer
    extends Composer<_$AppDatabase, $OrgUnitsTable> {
  $$OrgUnitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameHi => $composableBuilder(
    column: $table.nameHi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameUr => $composableBuilder(
    column: $table.nameUr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get geoCode => $composableBuilder(
    column: $table.geoCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get centroid => $composableBuilder(
    column: $table.centroid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OrgUnitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrgUnitsTable> {
  $$OrgUnitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameHi =>
      $composableBuilder(column: $table.nameHi, builder: (column) => column);

  GeneratedColumn<String> get nameUr =>
      $composableBuilder(column: $table.nameUr, builder: (column) => column);

  GeneratedColumn<String> get parentId =>
      $composableBuilder(column: $table.parentId, builder: (column) => column);

  GeneratedColumn<String> get geoCode =>
      $composableBuilder(column: $table.geoCode, builder: (column) => column);

  GeneratedColumn<String> get centroid =>
      $composableBuilder(column: $table.centroid, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$OrgUnitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrgUnitsTable,
          OrgUnitRow,
          $$OrgUnitsTableFilterComposer,
          $$OrgUnitsTableOrderingComposer,
          $$OrgUnitsTableAnnotationComposer,
          $$OrgUnitsTableCreateCompanionBuilder,
          $$OrgUnitsTableUpdateCompanionBuilder,
          (
            OrgUnitRow,
            BaseReferences<_$AppDatabase, $OrgUnitsTable, OrgUnitRow>,
          ),
          OrgUnitRow,
          PrefetchHooks Function()
        > {
  $$OrgUnitsTableTableManager(_$AppDatabase db, $OrgUnitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrgUnitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrgUnitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrgUnitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String?> nameHi = const Value.absent(),
                Value<String?> nameUr = const Value.absent(),
                Value<String?> parentId = const Value.absent(),
                Value<String?> geoCode = const Value.absent(),
                Value<String?> centroid = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrgUnitsCompanion(
                id: id,
                type: type,
                nameEn: nameEn,
                nameHi: nameHi,
                nameUr: nameUr,
                parentId: parentId,
                geoCode: geoCode,
                centroid: centroid,
                revision: revision,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String type,
                required String nameEn,
                Value<String?> nameHi = const Value.absent(),
                Value<String?> nameUr = const Value.absent(),
                Value<String?> parentId = const Value.absent(),
                Value<String?> geoCode = const Value.absent(),
                Value<String?> centroid = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrgUnitsCompanion.insert(
                id: id,
                type: type,
                nameEn: nameEn,
                nameHi: nameHi,
                nameUr: nameUr,
                parentId: parentId,
                geoCode: geoCode,
                centroid: centroid,
                revision: revision,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$OrgUnitsTable, OrgUnitRow>(table),
                  BaseReferences<_$AppDatabase, $OrgUnitsTable, OrgUnitRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OrgUnitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrgUnitsTable,
      OrgUnitRow,
      $$OrgUnitsTableFilterComposer,
      $$OrgUnitsTableOrderingComposer,
      $$OrgUnitsTableAnnotationComposer,
      $$OrgUnitsTableCreateCompanionBuilder,
      $$OrgUnitsTableUpdateCompanionBuilder,
      (OrgUnitRow, BaseReferences<_$AppDatabase, $OrgUnitsTable, OrgUnitRow>),
      OrgUnitRow,
      PrefetchHooks Function()
    >;
typedef $$SyncCursorsTableCreateCompanionBuilder =
    SyncCursorsCompanion Function({
      required String deviceKey,
      Value<int> lastRevision,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$SyncCursorsTableUpdateCompanionBuilder =
    SyncCursorsCompanion Function({
      Value<String> deviceKey,
      Value<int> lastRevision,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

class $$SyncCursorsTableFilterComposer
    extends Composer<_$AppDatabase, $SyncCursorsTable> {
  $$SyncCursorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get deviceKey => $composableBuilder(
    column: $table.deviceKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastRevision => $composableBuilder(
    column: $table.lastRevision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncCursorsTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncCursorsTable> {
  $$SyncCursorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get deviceKey => $composableBuilder(
    column: $table.deviceKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastRevision => $composableBuilder(
    column: $table.lastRevision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncCursorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncCursorsTable> {
  $$SyncCursorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get deviceKey =>
      $composableBuilder(column: $table.deviceKey, builder: (column) => column);

  GeneratedColumn<int> get lastRevision => $composableBuilder(
    column: $table.lastRevision,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SyncCursorsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncCursorsTable,
          SyncCursorRow,
          $$SyncCursorsTableFilterComposer,
          $$SyncCursorsTableOrderingComposer,
          $$SyncCursorsTableAnnotationComposer,
          $$SyncCursorsTableCreateCompanionBuilder,
          $$SyncCursorsTableUpdateCompanionBuilder,
          (
            SyncCursorRow,
            BaseReferences<_$AppDatabase, $SyncCursorsTable, SyncCursorRow>,
          ),
          SyncCursorRow,
          PrefetchHooks Function()
        > {
  $$SyncCursorsTableTableManager(_$AppDatabase db, $SyncCursorsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncCursorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncCursorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncCursorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> deviceKey = const Value.absent(),
                Value<int> lastRevision = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncCursorsCompanion(
                deviceKey: deviceKey,
                lastRevision: lastRevision,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String deviceKey,
                Value<int> lastRevision = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncCursorsCompanion.insert(
                deviceKey: deviceKey,
                lastRevision: lastRevision,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyncCursorsTable, SyncCursorRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SyncCursorsTable,
                    SyncCursorRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncCursorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncCursorsTable,
      SyncCursorRow,
      $$SyncCursorsTableFilterComposer,
      $$SyncCursorsTableOrderingComposer,
      $$SyncCursorsTableAnnotationComposer,
      $$SyncCursorsTableCreateCompanionBuilder,
      $$SyncCursorsTableUpdateCompanionBuilder,
      (
        SyncCursorRow,
        BaseReferences<_$AppDatabase, $SyncCursorsTable, SyncCursorRow>,
      ),
      SyncCursorRow,
      PrefetchHooks Function()
    >;
typedef $$GrievancesTableCreateCompanionBuilder = GrievancesCompanion Function({
  required String id,
  required String refCode,
  required String title,
  required String description,
  required String category,
  Value<String?> unitId,
  required String status,
  Value<String?> reporterName,
  Value<String?> reporterPhone,
  required DateTime createdAt,
  Value<DateTime?> resolvedAt,
  Value<String?> resolutionNote,
  Value<int> revision,
  Value<int> rowid,
});
typedef $$GrievancesTableUpdateCompanionBuilder = GrievancesCompanion Function({
  Value<String> id,
  Value<String> refCode,
  Value<String> title,
  Value<String> description,
  Value<String> category,
  Value<String?> unitId,
  Value<String> status,
  Value<String?> reporterName,
  Value<String?> reporterPhone,
  Value<DateTime> createdAt,
  Value<DateTime?> resolvedAt,
  Value<String?> resolutionNote,
  Value<int> revision,
  Value<int> rowid,
});

class $$GrievancesTableFilterComposer
    extends Composer<_$AppDatabase, $GrievancesTable> {
  $$GrievancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get refCode => $composableBuilder(
    column: $table.refCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unitId => $composableBuilder(
    column: $table.unitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reporterName => $composableBuilder(
    column: $table.reporterName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reporterPhone => $composableBuilder(
    column: $table.reporterPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resolutionNote => $composableBuilder(
    column: $table.resolutionNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GrievancesTableOrderingComposer
    extends Composer<_$AppDatabase, $GrievancesTable> {
  $$GrievancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get refCode => $composableBuilder(
    column: $table.refCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unitId => $composableBuilder(
    column: $table.unitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reporterName => $composableBuilder(
    column: $table.reporterName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reporterPhone => $composableBuilder(
    column: $table.reporterPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resolutionNote => $composableBuilder(
    column: $table.resolutionNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GrievancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GrievancesTable> {
  $$GrievancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get refCode =>
      $composableBuilder(column: $table.refCode, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get unitId =>
      $composableBuilder(column: $table.unitId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get reporterName => $composableBuilder(
    column: $table.reporterName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reporterPhone => $composableBuilder(
    column: $table.reporterPhone,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get resolutionNote => $composableBuilder(
    column: $table.resolutionNote,
    builder: (column) => column,
  );

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);
}

class $$GrievancesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GrievancesTable,
          GrievanceRow,
          $$GrievancesTableFilterComposer,
          $$GrievancesTableOrderingComposer,
          $$GrievancesTableAnnotationComposer,
          $$GrievancesTableCreateCompanionBuilder,
          $$GrievancesTableUpdateCompanionBuilder,
          (
            GrievanceRow,
            BaseReferences<_$AppDatabase, $GrievancesTable, GrievanceRow>,
          ),
          GrievanceRow,
          PrefetchHooks Function()
        > {
  $$GrievancesTableTableManager(_$AppDatabase db, $GrievancesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GrievancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GrievancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GrievancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> refCode = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> unitId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> reporterName = const Value.absent(),
                Value<String?> reporterPhone = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> resolvedAt = const Value.absent(),
                Value<String?> resolutionNote = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GrievancesCompanion(
                id: id,
                refCode: refCode,
                title: title,
                description: description,
                category: category,
                unitId: unitId,
                status: status,
                reporterName: reporterName,
                reporterPhone: reporterPhone,
                createdAt: createdAt,
                resolvedAt: resolvedAt,
                resolutionNote: resolutionNote,
                revision: revision,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String refCode,
                required String title,
                required String description,
                required String category,
                Value<String?> unitId = const Value.absent(),
                required String status,
                Value<String?> reporterName = const Value.absent(),
                Value<String?> reporterPhone = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> resolvedAt = const Value.absent(),
                Value<String?> resolutionNote = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GrievancesCompanion.insert(
                id: id,
                refCode: refCode,
                title: title,
                description: description,
                category: category,
                unitId: unitId,
                status: status,
                reporterName: reporterName,
                reporterPhone: reporterPhone,
                createdAt: createdAt,
                resolvedAt: resolvedAt,
                resolutionNote: resolutionNote,
                revision: revision,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GrievancesTable, GrievanceRow>(table),
                  BaseReferences<_$AppDatabase, $GrievancesTable, GrievanceRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GrievancesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GrievancesTable,
      GrievanceRow,
      $$GrievancesTableFilterComposer,
      $$GrievancesTableOrderingComposer,
      $$GrievancesTableAnnotationComposer,
      $$GrievancesTableCreateCompanionBuilder,
      $$GrievancesTableUpdateCompanionBuilder,
      (
        GrievanceRow,
        BaseReferences<_$AppDatabase, $GrievancesTable, GrievanceRow>,
      ),
      GrievanceRow,
      PrefetchHooks Function()
    >;
typedef $$GrievanceEventsTableCreateCompanionBuilder =
    GrievanceEventsCompanion Function({
      required String id,
      required String grievanceId,
      required String type,
      required String note,
      Value<String?> actorName,
      required DateTime createdAt,
      Value<int> revision,
      Value<int> rowid,
    });
typedef $$GrievanceEventsTableUpdateCompanionBuilder =
    GrievanceEventsCompanion Function({
      Value<String> id,
      Value<String> grievanceId,
      Value<String> type,
      Value<String> note,
      Value<String?> actorName,
      Value<DateTime> createdAt,
      Value<int> revision,
      Value<int> rowid,
    });

class $$GrievanceEventsTableFilterComposer
    extends Composer<_$AppDatabase, $GrievanceEventsTable> {
  $$GrievanceEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grievanceId => $composableBuilder(
    column: $table.grievanceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actorName => $composableBuilder(
    column: $table.actorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GrievanceEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $GrievanceEventsTable> {
  $$GrievanceEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grievanceId => $composableBuilder(
    column: $table.grievanceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actorName => $composableBuilder(
    column: $table.actorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GrievanceEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GrievanceEventsTable> {
  $$GrievanceEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get grievanceId => $composableBuilder(
    column: $table.grievanceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get actorName =>
      $composableBuilder(column: $table.actorName, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);
}

class $$GrievanceEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GrievanceEventsTable,
          GrievanceEventRow,
          $$GrievanceEventsTableFilterComposer,
          $$GrievanceEventsTableOrderingComposer,
          $$GrievanceEventsTableAnnotationComposer,
          $$GrievanceEventsTableCreateCompanionBuilder,
          $$GrievanceEventsTableUpdateCompanionBuilder,
          (
            GrievanceEventRow,
            BaseReferences<
              _$AppDatabase,
              $GrievanceEventsTable,
              GrievanceEventRow
            >,
          ),
          GrievanceEventRow,
          PrefetchHooks Function()
        > {
  $$GrievanceEventsTableTableManager(
    _$AppDatabase db,
    $GrievanceEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GrievanceEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GrievanceEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GrievanceEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> grievanceId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<String?> actorName = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GrievanceEventsCompanion(
                id: id,
                grievanceId: grievanceId,
                type: type,
                note: note,
                actorName: actorName,
                createdAt: createdAt,
                revision: revision,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String grievanceId,
                required String type,
                required String note,
                Value<String?> actorName = const Value.absent(),
                required DateTime createdAt,
                Value<int> revision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GrievanceEventsCompanion.insert(
                id: id,
                grievanceId: grievanceId,
                type: type,
                note: note,
                actorName: actorName,
                createdAt: createdAt,
                revision: revision,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GrievanceEventsTable, GrievanceEventRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $GrievanceEventsTable,
                    GrievanceEventRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GrievanceEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GrievanceEventsTable,
      GrievanceEventRow,
      $$GrievanceEventsTableFilterComposer,
      $$GrievanceEventsTableOrderingComposer,
      $$GrievanceEventsTableAnnotationComposer,
      $$GrievanceEventsTableCreateCompanionBuilder,
      $$GrievanceEventsTableUpdateCompanionBuilder,
      (
        GrievanceEventRow,
        BaseReferences<_$AppDatabase, $GrievanceEventsTable, GrievanceEventRow>,
      ),
      GrievanceEventRow,
      PrefetchHooks Function()
    >;
typedef $$MembersTableCreateCompanionBuilder = MembersCompanion Function({
  required String id,
  required String name,
  Value<String?> phone,
  required String role,
  Value<String?> unitId,
  required String status,
  required String memberCode,
  required DateTime createdAt,
  Value<DateTime?> verifiedAt,
  Value<int> revision,
  Value<int> rowid,
});
typedef $$MembersTableUpdateCompanionBuilder = MembersCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> phone,
  Value<String> role,
  Value<String?> unitId,
  Value<String> status,
  Value<String> memberCode,
  Value<DateTime> createdAt,
  Value<DateTime?> verifiedAt,
  Value<int> revision,
  Value<int> rowid,
});

class $$MembersTableFilterComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unitId => $composableBuilder(
    column: $table.unitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memberCode => $composableBuilder(
    column: $table.memberCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get verifiedAt => $composableBuilder(
    column: $table.verifiedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MembersTableOrderingComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unitId => $composableBuilder(
    column: $table.unitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memberCode => $composableBuilder(
    column: $table.memberCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get verifiedAt => $composableBuilder(
    column: $table.verifiedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get unitId =>
      $composableBuilder(column: $table.unitId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get memberCode => $composableBuilder(
    column: $table.memberCode,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get verifiedAt => $composableBuilder(
    column: $table.verifiedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);
}

class $$MembersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MembersTable,
          MemberRow,
          $$MembersTableFilterComposer,
          $$MembersTableOrderingComposer,
          $$MembersTableAnnotationComposer,
          $$MembersTableCreateCompanionBuilder,
          $$MembersTableUpdateCompanionBuilder,
          (MemberRow, BaseReferences<_$AppDatabase, $MembersTable, MemberRow>),
          MemberRow,
          PrefetchHooks Function()
        > {
  $$MembersTableTableManager(_$AppDatabase db, $MembersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MembersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MembersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String?> unitId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> memberCode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> verifiedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembersCompanion(
                id: id,
                name: name,
                phone: phone,
                role: role,
                unitId: unitId,
                status: status,
                memberCode: memberCode,
                createdAt: createdAt,
                verifiedAt: verifiedAt,
                revision: revision,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> phone = const Value.absent(),
                required String role,
                Value<String?> unitId = const Value.absent(),
                required String status,
                required String memberCode,
                required DateTime createdAt,
                Value<DateTime?> verifiedAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembersCompanion.insert(
                id: id,
                name: name,
                phone: phone,
                role: role,
                unitId: unitId,
                status: status,
                memberCode: memberCode,
                createdAt: createdAt,
                verifiedAt: verifiedAt,
                revision: revision,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MembersTable, MemberRow>(table),
                  BaseReferences<_$AppDatabase, $MembersTable, MemberRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MembersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MembersTable,
      MemberRow,
      $$MembersTableFilterComposer,
      $$MembersTableOrderingComposer,
      $$MembersTableAnnotationComposer,
      $$MembersTableCreateCompanionBuilder,
      $$MembersTableUpdateCompanionBuilder,
      (MemberRow, BaseReferences<_$AppDatabase, $MembersTable, MemberRow>),
      MemberRow,
      PrefetchHooks Function()
    >;
typedef $$SyncOutboxTableCreateCompanionBuilder = SyncOutboxCompanion Function({
  required String clientUuid,
  required String entity,
  required String entityId,
  required String op,
  required String payload,
  Value<int> attempts,
  Value<String?> lastError,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$SyncOutboxTableUpdateCompanionBuilder = SyncOutboxCompanion Function({
  Value<String> clientUuid,
  Value<String> entity,
  Value<String> entityId,
  Value<String> op,
  Value<String> payload,
  Value<int> attempts,
  Value<String?> lastError,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$SyncOutboxTableFilterComposer
    extends Composer<_$AppDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entity => $composableBuilder(
    column: $table.entity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get op => $composableBuilder(
    column: $table.op,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncOutboxTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entity => $composableBuilder(
    column: $table.entity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get op => $composableBuilder(
    column: $table.op,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncOutboxTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entity =>
      $composableBuilder(column: $table.entity, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get op =>
      $composableBuilder(column: $table.op, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SyncOutboxTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncOutboxTable,
          SyncOpRow,
          $$SyncOutboxTableFilterComposer,
          $$SyncOutboxTableOrderingComposer,
          $$SyncOutboxTableAnnotationComposer,
          $$SyncOutboxTableCreateCompanionBuilder,
          $$SyncOutboxTableUpdateCompanionBuilder,
          (
            SyncOpRow,
            BaseReferences<_$AppDatabase, $SyncOutboxTable, SyncOpRow>,
          ),
          SyncOpRow,
          PrefetchHooks Function()
        > {
  $$SyncOutboxTableTableManager(_$AppDatabase db, $SyncOutboxTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncOutboxTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncOutboxTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncOutboxTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> clientUuid = const Value.absent(),
                Value<String> entity = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> op = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncOutboxCompanion(
                clientUuid: clientUuid,
                entity: entity,
                entityId: entityId,
                op: op,
                payload: payload,
                attempts: attempts,
                lastError: lastError,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String clientUuid,
                required String entity,
                required String entityId,
                required String op,
                required String payload,
                Value<int> attempts = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => SyncOutboxCompanion.insert(
                clientUuid: clientUuid,
                entity: entity,
                entityId: entityId,
                op: op,
                payload: payload,
                attempts: attempts,
                lastError: lastError,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyncOutboxTable, SyncOpRow>(table),
                  BaseReferences<_$AppDatabase, $SyncOutboxTable, SyncOpRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncOutboxTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncOutboxTable,
      SyncOpRow,
      $$SyncOutboxTableFilterComposer,
      $$SyncOutboxTableOrderingComposer,
      $$SyncOutboxTableAnnotationComposer,
      $$SyncOutboxTableCreateCompanionBuilder,
      $$SyncOutboxTableUpdateCompanionBuilder,
      (SyncOpRow, BaseReferences<_$AppDatabase, $SyncOutboxTable, SyncOpRow>),
      SyncOpRow,
      PrefetchHooks Function()
    >;
typedef $$NoticesTableCreateCompanionBuilder = NoticesCompanion Function({
  required String id,
  required String title,
  required String body,
  required String priority,
  Value<String?> unitId,
  required String authorName,
  required DateTime createdAt,
  Value<DateTime?> readAt,
  Value<int> revision,
  Value<int> rowid,
});
typedef $$NoticesTableUpdateCompanionBuilder = NoticesCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> body,
  Value<String> priority,
  Value<String?> unitId,
  Value<String> authorName,
  Value<DateTime> createdAt,
  Value<DateTime?> readAt,
  Value<int> revision,
  Value<int> rowid,
});

class $$NoticesTableFilterComposer
    extends Composer<_$AppDatabase, $NoticesTable> {
  $$NoticesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unitId => $composableBuilder(
    column: $table.unitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get readAt => $composableBuilder(
    column: $table.readAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NoticesTableOrderingComposer
    extends Composer<_$AppDatabase, $NoticesTable> {
  $$NoticesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unitId => $composableBuilder(
    column: $table.unitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get readAt => $composableBuilder(
    column: $table.readAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NoticesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NoticesTable> {
  $$NoticesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get unitId =>
      $composableBuilder(column: $table.unitId, builder: (column) => column);

  GeneratedColumn<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get readAt =>
      $composableBuilder(column: $table.readAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);
}

class $$NoticesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NoticesTable,
          NoticeRow,
          $$NoticesTableFilterComposer,
          $$NoticesTableOrderingComposer,
          $$NoticesTableAnnotationComposer,
          $$NoticesTableCreateCompanionBuilder,
          $$NoticesTableUpdateCompanionBuilder,
          (NoticeRow, BaseReferences<_$AppDatabase, $NoticesTable, NoticeRow>),
          NoticeRow,
          PrefetchHooks Function()
        > {
  $$NoticesTableTableManager(_$AppDatabase db, $NoticesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NoticesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NoticesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NoticesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<String?> unitId = const Value.absent(),
                Value<String> authorName = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> readAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NoticesCompanion(
                id: id,
                title: title,
                body: body,
                priority: priority,
                unitId: unitId,
                authorName: authorName,
                createdAt: createdAt,
                readAt: readAt,
                revision: revision,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String body,
                required String priority,
                Value<String?> unitId = const Value.absent(),
                required String authorName,
                required DateTime createdAt,
                Value<DateTime?> readAt = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NoticesCompanion.insert(
                id: id,
                title: title,
                body: body,
                priority: priority,
                unitId: unitId,
                authorName: authorName,
                createdAt: createdAt,
                readAt: readAt,
                revision: revision,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NoticesTable, NoticeRow>(table),
                  BaseReferences<_$AppDatabase, $NoticesTable, NoticeRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NoticesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NoticesTable,
      NoticeRow,
      $$NoticesTableFilterComposer,
      $$NoticesTableOrderingComposer,
      $$NoticesTableAnnotationComposer,
      $$NoticesTableCreateCompanionBuilder,
      $$NoticesTableUpdateCompanionBuilder,
      (NoticeRow, BaseReferences<_$AppDatabase, $NoticesTable, NoticeRow>),
      NoticeRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$OrgUnitsTableTableManager get orgUnits =>
      $$OrgUnitsTableTableManager(_db, _db.orgUnits);
  $$SyncCursorsTableTableManager get syncCursors =>
      $$SyncCursorsTableTableManager(_db, _db.syncCursors);
  $$GrievancesTableTableManager get grievances =>
      $$GrievancesTableTableManager(_db, _db.grievances);
  $$GrievanceEventsTableTableManager get grievanceEvents =>
      $$GrievanceEventsTableTableManager(_db, _db.grievanceEvents);
  $$MembersTableTableManager get members =>
      $$MembersTableTableManager(_db, _db.members);
  $$SyncOutboxTableTableManager get syncOutbox =>
      $$SyncOutboxTableTableManager(_db, _db.syncOutbox);
  $$NoticesTableTableManager get notices =>
      $$NoticesTableTableManager(_db, _db.notices);
}
