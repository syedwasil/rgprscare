import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/action_utils.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../data/org/jk_geo_master.dart';
import '../../data/org/org_models.dart';
import '../../data/org/org_repository.dart';
import 'unit_tile.dart';

/// Drill-down page for `/org/unit/:id`: shows one unit's details, DCC/BCC leadership,
/// actionable contact channels, and child sub-units in Neumorphic style.
class UnitChildrenScreen extends ConsumerWidget {
  const UnitChildrenScreen({super.key, required this.unitId});

  final String unitId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final unit = ref.watch(orgUnitProvider(unitId));
    final children = ref.watch(orgChildrenProvider(unitId));

    return unit.when(
      loading: () => const Scaffold(
        backgroundColor: AppColors.canvas,
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.partyBlue),
          ),
        ),
      ),
      error: (error, stack) => Scaffold(
        backgroundColor: AppColors.canvas,
        appBar: AppBar(),
        body: Center(child: Text('$error')),
      ),
      data: (resolved) {
        if (resolved == null) {
          return Scaffold(
            backgroundColor: AppColors.canvas,
            appBar: AppBar(),
            body: const Center(
              child: Text(
                'Unit records are updating with State RGPRS Desk.',
                style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.mutedInk),
              ),
            ),
          );
        }

        final dccInfo = resolved.type == OrgUnitType.district
            ? getDccOffice(resolved.id) ?? getDccOffice(resolved.nameEn)
            : null;

        return Scaffold(
          backgroundColor: AppColors.canvas,
          appBar: AppBar(
            title: Text(
              resolved.localizedName(s),
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ),
          body: children.when(
            loading: () => const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.partyBlue),
              ),
            ),
            error: (error, stack) => Center(child: Text('$error')),
            data: (units) => ListView(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 32),
              children: [
                // 1. Header Banner
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: NeoCard(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        NeoIcon(
                          iconForUnitType(resolved.type),
                          color: colorForUnitType(resolved.type),
                          size: 42,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                resolved.localizedName(s),
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.ink,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '${resolved.type.label(s)} • Indian National Congress & RGPRS',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.partyBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 2. District Specific Congress Committee (DCC) Leadership Desk
                if (resolved.type == OrgUnitType.district && dccInfo != null) ...[
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: NeoCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const DualPartyEmblem(size: 28),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'DCC ${dccInfo.districtName} & RGPRS Headquarters',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.partyBlue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _DetailRow(
                            icon: Icons.person_pin,
                            label: 'President',
                            value: dccInfo.president,
                          ),
                          const SizedBox(height: 8),
                          _DetailRow(
                            icon: Icons.business,
                            label: 'HQ Office',
                            value: dccInfo.officeAddress,
                          ),
                          const SizedBox(height: 8),
                          _DetailRow(
                            icon: Icons.how_to_reg,
                            label: 'Panchayat Desk',
                            value: dccInfo.rgprsCoordinator,
                          ),
                          const SizedBox(height: 8),
                          _DetailRow(
                            icon: Icons.analytics_outlined,
                            label: 'Jurisdiction',
                            value: '${dccInfo.totalBlocks} Blocks • ${dccInfo.totalHalqas} Halqa Panchayats',
                          ),
                          const SizedBox(height: 16),
                          // Actionable Direct Buttons
                          Row(
                            children: [
                              Expanded(
                                child: NeoButton(
                                  label: 'Call DCC Office',
                                  icon: Icons.call,
                                  variant: NeoButtonVariant.primary,
                                  onPressed: () => ActionUtils.launchPhoneCall(context, dccInfo.phone),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: NeoButton(
                                  label: 'WhatsApp Desk',
                                  icon: Icons.chat,
                                  variant: NeoButtonVariant.green,
                                  onPressed: () => ActionUtils.launchWhatsApp(
                                    context,
                                    dccInfo.phone,
                                    message: 'Hello, I am reaching out from ${dccInfo.districtName} for RGPRS assistance.',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],

                // 3. Block Specific Coordination Desk
                if (resolved.type == OrgUnitType.block) ...[
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: NeoCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              DualPartyEmblem(size: 26),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Block Congress Committee & Panchayati Raj',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.partyBlue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Active Block Unit coordinating grassroots Halqa Panchayats, MNREGA wage oversight, and village grievance escalation.',
                            style: TextStyle(fontSize: 12, height: 1.4, color: AppColors.ink),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(
                                child: NeoButton(
                                  label: 'Call Helpline',
                                  icon: Icons.call,
                                  variant: NeoButtonVariant.primary,
                                  onPressed: () => ActionUtils.launchPhoneCall(context, '0191-2578085'),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: NeoButton(
                                  label: 'File Grievance',
                                  icon: Icons.report_problem_outlined,
                                  variant: NeoButtonVariant.saffron,
                                  onPressed: () => context.push('/grievance/new'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],

                // 4. Halqa / Ward Specific Desk
                if (resolved.type == OrgUnitType.halqa || resolved.type == OrgUnitType.ward) ...[
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: NeoCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              DualPartyEmblem(size: 26),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Halqa Panchayat People\'s Care Desk',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Rajiv Gandhi Panchayati Raj Sangathan ensures that every Sarpanch, Panch, and rural resident has 24/7 access to public grievance redressal and welfare rights.',
                            style: TextStyle(fontSize: 12, height: 1.4, color: AppColors.ink),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(
                                child: NeoButton(
                                  label: 'Submit Halqa Issue',
                                  icon: Icons.add_circle_outline,
                                  variant: NeoButtonVariant.primary,
                                  onPressed: () => context.push('/grievance/new'),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: NeoButton(
                                  label: 'Join as Panch/Worker',
                                  icon: Icons.badge_outlined,
                                  variant: NeoButtonVariant.green,
                                  onPressed: () => context.push('/profile/join'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 14),
                // Sub-units Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 4, 18, 8),
                  child: Text(
                    units.isEmpty
                        ? 'LOCAL PANCHAYAT COORDINATION'
                        : 'SUB-UNITS & PANCHAYATS (${units.length})',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: AppColors.mutedInk,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),

                // Sub-units List or Leaf Message
                if (units.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: NeoCard(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const NeoIcon(
                            Icons.verified_outlined,
                            size: 44,
                            color: AppColors.partyBlue,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Grassroots RGPRS Unit Active',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: AppColors.ink,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Panchayati Raj representatives and Congress karyakartas are actively mobilized in this unit. For public grievances, RTI filings, and welfare assistance, reach the 24/7 Citizen Care Desk.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.mutedInk,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              NeoButton(
                                label: 'INC Care 0191-2578085',
                                icon: Icons.call,
                                variant: NeoButtonVariant.primary,
                                onPressed: () => ActionUtils.launchPhoneCall(context, '0191-2578085'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  for (final child in units) UnitTile(unit: child),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.partyBlue),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.mutedInk,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            ),
          ),
        ),
      ],
    );
  }
}
