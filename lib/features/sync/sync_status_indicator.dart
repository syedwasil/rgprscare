import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../data/sync/sync_data.dart';

/// Tactile Neumorphic Sync Indicator for the App Bar.
class SyncStatusIndicator extends ConsumerWidget {
  const SyncStatusIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final pending = ref.watch(pendingSyncCountProvider);

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: pending.when(
        loading: () => const Center(
          child: SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.partyBlue),
            ),
          ),
        ),
        error: (error, stack) => NeoSurface(
          padding: EdgeInsets.zero,
          borderRadius: 12,
          child: SizedBox(
            width: 38,
            height: 38,
            child: Icon(
              Icons.cloud_off_outlined,
              size: 20,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
        data: (count) {
          final isPending = count > 0;
          return NeoSurface(
            padding: EdgeInsets.zero,
            borderRadius: 12,
            color: isPending ? AppColors.saffronLight : null,
            borderColor: isPending ? AppColors.saffron : null,
            onTap: () => showDialog<void>(
              context: context,
              builder: (dialogContext) => AlertDialog(
                title: Row(
                  children: [
                    const CongressEmblem(size: 28, showShadow: false),
                    const SizedBox(width: 10),
                    Text(s.syncTitle),
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TricolorStripe(height: 3),
                    const SizedBox(height: 14),
                    Text(
                      count == 0
                          ? s.syncNone
                          : '${s.syncPending}: $count',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'All entries are saved securely offline on this device.',
                      style: Theme.of(dialogContext).textTheme.bodySmall,
                    ),
                  ],
                ),
                actions: [
                  if (count > 0)
                    TextButton(
                      onPressed: () async {
                        Navigator.of(dialogContext).pop();
                        final res = await ref.read(syncEngineProvider).drainOnce();
                        ref.invalidate(pendingSyncCountProvider);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                res.accepted > 0
                                    ? 'Successfully synced ${res.accepted} records with J&K Control Room!'
                                    : (res.error != null
                                        ? 'Sync connection error: offline mode active.'
                                        : 'Server offline; stored safely on device.'),
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      child: const Text('Sync with Control Room'),
                    ),
                  NeoButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    label: MaterialLocalizations.of(dialogContext).okButtonLabel,
                    variant: NeoButtonVariant.primary,
                  ),
                ],
              ),
            ),
            child: SizedBox(
              width: 38,
              height: 38,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    isPending
                        ? Icons.cloud_upload_outlined
                        : Icons.cloud_done_outlined,
                    size: 20,
                    color: isPending ? AppColors.saffronDeep : AppColors.green,
                  ),
                  if (isPending)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: AppColors.saffronDeep,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                        child: Text(
                          '$count',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
