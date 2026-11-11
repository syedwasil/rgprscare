import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../data/member/member_data.dart';
import '../../data/org/org_repository.dart';
import 'join_screen.dart';

/// The offline membership card: what another member or office bearer reads
/// when they meet the holder. The QR carries a versioned payload with the
/// member code — verifiable offline.
class MemberCardScreen extends ConsumerWidget {
  const MemberCardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final member = ref.watch(localMemberProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          s.myCard,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: member.when(
        loading: () => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.partyBlue),
          ),
        ),
        error: (error, stack) => Center(child: Text('$error')),
        data: (profile) {
          if (profile == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: NeoCard(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CongressEmblem(size: 64),
                      const SizedBox(height: 18),
                      Text(
                        s.noCard,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.ink,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Join RGPRS to generate your official offline-verifiable party identity card.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.mutedInk,
                        ),
                      ),
                      const SizedBox(height: 22),
                      NeoButton(
                        onPressed: () => context.push('/profile/join'),
                        icon: Icons.person_add_outlined,
                        label: s.joinRgprs,
                        variant: NeoButtonVariant.saffron,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          final unit = ref.watch(orgUnitProvider(profile.unitId ?? ''));
          final isVerified = profile.status == MemberStatus.verified;

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
            children: [
              // The Official INC Member Card
              NeoSurface(
                padding: EdgeInsets.zero,
                borderRadius: 24,
                elevation: 1.2,
                child: Column(
                  children: [
                    // Tiranga Flag Ribbon Top
                    const TricolorStripe(height: 6, borderRadius: 0),
                    // Card Content
                    Padding(
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        children: [
                          // INC Header Header
                          Row(
                            children: [
                              const DualPartyEmblem(size: 40),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'INDIAN NATIONAL CONGRESS',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.saffronDeep,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                    const Text(
                                      'انڈین نیشنل کانگریس • RGPRS',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.partyBlue,
                                      ),
                                    ),
                                    Text(
                                      'Jammu & Kashmir State Unit',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.mutedInk,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(height: 1),
                          const SizedBox(height: 18),
                          // Member Details
                          Text(
                            profile.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: AppColors.ink,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.partyBlueLight,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.partyBlue.withValues(alpha: 0.3),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              roleLabel(context, profile.role).toUpperCase(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                color: AppColors.partyBlue,
                                letterSpacing: 0.6,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          unit.when(
                            loading: () => const SizedBox.shrink(),
                            error: (error, stack) => const SizedBox.shrink(),
                            data: (resolved) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.place_outlined,
                                  size: 16,
                                  color: AppColors.mutedInk,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  resolved?.nameEn ?? s.jammuKashmir,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.ink,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          // Verified / Pending Status Pill
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: isVerified
                                  ? AppColors.greenLight
                                  : AppColors.saffronLight,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isVerified
                                    ? AppColors.green.withValues(alpha: 0.4)
                                    : AppColors.saffron.withValues(alpha: 0.4),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isVerified ? Icons.verified : Icons.hourglass_top,
                                  size: 14,
                                  color: isVerified
                                      ? AppColors.greenDeep
                                      : AppColors.saffronDeep,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  isVerified ? s.verified : s.pending,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    color: isVerified
                                        ? AppColors.greenDeep
                                        : AppColors.saffronDeep,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          // QR Code Container in sunken Neumorphic stage
                          NeoSurface(
                            padding: const EdgeInsets.all(14),
                            borderRadius: 18,
                            isSunken: true,
                            child: QrImageView(
                              data: profile.qrPayload,
                              size: 170,
                              backgroundColor: Colors.transparent,
                              eyeStyle: const QrEyeStyle(
                                eyeShape: QrEyeShape.square,
                                color: AppColors.navy,
                              ),
                              dataModuleStyle: const QrDataModuleStyle(
                                dataModuleShape: QrDataModuleShape.square,
                                color: AppColors.navy,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          // Member ID Monospace
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.canvas,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${s.memberCode}: ${profile.memberCode}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: AppColors.partyBlue,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          const Text(
                            'عوامی خدمت • عوامی حقوق • خدمت ہی تنظیم',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: AppColors.saffronDeep,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              NeoCard(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    const Icon(
                      Icons.shield_outlined,
                      size: 20,
                      color: AppColors.partyBlue,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        s.cardNote,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.mutedInk,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              NeoButton(
                onPressed: () => context.push('/profile/join'),
                icon: Icons.edit_outlined,
                label: s.editProfile,
                variant: NeoButtonVariant.surface,
                isFullWidth: true,
              ),
            ],
          );
        },
      ),
    );
  }
}
