import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../data/org/jk_geo_master.dart';
import '../../data/org/org_repository.dart';
import 'unit_tile.dart';

/// Organisation tab: hierarchy of the state units (divisions and districts).
class OrgTreeScreen extends ConsumerWidget {
  const OrgTreeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final divisions = ref.watch(orgChildrenProvider(jkStateUnitId));

    return divisions.when(
      loading: () => const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.partyBlue),
        ),
      ),
      error: (error, stack) => _ErrorState(message: '$error'),
      data: (units) => ListView(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 32),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: NeoCard(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CongressEmblem(size: 40),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Panchayati Raj Sangathan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: AppColors.ink,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${s.jammuKashmir} • Regional Structure',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
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
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 4, 18, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'DIVISIONS & DISTRICTS',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: AppColors.mutedInk,
                    letterSpacing: 0.8,
                  ),
                ),
                Text(
                  '${units.length} Divisions',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.partyBlue,
                  ),
                ),
              ],
            ),
          ),
          if (units.isEmpty)
            _EmptyState(message: s.noUnits)
          else
            for (final unit in units) UnitTile(unit: unit),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: NeoCard(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            const NeoIcon(
              Icons.account_tree_outlined,
              size: 50,
              color: AppColors.partyBlue,
            ),
            const SizedBox(height: 14),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.mutedInk,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: NeoCard(
          color: Theme.of(context).colorScheme.errorContainer,
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onErrorContainer,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
