import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/action_utils.dart';
import '../../core/format.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../data/grievance/grievance_data.dart';
import 'grievance_widgets.dart';

/// One grievance: facts, SLA clock, escalation, actions and its timeline.
class GrievanceDetailScreen extends ConsumerWidget {
  const GrievanceDetailScreen({super.key, required this.grievanceId});

  final String grievanceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final grievance = ref.watch(grievanceProvider(grievanceId));
    final events = ref.watch(grievanceEventsProvider(grievanceId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          s.grievances,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: grievance.when(
        loading: () => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.partyBlue),
          ),
        ),
        error: (error, stack) => Center(
          child: Text('$error', style: const TextStyle(color: Colors.red)),
        ),
        data: (record) {
          if (record == null) {
            return Center(child: Text(s.noGrievances));
          }

          final now = DateTime.now();
          final repository = ref.read(grievanceRepositoryProvider);

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
            children: [
              EscalationBanner(level: record.escalationLevelAt(now)),
              NeoCard(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const CongressEmblem(size: 24, showShadow: false),
                              const SizedBox(width: 8),
                              Text(
                                record.refCode,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.partyBlue,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        StatusBadge(status: record.status),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      record.title,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                        color: AppColors.ink,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      record.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.ink,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(height: 1),
                    const SizedBox(height: 14),
                    _FactRow(
                      label: s.category,
                      value: categoryLabel(context, record.category),
                      icon: Icons.category_outlined,
                    ),
                    _FactRow(
                      label: s.filedOn,
                      value: formatDayTime(record.createdAt),
                      icon: Icons.event_outlined,
                    ),
                    _FactRow(
                      label: s.resolveBy,
                      value: formatDay(record.dueDate),
                      icon: Icons.timer_outlined,
                    ),
                    if (record.reporterName != null)
                      _FactRow(
                        label: s.reportedBy,
                        value: record.reporterName!,
                        icon: Icons.person_outline,
                      ),
                    if (record.reporterPhone != null)
                      _FactRow(
                        label: s.phone,
                        value: maskPhone(record.reporterPhone!),
                        icon: Icons.phone_outlined,
                      ),
                    if (record.resolutionNote != null)
                      _FactRow(
                        label: s.markResolved,
                        value: record.resolutionNote!,
                        icon: Icons.check_circle_outline,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              // Action Buttons in Neumorphic Style
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  NeoButton(
                    onPressed: () => ActionUtils.launchPhoneCall(context, '0191-2578085'),
                    icon: Icons.call,
                    label: 'Call Helpdesk (0191-2578085)',
                    variant: NeoButtonVariant.primary,
                  ),
                  if (record.isOpen)
                    NeoButton(
                      onPressed: () async {
                        final note = await showNoteDialog(
                          context: context,
                          title: s.addNote,
                          hint: s.noteHint,
                        );
                        if (note == null || note.isEmpty) return;
                        await repository.addNote(record.id, note);
                        ref.invalidate(grievanceEventsProvider(grievanceId));
                      },
                      icon: Icons.edit_note,
                      label: s.addNote,
                      variant: NeoButtonVariant.surface,
                    ),
                  NeoButton(
                    onPressed: () {
                      final slip = '🏛️ RGPRS INC Citizen Grievance Slip\n'
                          '• Ref Code: ${record.refCode}\n'
                          '• Issue: ${record.title}\n'
                          '• Category: ${categoryLabel(context, record.category)}\n'
                          '• Status: ${statusLabel(context, record.status)}\n'
                          '• Filed On: ${formatDay(record.createdAt)}\n'
                          '• Resolve By: ${formatDay(record.dueDate)}\n'
                          'Track anytime via RGPRS Care citizen desk.';
                      ActionUtils.launchWhatsApp(context, '', message: slip);
                    },
                    icon: Icons.share,
                    label: 'Share on WhatsApp',
                    variant: NeoButtonVariant.green,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Icon(Icons.history_outlined, size: 20, color: AppColors.partyBlue),
                  const SizedBox(width: 8),
                  Text(
                    s.history,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: AppColors.ink,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              events.when(
                loading: () => const SizedBox.shrink(),
                error: (error, stack) => Text('$error'),
                data: (timeline) => Column(
                  children: [
                    for (final event in timeline)
                      NeoCard(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NeoIcon(
                              switch (event.type) {
                                GrievanceEventType.created =>
                                  Icons.file_present_outlined,
                                GrievanceEventType.statusChange =>
                                  Icons.swap_horiz,
                                GrievanceEventType.note => Icons.edit_note,
                              },
                              size: 34,
                              color: AppColors.partyBlue,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        eventLabel(context, event.type),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 13,
                                          color: AppColors.ink,
                                        ),
                                      ),
                                      Text(
                                        formatDayTime(event.createdAt),
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.mutedInk,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (event.note.isNotEmpty) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      event.note,
                                      style: const TextStyle(
                                        fontSize: 12,
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
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FactRow extends StatelessWidget {
  const _FactRow({
    required this.label,
    required this.value,
    this.icon,
  });

  final String label;
  final String value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: AppColors.mutedInk),
            const SizedBox(width: 6),
          ],
          SizedBox(
            width: 105,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.mutedInk,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Asks for a short note in a Neumorphic styled dialog.
Future<String?> showNoteDialog({
  required BuildContext context,
  required String title,
  required String hint,
}) {
  final controller = TextEditingController();

  return showDialog<String>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Row(
        children: [
          const CongressEmblem(size: 26, showShadow: false),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            ),
          ),
        ],
      ),
      content: NeoSurface(
        padding: EdgeInsets.zero,
        borderRadius: 14,
        isSunken: true,
        child: TextField(
          controller: controller,
          minLines: 2,
          maxLines: 4,
          autofocus: true,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.mutedInk, fontSize: 13),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(14),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: Text(
            MaterialLocalizations.of(dialogContext).cancelButtonLabel,
            style: const TextStyle(
              color: AppColors.mutedInk,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        NeoButton(
          onPressed: () {
            final note = controller.text.trim();
            Navigator.of(dialogContext).pop(note.isEmpty ? '' : note);
          },
          label: MaterialLocalizations.of(dialogContext).okButtonLabel,
          variant: NeoButtonVariant.primary,
        ),
      ],
    ),
  );
}
