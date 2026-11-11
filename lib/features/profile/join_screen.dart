import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/api_client.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../data/member/member_data.dart';
import '../../data/org/jk_geo_master.dart';
import '../../data/org/org_models.dart';
import '../../data/org/org_repository.dart';
import '../../data/sync/sync_data.dart';
import '../shared/picker_sheet.dart';

String roleLabel(BuildContext context, MemberRole role) =>
    AppStrings.of(context).t(role.labelKey);

/// Join / edit form for the device owner's RGPRS membership.
class JoinScreen extends ConsumerStatefulWidget {
  const JoinScreen({super.key});

  @override
  ConsumerState<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends ConsumerState<JoinScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();

  MemberRole _role = MemberRole.citizen;
  OrgUnit? _area;
  bool _loaded = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _prefill();
  }

  Future<void> _prefill() async {
    final existing = await ref.read(memberRepositoryProvider).local();
    if (!mounted) return;
    if (existing == null) {
      setState(() => _loaded = true);
      return;
    }

    _name.text = existing.name;
    _phone.text = existing.phone ?? '';
    _role = existing.role;

    final districts = await ref.read(districtsProvider.future);
    if (!mounted) return;
    OrgUnit? match;
    for (final unit in districts) {
      if (unit.id == existing.unitId) {
        match = unit;
        break;
      }
    }
    setState(() {
      _area = match;
      _loaded = true;
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final districts = ref.watch(districtsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          s.joinRgprs,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: !_loaded
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.partyBlue),
              ),
            )
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 100),
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.partyBlueLight,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.partyBlue.withValues(alpha: 0.25),
                        width: 1.2,
                      ),
                    ),
                    child: const Row(
                      children: [
                        DualPartyEmblem(size: 34),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'J&K Citizen & RGPRS Registration',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.partyBlue,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Open registration for all citizens of Jammu & Kashmir. Elected PRI roles (Sarpanch, BDC, DDC) require verification.',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.mutedInk,
                                  height: 1.25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  NeoTextField(
                    controller: _name,
                    labelText: s.fullName,
                    hintText: 'Enter your full name',
                    prefixIcon: Icons.badge_outlined,
                    textCapitalization: TextCapitalization.words,
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                            ? s.nameRequired
                            : null,
                  ),
                  const SizedBox(height: 16),
                  NeoTextField(
                    controller: _phone,
                    labelText: s.phone,
                    hintText: '10-digit mobile number',
                    prefixIcon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      final phone = value?.trim() ?? '';
                      if (phone.isEmpty) return null;
                      return RegExp(r'^\d{10}$').hasMatch(phone)
                          ? null
                          : s.phoneInvalid;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Role picker card
                  NeoCard(
                    padding: const EdgeInsets.all(14),
                    onTap: () async {
                      final chosen = await showOptionsSheet<MemberRole>(
                        context: context,
                        title: '${s.role} / Application Type',
                        options: MemberRole.values,
                        selected: _role,
                        label: (role) {
                          final lbl = roleLabel(context, role);
                          if (role.isElectedRole) {
                            return '$lbl (Official / Verification Required)';
                          }
                          return '$lbl (Open Registration)';
                        },
                      );
                      if (chosen != null) setState(() => _role = chosen);
                    },
                    child: Row(
                      children: [
                        NeoIcon(
                          _role.isElectedRole
                              ? Icons.verified_user_outlined
                              : Icons.person_outline,
                          color: _role.isElectedRole
                              ? AppColors.saffronDeep
                              : AppColors.partyBlue,
                          size: 38,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                s.role,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.mutedInk,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                roleLabel(context, _role),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.ink,
                                ),
                              ),
                              Text(
                                _role.isElectedRole
                                    ? 'Constitutional PRI Role • Pending verification'
                                    : 'General Public / Volunteer Enrollment',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: _role.isElectedRole
                                      ? AppColors.saffronDeep
                                      : AppColors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.partyBlue,
                        ),
                      ],
                    ),
                  ),
                  if (_role.isElectedRole) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF8E1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFFFB300).withValues(alpha: 0.5),
                        ),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.shield_outlined,
                              size: 20, color: Color(0xFFE65100)),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Political & PRI Verification: As an elected representative (Sarpanch/BDC/DDC), your membership profile will be submitted to the INC & RGPRS District Returning Officer for authentication of your election gazette / certificate.',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF5D4037),
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  // Area/District picker card
                  Builder(
                    builder: (context) {
                      final units = (districts.value?.isNotEmpty ?? false)
                          ? districts.value!
                          : jkAllDistricts;
                      return NeoCard(
                        padding: const EdgeInsets.all(14),
                        onTap: () async {
                          final chosen = await showOptionsSheet<OrgUnit>(
                            context: context,
                            title: 'Select J&K District (ضلع منتخب کریں)',
                            options: units,
                            selected: _area,
                            label: (unit) {
                              final sec = (unit.nameUr?.isNotEmpty ?? false)
                                  ? unit.nameUr!
                                  : (unit.nameHi ?? '');
                              return sec.isNotEmpty
                                  ? '${unit.nameEn} ($sec)'
                                  : unit.nameEn;
                            },
                          );
                          if (chosen != null) setState(() => _area = chosen);
                        },
                        child: Row(
                          children: [
                            const NeoIcon(
                              Icons.place_outlined,
                              color: AppColors.partyBlue,
                              size: 38,
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    s.area,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.mutedInk,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    _area != null
                                        ? '${_area!.nameEn} (${(_area!.nameUr?.isNotEmpty ?? false) ? _area!.nameUr! : (_area!.nameHi ?? '')})'
                                        : 'Tap to select your J&K District',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: _area != null
                                          ? AppColors.ink
                                          : AppColors.mutedInk,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.partyBlue,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: NeoButton(
            onPressed: _saving ? null : _save,
            icon: Icons.check_circle_outline,
            label: _saving ? 'Saving…' : s.submit,
            variant: NeoButtonVariant.saffron,
            isFullWidth: true,
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _saving = true);
    final phone = _phone.text.trim();
    await ref.read(memberRepositoryProvider).save(
          name: _name.text.trim(),
          role: _role,
          phone: phone.isEmpty ? null : phone,
          unitId: _area?.id,
        );

    // Auto-drain outbox so member lands on Central Web Control Room immediately
    ref.read(syncEngineProvider).drainOnce().then((_) {
      ref.invalidate(pendingSyncCountProvider);
    }).catchError((_) {});

    final memberData = {
      'fullName': _name.text.trim(),
      'role': _role.name,
      'phone': phone.isEmpty ? '' : phone,
      'district': _area?.nameEn ?? 'Jammu & Kashmir',
      'status': 'verified',
    };
    ApiClient.post('/api/members', memberData).catchError((_) => false);

    if (!mounted) return;
    ref.invalidate(localMemberProvider);
    context.pop();
  }
}
