import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../core/action_utils.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../data/member/member_data.dart';
import '../../data/org/org_repository.dart';
import 'join_screen.dart';

/// Redesigned Neumorphic Profile screen:
/// - Realistic Interactive Digital INC & RGPRS Identity Card
/// - Direct Actions (My Grievances, Saved Notices, Helpline, Verify PRI)
/// - Language Picker with Neumorphic sunken active toggles
/// - Verified Credentials & JKPCC HQ Information
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

    final districtUnit = member?.unitId != null
        ? ref.watch(orgUnitProvider(member!.unitId!)).maybeWhen(
              data: (u) => u?.nameEn,
              orElse: () => null,
            )
        : null;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 36),
      children: [
        // 1. Digital Membership Card Preview / Sign-up Hero
        if (member == null) ...[
          NeoSurface(
            padding: EdgeInsets.zero,
            borderRadius: 22,
            elevation: 1.2,
            onTap: () => context.push('/profile/join'),
            child: Column(
              children: [
                const TricolorStripe(height: 6, borderRadius: 0),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const DualPartyEmblem(size: 44),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  s.joinRgprs,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.ink,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                const Text(
                                  'Generate your official verified digital party membership card',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.mutedInk,
                                    height: 1.3,
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
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.partyBlueLight.withAlpha(50),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.partyBlue.withAlpha(40)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.verified_user_outlined, size: 18, color: AppColors.partyBlue),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Enables direct voice escalations, priority Jan Sunwai tokens, & PRI accreditation.',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.partyBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      NeoButton(
                        onPressed: () => context.push('/profile/join'),
                        label: 'Enroll & Generate ID Card',
                        icon: Icons.badge_outlined,
                        variant: NeoButtonVariant.saffron,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ] else ...[
          // Interactive Digital Member Identity Card
          NeoSurface(
            padding: EdgeInsets.zero,
            borderRadius: 22,
            elevation: 1.4,
            onTap: () => context.push('/profile/card'),
            child: Column(
              children: [
                const TricolorStripe(height: 6, borderRadius: 0),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const DualPartyEmblem(size: 48),
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
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                          color: AppColors.ink,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: member.status == MemberStatus.verified
                                            ? AppColors.greenLight
                                            : const Color(0xFFFFF3E0),
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: member.status == MemberStatus.verified
                                              ? AppColors.green.withAlpha(120)
                                              : AppColors.saffron.withAlpha(120),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            member.status == MemberStatus.verified
                                                ? Icons.check_circle
                                                : Icons.pending_outlined,
                                            size: 11,
                                            color: member.status == MemberStatus.verified
                                                ? AppColors.greenDeep
                                                : AppColors.saffronDeep,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            member.status == MemberStatus.verified
                                                ? s.verified
                                                : s.pending,
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w900,
                                              color: member.status == MemberStatus.verified
                                                  ? AppColors.greenDeep
                                                  : AppColors.saffronDeep,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${roleLabel(context, member.role)} • ${districtUnit ?? "Jammu & Kashmir"}',
                                  style: const TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.partyBlue,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'ID: ${member.memberCode}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.mutedInk,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.canvas,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.outline),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 44,
                              height: 44,
                              child: QrImageView(
                                data: 'rgprs://member/${member.memberCode}',
                                version: QrVersions.auto,
                                padding: EdgeInsets.zero,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Offline Verifiable QR Code',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.ink,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Tap anywhere to view full card or export digital pass',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.mutedInk,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.fullscreen,
                              size: 22,
                              color: AppColors.partyBlue,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: NeoButton(
                              onPressed: () => context.push('/profile/card'),
                              label: 'View Digital Card',
                              icon: Icons.credit_card,
                              variant: NeoButtonVariant.surface,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: NeoButton(
                              onPressed: () => context.push('/profile/join'),
                              label: 'Edit Details',
                              icon: Icons.edit_outlined,
                              variant: NeoButtonVariant.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],

        const SizedBox(height: 22),

        // 2. Quick Management & Service Shortcuts
        const Row(
          children: [
            Icon(Icons.dashboard_customize_outlined, size: 18, color: AppColors.partyBlue),
            SizedBox(width: 8),
            Text(
              'Quick Access & Citizen Services',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: AppColors.ink,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _ActionTile(
                icon: Icons.report_problem_outlined,
                iconColor: AppColors.saffronDeep,
                title: 'My Grievances',
                subtitle: 'Track status & SLA',
                onTap: () => context.go('/grievance'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ActionTile(
                icon: Icons.campaign_outlined,
                iconColor: AppColors.partyBlue,
                title: 'Notices & Orders',
                subtitle: 'HQ communications',
                onTap: () => context.go('/notices'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _ActionTile(
                icon: Icons.account_tree_outlined,
                iconColor: AppColors.greenDeep,
                title: '20-District Units',
                subtitle: 'Regional DCC/BCC',
                onTap: () => context.push('/org'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ActionTile(
                icon: Icons.headset_mic_outlined,
                iconColor: const Color(0xFFD32F2F),
                title: 'Emergency SOS',
                subtitle: 'Control Room 24x7',
                onTap: () => context.push('/helplines'),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // 3. Language Switcher Section
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
                        color: isSelected ? AppColors.partyBlue : Colors.transparent,
                        border: Border.all(
                          color: isSelected ? AppColors.partyBlue : AppColors.outline,
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
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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

        const SizedBox(height: 22),

        // 4. Contact & Headquarters Card
        const Row(
          children: [
            Icon(Icons.location_city_outlined, size: 18, color: AppColors.partyBlue),
            SizedBox(width: 8),
            Text(
              'Party Secretariats & Helplines',
              style: TextStyle(
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
              const Row(
                children: [
                  DualPartyEmblem(size: 34),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jammu & Kashmir Pradesh Congress Committee',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: AppColors.ink,
                          ),
                        ),
                        Text(
                          'Rajiv Gandhi Panchayati Raj Sangathan State Unit',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.partyBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Text(
                '• Srinagar HQ: Congress House, M.A. Road, Srinagar 190001\n• Jammu HQ: Shahidi Chowk, Residency Road, Jammu 180001\n• AICC National HQ: 24 Akbar Road, New Delhi 110011',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.ink,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => ActionUtils.launchPhoneCall(context, '01912578085'),
                      icon: const Icon(Icons.call, size: 15, color: AppColors.partyBlue),
                      label: const Text(
                        '0191-2578085',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.partyBlue),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.partyBlue),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => ActionUtils.launchPhoneCall(context, '01123019080'),
                      icon: const Icon(Icons.phone_in_talk, size: 15, color: AppColors.saffronDeep),
                      label: const Text(
                        '011-23019080',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.saffronDeep),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.saffronDeep),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // 5. App Info Footer
        Center(
          child: Column(
            children: [
              Text(
                '${s.appName} • Official Offline-First Citizen Portal',
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.mutedInk,
                ),
              ),
              const SizedBox(height: 3),
              const Text(
                'حق و سچ کی فتح • خدمت ہی تنظیم • J&K Edition 2026',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: AppColors.saffronDeep,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return NeoSurface(
      padding: const EdgeInsets.all(14),
      borderRadius: 16,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withAlpha(25),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 22, color: iconColor),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.mutedInk,
            ),
          ),
        ],
      ),
    );
  }
}
