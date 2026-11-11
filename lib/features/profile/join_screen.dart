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

/// Upgraded Join / Edit form for RGPRS & INC Digital Membership:
/// - Real-time live digital card preview that updates as user types!
/// - Neumorphic design with Congress & RGPRS dual emblem
/// - Seamless district and constitutional PRI role picker
/// - Automatic synchronization with Web Admin Control Room
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
    _name.addListener(() => setState(() {}));
    _phone.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    super.dispose();
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

    if (existing.unitId != null) {
      final unit = await ref.read(orgRepositoryProvider).byId(existing.unitId!);
      if (mounted) _area = unit;
    }

    if (mounted) setState(() => _loaded = true);
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);

    return Scaffold(
      backgroundColor: AppColors.canvas,
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
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 120),
                children: [
                  // 1. Live Digital Card Preview
                  NeoSurface(
                    padding: EdgeInsets.zero,
                    borderRadius: 20,
                    elevation: 1.2,
                    child: Column(
                      children: [
                        const TricolorStripe(height: 5, borderRadius: 0),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const DualPartyEmblem(size: 38),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'INDIAN NATIONAL CONGRESS',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w900,
                                            color: AppColors.partyBlue,
                                            letterSpacing: 0.8,
                                          ),
                                        ),
                                        Text(
                                          'Rajiv Gandhi Panchayati Raj Sangathan • J&K',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.mutedInk,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _role.isElectedRole
                                          ? const Color(0xFFFFF3E0)
                                          : AppColors.greenLight,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      _role.isElectedRole ? 'PRI PENDING' : 'CITIZEN PASS',
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w900,
                                        color: _role.isElectedRole
                                            ? AppColors.saffronDeep
                                            : AppColors.greenDeep,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Text(
                                _name.text.trim().isEmpty ? 'Your Full Name' : _name.text.trim(),
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w900,
                                  color: _name.text.trim().isEmpty ? AppColors.mutedInk : AppColors.ink,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Text(
                                    roleLabel(context, _role),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.partyBlue,
                                    ),
                                  ),
                                  const Text(' • ', style: TextStyle(color: AppColors.mutedInk)),
                                  Text(
                                    _area?.nameEn ?? 'Select District',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.mutedInk,
                                    ),
                                  ),
                                ],
                              ),
                              if (_phone.text.trim().isNotEmpty) ...[
                                const SizedBox(height: 3),
                                Text(
                                  '📞 +91 ${_phone.text.trim()}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.mutedInk,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 2. Info Banner
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.partyBlueLight.withAlpha(50),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.partyBlue.withAlpha(60),
                        width: 1.2,
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.shield_outlined, size: 24, color: AppColors.partyBlue),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'J&K Citizen & RGPRS Membership Pass',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.partyBlue,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Open registration for all citizens of Jammu & Kashmir. Provides verified identity for Jan Sunwai, smart meter petitions & PRI representation.',
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

                  const SizedBox(height: 20),

                  // 3. Name Field
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

                  // 4. Phone Field
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

                  // 5. Role picker card
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
                                    ? 'Constitutional PRI Role • Pending State Desk Verification'
                                    : 'General Citizen / Volunteer Pass',
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
                        border: Border.all(color: AppColors.saffronDeep.withAlpha(80)),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.warning_amber_rounded, size: 18, color: AppColors.saffronDeep),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'PRI verification: Your credential will be verified against the official J&K State Election Gazette before the golden verified badge is issued.',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF5D4037),
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 16),

                  // 6. District / Area Picker
                  Consumer(
                    builder: (context, ref, _) {
                      final units = ref.watch(orgChildrenProvider(jkStateUnitId)).maybeWhen(
                            data: (list) => list,
                            orElse: () => const <OrgUnit>[],
                          );

                      return NeoCard(
                        padding: const EdgeInsets.all(14),
                        onTap: () async {
                          final chosen = await showOptionsSheet<OrgUnit>(
                            context: context,
                            title: s.area,
                            options: units,
                            selected: _area,
                            label: (unit) => '${unit.nameEn} (${unit.localizedName(s)})',
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
      'name': _name.text.trim(),
      'role': _role.name,
      'phone': phone.isEmpty ? '' : phone,
      'district': _area?.nameEn ?? 'Jammu & Kashmir',
      'status': _role.isElectedRole ? 'pending' : 'verified',
    };
    ApiClient.post('/api/members', memberData).catchError((_) => false);

    if (!mounted) return;
    ref.invalidate(localMemberProvider);
    context.pop();
  }
}
