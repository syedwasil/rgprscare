import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../data/member/member_data.dart';

/// Profile tab: membership card entry, language picker and party info in
/// professional Neumorphic style.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final locale = ref.watch(localeProvider);
    final controller = ref.read(localeProvider.notifier);
    final member = ref.watch(localMemberProvider).maybeWhen(
          data: (profile) => profile,
          orElse: () => null,
        );

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
      children: [
        // Member Card Teaser
        if (member == null)
          NeoCard(
            padding: const EdgeInsets.all(18),
            hasTricolorTop: true,
            onTap: () => context.push('/profile/join'),
            child: Row(
              children: [
                const CongressEmblem(size: 46),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.joinRgprs,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: AppColors.ink,
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        'Get your verified digital INC membership card',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.mutedInk,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.partyBlue,
                ),
              ],
            ),
          )
        else
          NeoCard(
            padding: const EdgeInsets.all(16),
            hasTricolorTop: true,
            onTap: () => context.push('/profile/card'),
            child: Row(
              children: [
                const CongressEmblem(size: 46),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              member.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: AppColors.ink,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.greenLight,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              member.status == MemberStatus.verified
                                  ? s.verified
                                  : s.pending,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: AppColors.greenDeep,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'ID: ${member.memberCode}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.partyBlue,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.qr_code_2,
                  size: 26,
                  color: AppColors.partyBlue,
                ),
              ],
            ),
          ),
        const SizedBox(height: 18),
        // Language Switcher Section
        const Row(
          children: [
            Icon(Icons.translate, size: 18, color: AppColors.partyBlue),
            SizedBox(width: 8),
            Text(
              'Language • भाषा • زبان',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: AppColors.ink,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        for (final code in AppStrings.supportedLanguageCodes) ...[
          Builder(
            builder: (context) {
              final isSelected = locale.languageCode == code;
              return NeoCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                margin: const EdgeInsets.only(bottom: 8),
                isSunken: isSelected,
                borderColor: isSelected ? AppColors.partyBlue : null,
                onTap: () => controller.setLanguage(code),
                child: Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? AppColors.partyBlue
                            : Colors.transparent,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.partyBlue
                              : AppColors.outline,
                          width: 1.8,
                        ),
                      ),
                      child: isSelected
                          ? const Center(
                              child: Icon(
                                Icons.check,
                                size: 14,
                                color: Colors.white,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 14),
                    Text(
                      AppStrings.languageNames[code] ?? code,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                        color: isSelected ? AppColors.partyBlue : AppColors.ink,
                      ),
                    ),
                    const Spacer(),
                    if (isSelected)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.partyBlueLight,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'ACTIVE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: AppColors.partyBlue,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],

        const SizedBox(height: 16),
        // About Section
        Row(
          children: [
            const Icon(Icons.info_outline, size: 18, color: AppColors.partyBlue),
            const SizedBox(width: 8),
            Text(
              s.aboutApp,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: AppColors.ink,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        NeoCard(
          padding: const EdgeInsets.all(18),
          hasTricolorTop: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Row(
                children: [
                  CongressEmblem(size: 36),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'RGPRS J&K Care',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: AppColors.ink,
                          ),
                        ),
                        Text(
                          'Rajiv Gandhi Panchayati Raj Sangathan',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.partyBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                s.aboutBody,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.ink,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 14),
              const Divider(height: 1),
              const SizedBox(height: 12),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'حق و سچ کی فتح • خدمت ہی تنظیم',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.saffronDeep,
                    ),
                  ),
                  Text(
                    'v1.0.0 (Offline-First)',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.mutedInk,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
