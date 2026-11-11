import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/format.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../data/grievance/grievance_data.dart';
import 'grievance_widgets.dart';

/// Jan Sunwai tab: grievances filed from this device, with SLA and escalation
/// derived at render time offline.
class GrievanceListScreen extends ConsumerStatefulWidget {
  const GrievanceListScreen({super.key});

  @override
  ConsumerState<GrievanceListScreen> createState() =>
      _GrievanceListScreenState();
}

class _GrievanceListScreenState extends ConsumerState<GrievanceListScreen> {
  GrievanceStatus? _filter;

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final grievances = ref.watch(grievanceListProvider);
    final now = DateTime.now();

    return Scaffold(
      floatingActionButton: NeoFloatingActionButton(
        onPressed: () => context.push('/grievance/new'),
        icon: Icons.add,
        label: s.newGrievance,
        isSaffron: true,
      ),
      body: grievances.when(
        loading: () => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.partyBlue),
                ),
              ),
              const SizedBox(height: 12),
              Text(s.loading, style: const TextStyle(color: AppColors.mutedInk)),
            ],
          ),
        ),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: NeoCard(
              color: Theme.of(context).colorScheme.errorContainer,
              child: Text(
                '$error',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        data: (all) {
          final visible = _filter == null
              ? all
              : all.where((g) => g.status == _filter).toList();

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 110),
            children: [
              // Header title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jan Sunwai • عوامی شنوائی',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: AppColors.ink,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Public Grievance Redressal & SLA Tracking',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.mutedInk,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.partyBlueLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${all.length} Total',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.partyBlue,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Neumorphic Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    NeoFilterChip(
                      label: s.filterAll,
                      selected: _filter == null,
                      onSelected: (_) => setState(() => _filter = null),
                    ),
                    const SizedBox(width: 8),
                    for (final status in GrievanceStatus.values) ...[
                      NeoFilterChip(
                        label: statusLabel(context, status),
                        selected: _filter == status,
                        selectedColor: switch (status) {
                          GrievanceStatus.open => AppColors.saffronDeep,
                          GrievanceStatus.inProgress => AppColors.partyBlue,
                          GrievanceStatus.resolved => AppColors.green,
                          GrievanceStatus.closed => AppColors.mutedInk,
                        },
                        onSelected: (_) => setState(() => _filter = status),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 18),
              if (all.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: NeoCard(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      children: [
                        const CongressEmblem(size: 56),
                        const SizedBox(height: 16),
                        const Text(
                          'No Grievances Filed Yet',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.ink,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          s.noGrievances,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.mutedInk,
                          ),
                        ),
                        const SizedBox(height: 20),
                        NeoButton(
                          onPressed: () => context.push('/grievance/new'),
                          label: s.newGrievance,
                          icon: Icons.add,
                          variant: NeoButtonVariant.saffron,
                        ),
                      ],
                    ),
                  ),
                )
              else if (visible.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Center(
                    child: Text(
                      'No matching grievances found.',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.mutedInk,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              for (final grievance in visible)
                _GrievanceTile(grievance: grievance, now: now),
            ],
          );
        },
      ),
    );
  }
}

class _GrievanceTile extends StatelessWidget {
  const _GrievanceTile({required this.grievance, required this.now});

  final Grievance grievance;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final level = grievance.escalationLevelAt(now);

    final (catIcon, catColor) = switch (grievance.category) {
      GrievanceCategory.water => (Icons.water_drop_outlined, const Color(0xFF0288D1)),
      GrievanceCategory.road => (Icons.route_outlined, const Color(0xFFE65100)),
      GrievanceCategory.electricity => (Icons.bolt_outlined, const Color(0xFFF57C00)),
      GrievanceCategory.rations => (Icons.storefront_outlined, const Color(0xFF2E7D32)),
      GrievanceCategory.mgnrega => (Icons.badge_outlined, const Color(0xFF6A1B9A)),
      GrievanceCategory.pension => (Icons.elderly_outlined, const Color(0xFF00897B)),
      GrievanceCategory.health => (Icons.medical_services_outlined, const Color(0xFFC2185B)),
      GrievanceCategory.other => (Icons.category_outlined, AppColors.partyBlue),
    };

    return NeoCard(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 12),
      onTap: () => context.push('/grievance/${grievance.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NeoIcon(
                catIcon,
                color: catColor,
                size: 40,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          grievance.refCode,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: AppColors.partyBlue,
                            letterSpacing: 0.5,
                          ),
                        ),
                        if (level > 0) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: level == 2
                                  ? const Color(0xFFFFEBEE)
                                  : AppColors.saffronLight,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  level == 2 ? Icons.priority_high : Icons.north,
                                  size: 11,
                                  color: level == 2
                                      ? const Color(0xFFD32F2F)
                                      : AppColors.saffronDeep,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  level == 2 ? 'DISTRICT' : 'BLOCK',
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w900,
                                    color: level == 2
                                        ? const Color(0xFFD32F2F)
                                        : AppColors.saffronDeep,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      grievance.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppColors.ink,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              StatusBadge(status: grievance.status),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(height: 1),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                categoryLabel(context, grievance.category),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.mutedInk,
                ),
              ),
              Text(
                '${s.filedOn} ${formatDay(grievance.createdAt)}',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.mutedInk,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
