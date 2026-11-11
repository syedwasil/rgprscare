import 'package:flutter/material.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../data/grievance/grievance_data.dart';

String categoryLabel(BuildContext context, GrievanceCategory category) =>
    AppStrings.of(context).t(category.labelKey);

String statusLabel(BuildContext context, GrievanceStatus status) =>
    AppStrings.of(context).t(status.labelKey);

String eventLabel(BuildContext context, GrievanceEventType type) =>
    AppStrings.of(context).t(type.labelKey);

extension on GrievanceEventType {
  String get labelKey => switch (this) {
        GrievanceEventType.created => 'eventCreated',
        GrievanceEventType.statusChange => 'eventStatusChange',
        GrievanceEventType.note => 'eventNote',
      };
}

/// Neumorphic Status Badge for Grievances with Tiranga / INC color coding.
class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final GrievanceStatus status;

  @override
  Widget build(BuildContext context) {
    final (background, foreground, dotColor) = switch (status) {
      GrievanceStatus.open => (
          AppColors.saffronLight,
          AppColors.saffronDeep,
          AppColors.saffronDeep,
        ),
      GrievanceStatus.inProgress => (
          AppColors.partyBlueLight,
          AppColors.partyBlue,
          AppColors.partyBlue,
        ),
      GrievanceStatus.resolved => (
          AppColors.greenLight,
          AppColors.greenDeep,
          AppColors.green,
        ),
      GrievanceStatus.closed => (
          const Color(0xFFE5ECF2),
          AppColors.mutedInk,
          AppColors.mutedInk,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: foreground.withValues(alpha: 0.25),
          width: 0.9,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            offset: Offset(-1, -1),
            blurRadius: 2,
          ),
          BoxShadow(
            color: Color(0x12000000),
            offset: Offset(1, 1),
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            statusLabel(context, status),
            style: TextStyle(
              color: foreground,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

/// Neumorphic Escalation Banner shown when SLA clock has pushed an issue up.
class EscalationBanner extends StatelessWidget {
  const EscalationBanner({super.key, required this.level});

  /// 0 = no escalation, 1 = block, 2 = district.
  final int level;

  @override
  Widget build(BuildContext context) {
    if (level == 0) return const SizedBox.shrink();

    final s = AppStrings.of(context);
    final isDistrict = level == 2;
    final color = isDistrict ? const Color(0xFFD32F2F) : AppColors.saffronDeep;
    final bg = isDistrict ? const Color(0xFFFFEBEE) : AppColors.saffronLight;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: NeoSurface(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        borderRadius: 16,
        color: bg,
        borderColor: color.withValues(alpha: 0.4),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isDistrict ? Icons.priority_high : Icons.north,
                color: color,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isDistrict ? 'District Escalation' : 'Block Escalation',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    isDistrict ? s.escalatedDistrict : s.escalatedBlock,
                    style: TextStyle(
                      color: color.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
