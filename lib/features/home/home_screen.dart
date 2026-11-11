import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../data/org/org_models.dart';
import '../../data/org/org_repository.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final startupError = ref.watch(startupErrorProvider);

    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
      children: [
        _WelcomeCard(s: s),
        if (startupError != null) ...[
          const SizedBox(height: 16),
          NeoCard(
            color: Theme.of(context).colorScheme.errorContainer,
            child: Text(
              '${s.dbErrorTitle}\n$startupError',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onErrorContainer,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
        const SizedBox(height: 18),
        // Emergency Quick Access Bar
        Row(
          children: [
            Expanded(
              child: NeoSurface(
                padding: const EdgeInsets.all(12),
                borderRadius: 18,
                color: const Color(0xFFFFEBEE),
                borderColor: const Color(0xFFD32F2F).withValues(alpha: 0.35),
                onTap: () => context.push('/helplines'),
                child: const Row(
                  children: [
                    Icon(
                      Icons.phone_in_talk,
                      color: Color(0xFFD32F2F),
                      size: 24,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '24×7 Helplines',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFFC62828),
                            ),
                          ),
                          Text(
                            'PDD, PHE, 108 & Police',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.ink,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: NeoSurface(
                padding: const EdgeInsets.all(12),
                borderRadius: 18,
                color: const Color(0xFFFFF3E0),
                borderColor: AppColors.saffronDeep.withValues(alpha: 0.35),
                onTap: () => context.push('/blood-sos'),
                child: const Row(
                  children: [
                    Icon(Icons.bloodtype, color: Color(0xFFD32F2F), size: 24),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Blood SOS',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                              color: AppColors.saffronDeep,
                            ),
                          ),
                          Text(
                            'Emergency Donors J&K',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.ink,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const _SectionTitle(
          title: 'Congress Jan Nyay Movements',
          subtitle: 'عوامی حقوق، روزگار اور انصاف کی مہم',
          badgeText: 'INC NYAY',
        ),
        const SizedBox(height: 14),
        const _CongressCampaignsGrid(),
        const SizedBox(height: 26),
        const _SectionTitle(
          title: 'Citizen Care & Public Services',
          subtitle: 'عوامی خدمت • عوامی حقوق مرکز',
          badgeText: 'INC SEVA',
        ),
        const SizedBox(height: 14),
        _ActionGrid(s: s),
        const SizedBox(height: 26),
        const _SectionTitle(
          title: 'Village Help & Citizen Utilities',
          subtitle: 'روزمرہ عوامی سہولیات • امداد اور معلومات',
          badgeText: 'PUBLIC HELP',
        ),
        const SizedBox(height: 14),
        const _UtilityGrid(),
        const SizedBox(height: 26),
        const _SectionTitle(
          title: 'Jammu & Kashmir Network',
          subtitle: 'پنچایتی راج تنظیمی ڈھانچہ',
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: s.divisions,
                icon: Icons.map_outlined,
                provider: orgTypeCountProvider(OrgUnitType.division),
                accentColor: AppColors.saffronDeep,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                label: s.districts,
                icon: Icons.location_city_outlined,
                provider: orgTypeCountProvider(OrgUnitType.district),
                accentColor: AppColors.partyBlue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                label: s.halqas,
                icon: Icons.groups_outlined,
                provider: orgTypeCountProvider(OrgUnitType.halqa),
                accentColor: AppColors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 26),
        const _SectionTitle(
          title: 'Common Public Issues',
          subtitle: 'شہری خدمات اور فوری ازالہ',
        ),
        const SizedBox(height: 14),
        _ServiceTile(
          icon: Icons.water_drop_outlined,
          title: 'Water & Sanitation Problem',
          subtitle: 'Tap dry, dirty supply or leaking pipeline in your village',
          color: const Color(0xFF0077B6),
          onTap: () => context.push('/grievance/new'),
        ),
        const SizedBox(height: 12),
        _ServiceTile(
          icon: Icons.electrical_services_outlined,
          title: 'Electricity & Transformer Breakdown',
          subtitle: 'Burnt transformer, damaged poles, or excessive billing',
          color: AppColors.saffronDeep,
          onTap: () => context.push('/grievance/new'),
        ),
        const SizedBox(height: 12),
        _ServiceTile(
          icon: Icons.rice_bowl_outlined,
          title: 'Ration & PDS Supply Issues',
          subtitle: 'Delayed ration quota, dealer overcharging or e-PoS issues',
          color: AppColors.green,
          onTap: () => context.push('/grievance/new'),
        ),
        const SizedBox(height: 24),
        NeoSurface(
          padding: const EdgeInsets.all(18),
          borderRadius: 22,
          onTap: () => context.push('/profile/join'),
          child: Row(
            children: [
              const NeoIcon(
                Icons.volunteer_activism_outlined,
                color: AppColors.saffronDeep,
                size: 50,
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Join as Community Volunteer',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: AppColors.ink,
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(Icons.verified, size: 16, color: AppColors.gold),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Help neighbors resolve village problems and connect them to public welfare.',
                      style: TextStyle(fontSize: 12, color: AppColors.mutedInk),
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
        ),
      ],
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard({required this.s});

  final AppStrings s;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F3B63), Color(0xFF0A2B4C), Color(0xFF071E36)],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
          width: 1.2,
        ),
        boxShadow: const [
          BoxShadow(color: Colors.white, offset: Offset(-3, -3), blurRadius: 6),
          BoxShadow(
            color: Color(0x35135A91),
            offset: Offset(4, 6),
            blurRadius: 14,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Icon(
              Icons.back_hand,
              size: 160,
              color: Colors.white.withValues(alpha: 0.04),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const DualPartyEmblem(size: 38),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'RAJIV GANDHI PANCHAYATI RAJ SANGATHAN',
                            style: TextStyle(
                              color: Color(0xFFFFB366),
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.1,
                            ),
                          ),
                          Text(
                            'راجیو گاندھی پنچایتی راج سنگٹھن • جموں و کشمیر',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.95),
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'J&K',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const TricolorStripe(height: 4, borderRadius: 2),
                const SizedBox(height: 16),
                const Text(
                  'اختیارات کی نچلی سطح تک منتقلی • ۷۳ویں آئینی ترمیم',
                  style: TextStyle(
                    color: Color(0xFFFFB366),
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'دیہات کی حکومت، عوام کا حق\nEmpowering J&K Panchayats',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Official citizen & panchayat portal of RGPRS J&K (Indian National Congress). File village grievances, fight arbitrary electricity bills, book public hearings with Congress MLAs, and access emergency rural relief.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 12.5,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionGrid extends StatelessWidget {
  const _ActionGrid({required this.s});

  final AppStrings s;

  @override
  Widget build(BuildContext context) {
    final actions = [
      (
        Icons.mic_none_outlined,
        'File Complaint',
        'Voice, Photo & SLA',
        '/grievance/new',
        const Color(0xFFD32F2F),
      ),
      (
        Icons.verified_user_outlined,
        'Mera Adhikar',
        'Govt Schemes & Docs',
        '/schemes',
        AppColors.saffronDeep,
      ),
      (
        Icons.person_pin_circle_outlined,
        'Find Representative',
        'Panch, Sarpanch, DDC',
        '/representative-finder',
        AppColors.partyBlue,
      ),
      (
        Icons.gavel_outlined,
        'Legal Aid & RTI',
        'RTI Generator in 60s',
        '/legal-aid',
        const Color(0xFF6A1B9A),
      ),
      (
        Icons.track_changes_outlined,
        'Track Grievances',
        'Jan Sunwai History',
        '/grievance',
        const Color(0xFF0077B6),
      ),
      (
        Icons.campaign_outlined,
        'Public Circulars',
        'Village & Ration alerts',
        '/notices',
        AppColors.green,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: actions.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 1.45,
      ),
      itemBuilder: (context, index) {
        final action = actions[index];
        return NeoSurface(
          padding: const EdgeInsets.all(14),
          borderRadius: 20,
          onTap: () => context.push(action.$4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NeoIcon(action.$1, size: 38, color: action.$5),
                  Icon(
                    Icons.north_east,
                    size: 14,
                    color: AppColors.mutedInk.withValues(alpha: 0.6),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                action.$2,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  color: AppColors.ink,
                ),
              ),
              Text(
                action.$3,
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
      },
    );
  }
}

class _UtilityGrid extends StatelessWidget {
  const _UtilityGrid();

  @override
  Widget build(BuildContext context) {
    final utilities = [
      (
        Icons.medication_outlined,
        'Congress Arogya & Generic Meds',
        'Save 50-90% on generic salts',
        '/jan-aushadhi',
        AppColors.green,
      ),
      (
        Icons.school_outlined,
        'Scholarships & Free Coaching',
        'PMSSS & Rajiv Gandhi Study Circle',
        '/scholarships',
        AppColors.partyBlue,
      ),
      (
        Icons.electric_bolt_outlined,
        'Power Cut Timetable',
        'KPDCL/JPDCL village schedule',
        '/power-schedule',
        const Color(0xFFE65100),
      ),
      (
        Icons.directions_bus_outlined,
        'Transport & Highway Alerts',
        'NH-44 & Mountain Passes Status',
        '/transport',
        const Color(0xFF00796B),
      ),
    ];

    return Column(
      children: [
        for (final u in utilities) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: NeoCard(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              onTap: () => context.push(u.$4),
              child: Row(
                children: [
                  NeoIcon(u.$1, size: 38, color: u.$5),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          u.$2,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: AppColors.ink,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          u.$3,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.mutedInk,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: AppColors.partyBlue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _CongressCampaignsGrid extends StatelessWidget {
  const _CongressCampaignsGrid();

  @override
  Widget build(BuildContext context) {
    final campaigns = [
      (
        Icons.campaign,
        '1-Lakh Vacancy Petition',
        'Youth employment & ₹3K allowance',
        '/youth-employment',
        const Color(0xFFD32F2F),
      ),
      (
        Icons.electric_meter,
        'Smart Meter Bill Appeal',
        'Challenge inflated PDD charges',
        '/smart-meter-appeal',
        AppColors.saffronDeep,
      ),
      (
        Icons.groups,
        'Village Jan Sunwai Schedule',
        'Meet Congress MLAs in your block',
        '/jan-sunwai',
        AppColors.partyBlue,
      ),
      (
        Icons.forest,
        'Forest Rights & Tribal Defense',
        'Gujjar-Bakerwal eviction stay (FRA)',
        '/forest-rights',
        AppColors.green,
      ),
      (
        Icons.volunteer_activism,
        'Seva Dal Emergency Brigade',
        'Winter blood runs & snow rescue',
        '/seva-brigade',
        const Color(0xFF6A1B9A),
      ),
      (
        Icons.ac_unit,
        'Chilla-i-Kalan Snow Helpline',
        'Snow stretchers & pass advisories',
        '/snow-emergency',
        const Color(0xFF0288D1),
      ),
      (
        Icons.sports_cricket,
        'Drug-Free J&K Youth Wing',
        'Rehab beds & village sports kits',
        '/drug-free-jk',
        const Color(0xFF512DA8),
      ),
    ];

    return Column(
      children: [
        for (final c in campaigns) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: NeoCard(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              onTap: () => context.push(c.$4),
              child: Row(
                children: [
                  NeoIcon(c.$1, size: 38, color: c.$5),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c.$2,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: AppColors.ink,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          c.$3,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.mutedInk,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: AppColors.partyBlue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, this.subtitle, this.badgeText});

  final String title;
  final String? subtitle;
  final String? badgeText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: AppColors.ink,
                  letterSpacing: 0.1,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mutedInk,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (badgeText != null) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.saffronLight,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.saffron.withValues(alpha: 0.4),
                width: 0.8,
              ),
            ),
            child: Text(
              badgeText!,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: AppColors.saffronDeep,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _StatCard extends ConsumerWidget {
  const _StatCard({
    required this.label,
    required this.icon,
    required this.provider,
    required this.accentColor,
  });

  final String label;
  final IconData icon;
  final FutureProvider<int> provider;
  final Color accentColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(provider);

    return NeoSurface(
      padding: const EdgeInsets.all(14),
      borderRadius: 18,
      onTap: () => context.push('/org'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 20, color: accentColor),
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: accentColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          count.when(
            data: (value) => Text(
              '$value',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: AppColors.ink,
              ),
            ),
            loading: () => const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.partyBlue),
              ),
            ),
            error: (_, stackTrace) => const Text('—'),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.mutedInk,
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return NeoSurface(
      padding: const EdgeInsets.all(14),
      borderRadius: 18,
      onTap: onTap,
      child: Row(
        children: [
          NeoIcon(icon, color: color, size: 44),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.mutedInk,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 20, color: AppColors.mutedInk),
        ],
      ),
    );
  }
}
