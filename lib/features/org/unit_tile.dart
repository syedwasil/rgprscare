import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../data/org/org_models.dart';
import '../../data/org/org_repository.dart';

IconData iconForUnitType(OrgUnitType type) => switch (type) {
      OrgUnitType.state => Icons.account_balance_outlined,
      OrgUnitType.division => Icons.map_outlined,
      OrgUnitType.district => Icons.location_city_outlined,
      OrgUnitType.block => Icons.grid_view_outlined,
      OrgUnitType.halqa => Icons.holiday_village_outlined,
      OrgUnitType.ward => Icons.home_work_outlined,
    };

Color colorForUnitType(OrgUnitType type) => switch (type) {
      OrgUnitType.state => AppColors.partyBlue,
      OrgUnitType.division => AppColors.saffronDeep,
      OrgUnitType.district => AppColors.partyBlue,
      OrgUnitType.block => AppColors.green,
      OrgUnitType.halqa => const Color(0xFFD97706),
      OrgUnitType.ward => const Color(0xFF0D9488),
    };

/// One row in the organisation browser in professional Neumorphic style.
class UnitTile extends ConsumerWidget {
  const UnitTile({super.key, required this.unit});

  final OrgUnit unit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final children = ref.watch(orgChildrenProvider(unit.id));
    final iconColor = colorForUnitType(unit.type);

    return NeoCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      onTap: () => context.push('/org/unit/${unit.id}'),
      child: Row(
        children: [
          NeoIcon(
            iconForUnitType(unit.type),
            color: iconColor,
            size: 42,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  unit.localizedName(s),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  unit.type.label(s),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mutedInk,
                  ),
                ),
              ],
            ),
          ),
          children.when(
            data: (units) => units.isEmpty
                ? const Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: AppColors.mutedInk,
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.partyBlueLight,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.partyBlue.withValues(alpha: 0.2),
                        width: 0.8,
                      ),
                    ),
                    child: Text(
                      '${units.length}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.partyBlue,
                      ),
                    ),
                  ),
            loading: () => const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.partyBlue),
              ),
            ),
            error: (error, stack) => const Icon(
              Icons.error_outline,
              size: 18,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
