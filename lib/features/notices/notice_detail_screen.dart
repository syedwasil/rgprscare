import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../data/notice/notice_data.dart';

/// Reads one notice and records the read receipt locally.
class NoticeDetailScreen extends ConsumerStatefulWidget {
  const NoticeDetailScreen({super.key, required this.noticeId});

  final String noticeId;

  @override
  ConsumerState<NoticeDetailScreen> createState() => _NoticeDetailScreenState();
}

class _NoticeDetailScreenState extends ConsumerState<NoticeDetailScreen> {
  @override
  void initState() {
    super.initState();
    _markReadOnce();
  }

  Future<void> _markReadOnce() async {
    final repository = ref.read(noticeRepositoryProvider);
    final notice = await repository.all();
    for (final item in notice) {
      if (item.id == widget.noticeId && !item.isRead) {
        await repository.markRead(item.id);
        if (!mounted) return;
        ref.invalidate(noticeListProvider);
        ref.invalidate(noticeProvider(widget.noticeId));
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final notice = ref.watch(noticeProvider(widget.noticeId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          s.notices,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: notice.when(
        loading: () => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.partyBlue),
          ),
        ),
        error: (error, stack) => Center(child: Text('$error')),
        data: (record) {
          if (record == null) {
            return Center(child: Text(s.noticeEmpty));
          }

          final isUrgent = record.priority == NoticePriority.urgent;

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
            children: [
              if (isUrgent) ...[
                NeoSurface(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  borderRadius: 16,
                  color: const Color(0xFFFFEBEE),
                  borderColor: const Color(0xFFE53935).withValues(alpha: 0.4),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD32F2F).withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.warning_amber_rounded,
                          color: Color(0xFFD32F2F),
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          s.priorityUrgent,
                          style: const TextStyle(
                            color: Color(0xFFD32F2F),
                            fontWeight: FontWeight.w900,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
              ],
              NeoCard(
                padding: const EdgeInsets.all(20),
                hasTricolorTop: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const CongressEmblem(size: 26, showShadow: false),
                        const SizedBox(width: 8),
                        const Text(
                          'OFFICIAL CIRCULAR',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: AppColors.partyBlue,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          formatDay(record.createdAt),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.mutedInk,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      record.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: AppColors.ink,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.person_outline,
                          size: 14,
                          color: AppColors.mutedInk,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${s.authoredBy} ${record.authorName}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.partyBlue,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.schedule_outlined,
                          size: 14,
                          color: AppColors.mutedInk,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          formatDayTime(record.createdAt),
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.mutedInk,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(height: 1),
                    const SizedBox(height: 16),
                    Text(
                      record.body,
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.ink,
                        height: 1.55,
                        letterSpacing: 0.2,
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
