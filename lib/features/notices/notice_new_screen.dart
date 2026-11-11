import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../data/member/member_data.dart';
import '../../data/notice/notice_data.dart';
import '../../data/org/org_models.dart';
import '../../data/org/org_repository.dart';
import '../../data/sync/sync_data.dart';
import '../shared/picker_sheet.dart';

/// Compose a notice for a unit. It is written to the local inbox immediately
/// and queued in the outbox.
class NoticeNewScreen extends ConsumerStatefulWidget {
  const NoticeNewScreen({super.key});

  @override
  ConsumerState<NoticeNewScreen> createState() => _NoticeNewScreenState();
}

class _NoticeNewScreenState extends ConsumerState<NoticeNewScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _body = TextEditingController();

  NoticePriority _priority = NoticePriority.normal;
  OrgUnit? _audience;
  bool _saving = false;

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          s.composeNotice,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 100),
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.partyBlueLight,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: AppColors.partyBlue.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: const Row(
                children: [
                  CongressEmblem(size: 28, showShadow: false),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Party Circular Broadcast',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: AppColors.partyBlue,
                          ),
                        ),
                        Text(
                          'Broadcast official directives, meeting alerts, and mobilization calls.',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.mutedInk,
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
              controller: _title,
              labelText: s.noticeTitle,
              hintText: s.titleRequired,
              prefixIcon: Icons.title_outlined,
              textCapitalization: TextCapitalization.sentences,
              validator: (value) =>
                  (value == null || value.trim().isEmpty) ? s.titleRequired : null,
            ),
            const SizedBox(height: 16),
            NeoTextField(
              controller: _body,
              labelText: s.noticeBody,
              hintText: s.descriptionRequired,
              prefixIcon: Icons.article_outlined,
              minLines: 4,
              maxLines: 8,
              textCapitalization: TextCapitalization.sentences,
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? s.descriptionRequired
                  : null,
            ),
            const SizedBox(height: 16),
            // Urgent priority switch card
            NeoCard(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                children: [
                  const NeoIcon(
                    Icons.flag_outlined,
                    color: Color(0xFFD32F2F),
                    size: 38,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.priorityUrgent,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppColors.ink,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Highlight with urgent priority alert',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.mutedInk,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _priority == NoticePriority.urgent,
                    activeTrackColor: const Color(0xFFD32F2F),
                    activeThumbColor: Colors.white,
                    onChanged: (value) => setState(
                      () => _priority =
                          value ? NoticePriority.urgent : NoticePriority.normal,
                    ),
                  ),
                ],
              ),
            ),
            // Audience card
            NeoCard(
              padding: const EdgeInsets.all(14),
              onTap: () async {
                const all = '__all__';
                final units = await ref.read(districtsProvider.future);
                if (!context.mounted) return;
                final byId = {
                  for (final unit in units) unit.id: unit,
                };
                final chosenId = await showOptionsSheet<String>(
                  context: context,
                  title: s.audience,
                  options: [all, ...byId.keys],
                  selected: _audience?.id ?? all,
                  label: (id) =>
                      id == all ? s.allUnits : byId[id]?.nameEn ?? id,
                );
                if (chosenId == null) return;
                setState(() {
                  _audience = chosenId == all ? null : byId[chosenId];
                });
              },
              child: Row(
                children: [
                  const NeoIcon(
                    Icons.groups_outlined,
                    color: AppColors.partyBlue,
                    size: 38,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.audience,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.mutedInk,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _audience?.nameEn ?? s.allUnits,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppColors.ink,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, color: AppColors.partyBlue),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: NeoButton(
            onPressed: _saving ? null : _submit,
            icon: Icons.send_outlined,
            label: _saving ? 'Sending…' : s.submit,
            variant: NeoButtonVariant.primary,
            isFullWidth: true,
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _saving = true);
    final member = await ref.read(memberRepositoryProvider).local();

    await ref.read(noticeRepositoryProvider).create(
          title: _title.text.trim(),
          body: _body.text.trim(),
          priority: _priority,
          authorName: member?.name ?? '',
          unitId: _audience?.id,
        );

    if (!mounted) return;
    ref.invalidate(noticeListProvider);
    ref.invalidate(pendingSyncCountProvider);
    context.pop();
  }
}
