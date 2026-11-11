import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../db/app_database.dart';
import '../sync/sync_data.dart';

/// The role someone holds in the civic, volunteer, party, or elected PRI structure.
enum MemberRole {
  citizen,
  volunteer,
  worker,
  panch,
  sarpanch,
  bdc,
  ddc;

  static MemberRole? tryParse(String value) {
    for (final role in values) {
      if (role.name == value) return role;
    }
    return null;
  }

  String get labelKey => switch (this) {
        MemberRole.citizen => 'roleCitizen',
        MemberRole.volunteer => 'roleVolunteer',
        MemberRole.worker => 'roleWorker',
        MemberRole.panch => 'rolePanch',
        MemberRole.sarpanch => 'roleSarpanch',
        MemberRole.bdc => 'roleBdc',
        MemberRole.ddc => 'roleDdc',
      };

  /// Elected constitutional PRI roles that cannot be self-claimed without
  /// designated verification by the RGPRS returning officer or district unit.
  bool get isElectedRole => switch (this) {
        MemberRole.panch ||
        MemberRole.sarpanch ||
        MemberRole.bdc ||
        MemberRole.ddc =>
          true,
        _ => false,
      };

  /// Roles openly enrollable by any common citizen or volunteer.
  bool get isOpenPublicEnrollment => !isElectedRole;
}

enum MemberStatus {
  pending,
  verified;

  static MemberStatus? tryParse(String value) {
    for (final status in values) {
      if (status.name == value) return status;
    }
    return null;
  }
}

/// Row id of the profile that belongs to whoever holds this device. Directory
/// rows for other members arrive with server sync.
const String localMemberId = 'me';

class MemberProfile {
  const MemberProfile({
    required this.id,
    required this.name,
    required this.role,
    required this.status,
    required this.memberCode,
    required this.createdAt,
    this.phone,
    this.unitId,
    this.verifiedAt,
  });

  final String id;
  final String name;
  final String? phone;
  final MemberRole role;

  /// Org unit the member belongs to (district today, halqa later).
  final String? unitId;
  final MemberStatus status;

  /// Stable printed identifier; survives profile edits.
  final String memberCode;
  final DateTime createdAt;
  final DateTime? verifiedAt;

  /// What another member's scanner reads. Versioned prefix so a future signed
  /// payload can be distinguished from this one.
  String get qrPayload =>
      'RGPRS1|$memberCode|${Uri.encodeComponent(name)}|${unitId ?? ''}|'
      '${role.name}|${status.name}';

  /// What leaves the device for this row.
  Map<String, Object?> toSyncPayload() => {
        'id': id,
        'name': name,
        'phone': phone,
        'role': role.name,
        'unitId': unitId,
        'status': status.name,
        'memberCode': memberCode,
        'createdAt': createdAt.toIso8601String(),
        'verifiedAt': verifiedAt?.toIso8601String(),
      };

  @override
  bool operator ==(Object other) => other is MemberProfile && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'MemberProfile($memberCode, ${role.name})';
}

abstract class MemberRepository {
  /// The device owner's profile, or null if they have not joined yet.
  Future<MemberProfile?> local();

  /// Creates or updates the local profile. The member code is minted once and
  /// kept across later edits.
  Future<MemberProfile> save({
    required String name,
    required MemberRole role,
    String? phone,
    String? unitId,
  });
}

final memberRepositoryProvider = Provider<MemberRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftMemberRepository(db, SyncOutboxWriter(db));
});

final localMemberProvider = FutureProvider.autoDispose<MemberProfile?>((ref) {
  return ref.watch(memberRepositoryProvider).local();
});

class DriftMemberRepository implements MemberRepository {
  DriftMemberRepository(this._db, this._outbox, {DateTime Function()? now})
      : _now = now ?? DateTime.now;

  final AppDatabase _db;
  final SyncOutboxWriter _outbox;
  final DateTime Function() _now;

  @override
  Future<MemberProfile?> local() async {
    final row = await (_db.select(_db.members)
          ..where((t) => t.id.equals(localMemberId)))
        .getSingleOrNull();
    return row == null ? null : _fromRow(row);
  }

  @override
  Future<MemberProfile> save({
    required String name,
    required MemberRole role,
    String? phone,
    String? unitId,
  }) {
    return _db.transaction(() async {
      final now = _now();
      final existing = await (_db.select(_db.members)
            ..where((t) => t.id.equals(localMemberId)))
          .getSingleOrNull();

      final profile = MemberProfile(
        id: localMemberId,
        name: name,
        phone: phone,
        role: role,
        unitId: unitId,
        status: existing == null
            ? MemberStatus.pending
            : MemberStatus.tryParse(existing.status) ?? MemberStatus.pending,
        memberCode: existing?.memberCode ?? _newCode(now),
        createdAt: existing?.createdAt ?? now,
        verifiedAt: existing?.verifiedAt,
      );

      await _outbox.enqueue(
        entity: 'member',
        entityId: localMemberId,
        op: 'upsert',
        payload: profile.toSyncPayload(),
      );

      await _db.into(_db.members).insertOnConflictUpdate(
            MembersCompanion(
              id: const Value(localMemberId),
              name: Value(profile.name),
              phone: Value(profile.phone),
              role: Value(profile.role.name),
              unitId: Value(profile.unitId),
              status: Value(profile.status.name),
              memberCode: Value(profile.memberCode),
              createdAt: Value(profile.createdAt),
              verifiedAt: Value(profile.verifiedAt),
              revision: const Value(0),
            ),
          );

      return profile;
    });
  }

  String _newCode(DateTime now) =>
      'RGPRS-JK-${now.microsecondsSinceEpoch.toRadixString(36).toUpperCase()}';

  MemberProfile _fromRow(MemberRow row) => MemberProfile(
        id: row.id,
        name: row.name,
        phone: row.phone,
        role: MemberRole.tryParse(row.role) ?? MemberRole.worker,
        unitId: row.unitId,
        status: MemberStatus.tryParse(row.status) ?? MemberStatus.pending,
        memberCode: row.memberCode,
        createdAt: row.createdAt,
        verifiedAt: row.verifiedAt,
      );
}
