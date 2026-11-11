import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/format.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../data/member/member_data.dart';
import '../../data/notice/notice_data.dart';

/// Notices tab: the inbox of broadcasts. Only an office bearer composes —
/// a plain worker sees the same inbox without the send button.
class NoticesScreen extends ConsumerWidget {
  const NoticesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final notices = ref.watch(noticeListProvider);
    final member = ref.watch(localMemberProvider).maybeWhen(
          data: (profile) => profile,
          orElse: () => null,
        );
    final canCompose = member != null && member.role != MemberRole.worker;

    return Scaffold(
      floatingActionButton: canCompose
          ? NeoFloatingActionButton(
              onPressed: () => context.push('/notices/new'),
              icon: Icons.edit_outlined,
              label: s.composeNotice,
              isSaffron: false, // INC Party Blue
            )
          : null,
      body: notices.when(
        loading: () => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.partyBlue),
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
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: NeoCard(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CongressEmblem(size: 56),
                      const SizedBox(height: 16),
                      Text(
                        s.noticeEmpty,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.ink,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        canCompose
                            ? 'Use the button below to broadcast an official circular.'
                            : s.composeNeedsRole,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.mutedInk,
                        ),
                      ),
                      if (canCompose) ...[
                        const SizedBox(height: 20),
                        NeoButton(
                          onPressed: () => context.push('/notices/new'),
                          label: s.composeNotice,
                          icon: Icons.edit_outlined,
                          variant: NeoButtonVariant.primary,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }

          return RefreshIndicator(
            color: AppColors.partyBlue,
            onRefresh: () async {
              ref.invalidate(noticeListProvider);
              await ref.read(noticeListProvider.future);
            },
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 110),
              itemCount: items.length,
              itemBuilder: (context, index) {
              final notice = items[index];
              final isUrgent = notice.priority == NoticePriority.urgent;

              return NeoCard(
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.only(bottom: 12),
                borderColor: isUrgent
                    ? const Color(0xFFE53935).withValues(alpha: 0.4)
                    : (!notice.isRead
                        ? AppColors.partyBlue.withValues(alpha: 0.35)
                        : null),
                onTap: () => context.push('/notices/${notice.id}'),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NeoIcon(
                      isUrgent
                          ? Icons.warning_amber_rounded
                          : (notice.isRead
                              ? Icons.notifications_none_outlined
                              : Icons.notifications_active_outlined),
                      size: 42,
                      color: isUrgent
                          ? const Color(0xFFD32F2F)
                          : (notice.isRead
                              ? AppColors.mutedInk
                              : AppColors.partyBlue),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (!notice.isRead) ...[
                                Container(
                                  width: 7,
                                  height: 7,
                                  decoration: const BoxDecoration(
                                    color: AppColors.partyBlue,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                              ],
                              Expanded(
                                child: Text(
                                  notice.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: notice.isRead
                                        ? FontWeight.w600
                                        : FontWeight.w900,
                                    color: AppColors.ink,
                                  ),
                                ),
                              ),
                              if (isUrgent) ...[
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFEBEE),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text(
                                    'URGENT',
                                    style: TextStyle(
                                      color: Color(0xFFD32F2F),
                                      fontSize: 9,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.4,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(
                                Icons.person_outline,
                                size: 12,
                                color: AppColors.mutedInk,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${s.authoredBy} ${notice.authorName}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.mutedInk,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                formatDay(notice.createdAt),
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.mutedInk,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
      ),
    );
  }
}
