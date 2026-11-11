import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/action_utils.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../data/sync/sync_data.dart';

/// Root scaffold: INC tricolor stripe, tab content from the shell, neumorphic bottom nav.
/// Performs silent background synchronization automatically on launch so citizens
/// are never confused by manual sync controls.
///
/// Tapping the App Bar title opens the 20-District Organization Unit tree directly!
class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Automatic silent sync with Control Room
      ref.read(syncEngineProvider).drainOnce();
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 14,
        toolbarHeight: 88,
        title: GestureDetector(
          onTap: () => context.push('/org'),
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              const DualPartyEmblem(size: 34),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          s.appName,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            color: AppColors.ink,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                          decoration: BoxDecoration(
                            color: AppColors.partyBlue.withAlpha(20),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: AppColors.partyBlue.withAlpha(50)),
                          ),
                          child: const Text(
                            'J&K',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: AppColors.partyBlue,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.saffronDeep.withAlpha(25),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppColors.saffronDeep.withAlpha(60)),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.account_tree_outlined, size: 12, color: AppColors.saffronDeep),
                              SizedBox(width: 3),
                              Text(
                                'Units',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.saffronDeep,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Rajiv Gandhi Panchayati Raj Sangathan',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone_in_talk, color: AppColors.green, size: 24),
            tooltip: 'INC Citizen Helpline: 0194-2452402',
            onPressed: () => ActionUtils.launchPhoneCall(context, '0194-2452402'),
          ),
          const SizedBox(width: 6),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(5),
          child: TricolorStripe(height: 4, borderRadius: 2),
        ),
      ),
      body: widget.shell,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 4, 14, 12),
          child: NeoSurface(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            borderRadius: 24,
            child: NavigationBar(
              height: 64,
              backgroundColor: Colors.transparent,
              indicatorColor: AppColors.partyBlueLight,
              selectedIndex: widget.shell.currentIndex,
              onDestinationSelected: (index) => widget.shell.goBranch(
                index,
                initialLocation: index == widget.shell.currentIndex,
              ),
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.home_outlined),
                  selectedIcon: const Icon(Icons.home, color: AppColors.partyBlue),
                  label: s.home,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.report_problem_outlined),
                  selectedIcon: const Icon(
                    Icons.report_problem,
                    color: AppColors.partyBlue,
                  ),
                  label: s.grievances,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.campaign_outlined),
                  selectedIcon: const Icon(
                    Icons.campaign,
                    color: AppColors.partyBlue,
                  ),
                  label: s.notices,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.person_outline),
                  selectedIcon: const Icon(Icons.person, color: AppColors.partyBlue),
                  label: s.profile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
