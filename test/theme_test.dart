import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rgprs_jk/core/theme/app_theme.dart';
import 'package:rgprs_jk/features/home/home_screen.dart';
import 'package:rgprs_jk/core/l10n/app_strings.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:rgprs_jk/data/org/org_models.dart';
import 'package:rgprs_jk/data/org/org_repository.dart';

import 'package:rgprs_jk/features/helplines/helplines_screen.dart';
import 'package:rgprs_jk/features/schemes/schemes_screen.dart';
import 'package:rgprs_jk/features/blood/blood_screen.dart';
import 'package:rgprs_jk/features/health_care/jan_aushadhi_screen.dart';
import 'package:rgprs_jk/features/education/scholarships_screen.dart';
import 'package:rgprs_jk/features/electricity/power_schedule_screen.dart';
import 'package:rgprs_jk/features/transport/transport_screen.dart';

void main() {
  group('Indian National Congress / Indian Light Neumorphic Theme Tests', () {
    test('AppColors contains official INC & Indian Tiranga palette', () {
      expect(AppColors.saffron, const Color(0xFFFF9933));
      expect(AppColors.white, const Color(0xFFFFFFFF));
      expect(AppColors.green, const Color(0xFF138808));
      expect(AppColors.partyBlue, const Color(0xFF135A91));
      expect(AppColors.canvas, const Color(0xFFEEF2F7));
      expect(AppColors.surface, const Color(0xFFEEF2F7));
    });

    test('AppTheme.light() sets correct light theme properties', () {
      final theme = AppTheme.light();
      expect(theme.brightness, Brightness.light);
      expect(theme.scaffoldBackgroundColor, AppColors.canvas);
      expect(theme.colorScheme.primary, AppColors.partyBlue);
      expect(theme.colorScheme.tertiary, AppColors.green);
      expect(theme.useMaterial3, true);
    });

    testWidgets('CongressEmblem renders emblem with branding asset', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: CongressEmblem(size: 48),
            ),
          ),
        ),
      );

      expect(find.byType(CongressEmblem), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('TricolorStripe renders 3 color bands', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: TricolorStripe(height: 6),
            ),
          ),
        ),
      );

      expect(find.byType(TricolorStripe), findsOneWidget);
      final stripeBands = find.descendant(
        of: find.byType(TricolorStripe),
        matching: find.byType(ColoredBox),
      );
      expect(stripeBands, findsNWidgets(3));
    });

    testWidgets('NeoCard renders with neumorphic elevation and responds to tap', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Center(
              child: NeoCard(
                onTap: () => tapped = true,
                child: const Text('Test Card'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Test Card'), findsOneWidget);
      await tester.tap(find.text('Test Card'));
      await tester.pumpAndSettle();
      expect(tapped, isTrue);
    });

    testWidgets('NeoButton renders and handles tap interaction', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Center(
              child: NeoButton(
                onPressed: () => pressed = true,
                label: 'Congress Action',
                icon: Icons.check,
                variant: NeoButtonVariant.primary,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Congress Action'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);

      await tester.tap(find.text('Congress Action'));
      await tester.pumpAndSettle();
      expect(pressed, isTrue);
    });

    testWidgets('HomeScreen renders with INC header and Neumorphic tiles', (tester) async {
      tester.view.physicalSize = const Size(1080, 5000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            orgTypeCountProvider(OrgUnitType.division)
                .overrideWith((ref) => Future.value(2)),
            orgTypeCountProvider(OrgUnitType.district)
                .overrideWith((ref) => Future.value(20)),
            orgTypeCountProvider(OrgUnitType.halqa)
                .overrideWith((ref) => Future.value(100)),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: const [
              AppStringsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en')],
            home: const Scaffold(body: HomeScreen()),
          ),
        ),
      );

      await tester.pump();

      // Check for Congress & RGPRS elements
      expect(find.text('RAJIV GANDHI PANCHAYATI RAJ SANGATHAN'), findsOneWidget);
      expect(find.text('Citizen Care & Public Services'), findsOneWidget);
      expect(find.text('Jammu & Kashmir Network'), findsOneWidget);
      expect(find.byType(CongressEmblem), findsAtLeastNWidgets(1));
      expect(find.byType(TricolorStripe), findsAtLeastNWidgets(1));
    });

    testWidgets('HelplinesScreen renders with emergency contacts and search', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const HelplinesScreen(),
        ),
      );

      await tester.pump();
      expect(find.text('24×7 Public Helplines'), findsOneWidget);
      expect(find.text('National Emergency Response (112)'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('SchemesScreen renders Mera Adhikar welfare schemes', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const SchemesScreen(),
        ),
      );

      await tester.pump();
      expect(find.text('Mera Adhikar • Jan Kalyan Rights'), findsOneWidget);
      expect(find.text('Mahatma Gandhi NREGA (Congress Flagship Law)'), findsOneWidget);
    });

    testWidgets('BloodScreen renders emergency blood requests and blood banks', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const BloodScreen(),
          ),
        ),
      );

      await tester.pump();
      expect(find.text('Blood SOS & Donors'), findsOneWidget);
      expect(find.text('Post Blood Need'), findsOneWidget);
      expect(find.text('🚨 Emergency Requests'), findsOneWidget);
    });

    testWidgets('JanAushadhiScreen renders Congress Arogya generic medicines and savings', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const JanAushadhiScreen(),
        ),
      );

      await tester.pump();
      expect(find.text('Congress Arogya & Generic Meds'), findsOneWidget);
      expect(find.text('INC Jan Arogya • 50% to 90% Savings'), findsOneWidget);
      expect(find.text('Paracetamol 650 mg'), findsOneWidget);
    });

    testWidgets('ScholarshipsScreen renders youth scholarships and free coaching', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const ScholarshipsScreen(),
        ),
      );

      await tester.pump();
      expect(find.text('Scholarships & Free Coaching'), findsOneWidget);
      expect(find.text('Higher Education Rights for J&K Youth'), findsOneWidget);
    });

    testWidgets('PowerScheduleScreen renders PDD load shedding timetable', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const PowerScheduleScreen(),
        ),
      );

      await tester.pump();
      expect(find.text('PDD Power Cut Timetable'), findsOneWidget);
      expect(find.text('Village & Town Load Shedding'), findsOneWidget);
    });

    testWidgets('TransportScreen renders passes and bus routes', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const TransportScreen(),
        ),
      );

      await tester.pump();
      expect(find.text('Transport & Mountain Routes'), findsOneWidget);
      expect(find.text('NH-44 & Mountain Road Alerts'), findsOneWidget);
    });
  });
}
