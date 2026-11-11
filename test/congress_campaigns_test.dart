import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rgprs_jk/core/theme/app_theme.dart';
import 'package:rgprs_jk/features/campaigns/youth_employment_screen.dart';
import 'package:rgprs_jk/features/electricity/smart_meter_appeal_screen.dart';
import 'package:rgprs_jk/features/volunteer/seva_dal_brigade_screen.dart';
import 'package:rgprs_jk/features/tribal/forest_rights_screen.dart';
import 'package:rgprs_jk/features/jan_sunwai/jan_sunwai_screen.dart';
import 'package:rgprs_jk/features/winter_relief/snow_emergency_screen.dart';
import 'package:rgprs_jk/features/youth_mission/drug_free_jk_screen.dart';

Widget _wrap(Widget child) {
  return ProviderScope(
    child: MaterialApp(
      theme: AppTheme.light(),
      home: child,
    ),
  );
}

void main() {
  group('Congress & RGPRS Jan Nyay Campaign Screens', () {
    testWidgets('YouthEmploymentScreen renders petition and input fields', (tester) async {
      await tester.pumpWidget(_wrap(const YouthEmploymentScreen()));
      await tester.pumpAndSettle();

      expect(find.text('1-Lakh Vacancy Demand Desk'), findsOneWidget);
      expect(find.text('Congress Youth Nyay Campaign'), findsOneWidget);
      expect(find.byType(TextField), findsAtLeastNWidgets(2));
      expect(find.text('Sign & Add My Voice to Assembly Dossier'), findsOneWidget);
    });

    testWidgets('SmartMeterAppealScreen renders calculator and inputs', (tester) async {
      await tester.pumpWidget(_wrap(const SmartMeterAppealScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Smart Meter & Bill Appeal'), findsOneWidget);
      expect(find.text('Inflated Electricity Bill Redressal'), findsOneWidget);
      expect(find.text('Generate Legal Dispute Appeal'), findsOneWidget);
    });

    testWidgets('SevaDalBrigadeScreen renders emergency actions and tabs', (tester) async {
      await tester.pumpWidget(_wrap(const SevaDalBrigadeScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Congress Seva Dal Brigade'), findsOneWidget);
      expect(find.text('District Units & SOS'), findsOneWidget);
      expect(find.text('Join Seva Brigade'), findsOneWidget);
    });

    testWidgets('ForestRightsScreen renders FRA legal stay generator', (tester) async {
      await tester.pumpWidget(_wrap(const ForestRightsScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Forest Rights & Tribal Defense'), findsOneWidget);
      expect(find.text('Gujjar & Bakerwal Land Defense'), findsOneWidget);
      expect(find.text('Generate Statutory Stay Objection (FRA 2006)'), findsOneWidget);
    });

    testWidgets('JanSunwaiScreen renders public hearing schedule and district filter', (tester) async {
      await tester.pumpWidget(_wrap(const JanSunwaiScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Village Jan Sunwai Schedule'), findsOneWidget);
      expect(find.text('Direct Public Grievance Hearings'), findsOneWidget);
      expect(find.text('All J&K'), findsOneWidget);
      expect(find.text('Srinagar'), findsWidgets);
    });

    testWidgets('SnowEmergencyScreen renders mountain pass statuses and SOS form', (tester) async {
      await tester.pumpWidget(_wrap(const SnowEmergencyScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Chilla-i-Kalan Snow Helpline'), findsOneWidget);
      expect(find.text('RGPRS Winter Stretcher & SOS Desk'), findsOneWidget);
      expect(find.text('Sadhna Pass (Nastachun)'), findsOneWidget);
      expect(find.text('Cut-off Passes & Valley Road Status'), findsOneWidget);
    });

    testWidgets('DrugFreeJkScreen renders rehab centers and tabs', (tester) async {
      await tester.pumpWidget(_wrap(const DrugFreeJkScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Drug-Free J&K Youth Wing'), findsOneWidget);
      expect(find.text('Rajiv Gandhi Youth Care Mission'), findsOneWidget);
      expect(find.text('Rehab Centers'), findsOneWidget);
      expect(find.text('100% Confidential Help'), findsOneWidget);
      expect(find.text('Youth Sports Kits'), findsOneWidget);
    });
  });
}
