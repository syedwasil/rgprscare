import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/app_shell.dart';
import '../../features/home/home_screen.dart';
import '../../features/helplines/helplines_screen.dart';
import '../../features/schemes/schemes_screen.dart';
import '../../features/schemes/scheme_detail_screen.dart';
import '../../features/blood/blood_screen.dart';
import '../../features/legal_aid/legal_aid_screen.dart';
import '../../features/representative/representative_finder_screen.dart';
import '../../features/health_care/jan_aushadhi_screen.dart';
import '../../features/education/scholarships_screen.dart';
import '../../features/electricity/power_schedule_screen.dart';
import '../../features/transport/transport_screen.dart';
import '../../features/campaigns/youth_employment_screen.dart';
import '../../features/electricity/smart_meter_appeal_screen.dart';
import '../../features/volunteer/seva_dal_brigade_screen.dart';
import '../../features/tribal/forest_rights_screen.dart';
import '../../features/jan_sunwai/jan_sunwai_screen.dart';
import '../../features/winter_relief/snow_emergency_screen.dart';
import '../../features/youth_mission/drug_free_jk_screen.dart';
import '../../features/grievance/grievance_detail_screen.dart';
import '../../features/grievance/grievance_list_screen.dart';
import '../../features/grievance/grievance_new_screen.dart';
import '../../features/notices/notice_detail_screen.dart';
import '../../features/notices/notice_new_screen.dart';
import '../../features/notices/notices_screen.dart';
import '../../features/org/org_tree_screen.dart';
import '../../features/org/unit_children_screen.dart';
import '../../features/profile/join_screen.dart';
import '../../features/profile/member_card_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../l10n/app_strings.dart';
import '../theme/app_theme.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

/// Four top-level tabs in a [StatefulShellRoute]: each tab keeps its own
/// navigation stack, and `/org/unit/<id>` is deep-linkable so a push
/// notification or a shared notice can land directly on a district.
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/home',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(shell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/grievance',
                builder: (context, state) => const GrievanceListScreen(),
                routes: [
                  GoRoute(
                    path: 'new',
                    // Full-screen form: covers the tab bar so its fixed
                    // submit button is the only bar on screen.
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const GrievanceNewScreen(),
                  ),
                  GoRoute(
                    path: ':id',
                    builder: (context, state) => GrievanceDetailScreen(
                      grievanceId: state.pathParameters['id']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/notices',
                builder: (context, state) => const NoticesScreen(),
                routes: [
                  GoRoute(
                    path: 'new',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const NoticeNewScreen(),
                  ),
                  GoRoute(
                    path: ':id',
                    builder: (context, state) => NoticeDetailScreen(
                      noticeId: state.pathParameters['id']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
                routes: [
                  GoRoute(
                    path: 'join',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const JoinScreen(),
                  ),
                  GoRoute(
                    path: 'card',
                    builder: (context, state) => const MemberCardScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/org',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const OrgTreeScreen(),
        routes: [
          GoRoute(
            path: 'unit/:id',
            builder: (context, state) => UnitChildrenScreen(
              unitId: state.pathParameters['id']!,
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/helplines',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const HelplinesScreen(),
      ),
      GoRoute(
        path: '/schemes',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SchemesScreen(),
        routes: [
          GoRoute(
            path: ':id',
            parentNavigatorKey: rootNavigatorKey,
            builder: (context, state) => SchemeDetailScreen(
              schemeId: state.pathParameters['id']!,
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/blood-sos',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const BloodScreen(),
      ),
      GoRoute(
        path: '/legal-aid',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const RtiLegalAidScreen(),
      ),
      GoRoute(
        path: '/representative-finder',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const RepresentativeFinderScreen(),
      ),
      GoRoute(
        path: '/jan-aushadhi',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const JanAushadhiScreen(),
      ),
      GoRoute(
        path: '/scholarships',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const ScholarshipsScreen(),
      ),
      GoRoute(
        path: '/power-schedule',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const PowerScheduleScreen(),
      ),
      GoRoute(
        path: '/transport',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const TransportScreen(),
      ),
      GoRoute(
        path: '/youth-employment',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const YouthEmploymentScreen(),
      ),
      GoRoute(
        path: '/smart-meter-appeal',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SmartMeterAppealScreen(),
      ),
      GoRoute(
        path: '/seva-brigade',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SevaDalBrigadeScreen(),
      ),
      GoRoute(
        path: '/forest-rights',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const ForestRightsScreen(),
      ),
      GoRoute(
        path: '/jan-sunwai',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const JanSunwaiScreen(),
      ),
      GoRoute(
        path: '/snow-emergency',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SnowEmergencyScreen(),
      ),
      GoRoute(
        path: '/drug-free-jk',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const DrugFreeJkScreen(),
      ),
    ],
    errorBuilder: (context, state) => RouteNotFoundScreen(uri: state.uri),
  );
});

/// Shown for unknown paths, in the active language, with a way back.
class RouteNotFoundScreen extends StatelessWidget {
  const RouteNotFoundScreen({super.key, required this.uri});

  final Uri uri;

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: NeoCard(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CongressEmblem(size: 48),
                const SizedBox(height: 16),
                Text(
                  s.routeNotFound,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  uri.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.mutedInk,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                NeoButton(
                  onPressed: () => context.go('/home'),
                  label: s.home,
                  icon: Icons.home,
                  variant: NeoButtonVariant.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
