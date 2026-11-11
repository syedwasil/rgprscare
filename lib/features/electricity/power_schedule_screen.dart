import 'package:flutter/material.dart';

import '../../core/action_utils.dart';
import '../../core/theme/app_theme.dart';

class PowerSlot {
  const PowerSlot({
    required this.period,
    required this.duration,
    required this.isOutage,
  });

  final String period;
  final String duration;
  final bool isOutage;
}

class PowerSchedule {
  const PowerSchedule({
    required this.feederType,
    required this.season,
    required this.division,
    required this.dailyCutHours,
    required this.scheduleSlots,
    required this.note,
  });

  final String feederType; // 'Metered', 'Unmetered'
  final String season; // 'Winter', 'Summer'
  final String division; // 'Kashmir (KPDCL)', 'Jammu (JPDCL)'
  final String dailyCutHours;
  final List<PowerSlot> scheduleSlots;
  final String note;
}

const officialPddSchedules = <PowerSchedule>[
  // Kashmir - Winter - Metered
  PowerSchedule(
    feederType: 'Metered Feeder',
    season: 'Winter (Current)',
    division: 'Kashmir (KPDCL)',
    dailyCutHours: '4.5 Hours / Day',
    note: 'Scheduled rotational load shedding during peak morning and evening heating loads.',
    scheduleSlots: [
      PowerSlot(period: '06:00 AM – 07:30 AM', duration: '1.5 Hours', isOutage: true),
      PowerSlot(period: '07:30 AM – 12:30 PM', duration: '5.0 Hours', isOutage: false),
      PowerSlot(period: '12:30 PM – 02:00 PM', duration: '1.5 Hours', isOutage: true),
      PowerSlot(period: '02:00 PM – 06:00 PM', duration: '4.0 Hours', isOutage: false),
      PowerSlot(period: '06:00 PM – 07:30 PM', duration: '1.5 Hours', isOutage: true),
      PowerSlot(period: '07:30 PM – 06:00 AM', duration: '10.5 Hours', isOutage: false),
    ],
  ),
  // Kashmir - Winter - Unmetered
  PowerSchedule(
    feederType: 'Unmetered Feeder',
    season: 'Winter (Current)',
    division: 'Kashmir (KPDCL)',
    dailyCutHours: '8 Hours / Day',
    note: 'Higher curtailment in non-metered rural and semi-urban panchayats.',
    scheduleSlots: [
      PowerSlot(period: '05:30 AM – 08:00 AM', duration: '2.5 Hours', isOutage: true),
      PowerSlot(period: '08:00 AM – 12:00 PM', duration: '4.0 Hours', isOutage: false),
      PowerSlot(period: '12:00 PM – 02:30 PM', duration: '2.5 Hours', isOutage: true),
      PowerSlot(period: '02:30 PM – 05:30 PM', duration: '3.0 Hours', isOutage: false),
      PowerSlot(period: '05:30 PM – 08:30 PM', duration: '3.0 Hours', isOutage: true),
      PowerSlot(period: '08:30 PM – 05:30 AM', duration: '9.0 Hours', isOutage: false),
    ],
  ),
  // Jammu - Summer - Metered
  PowerSchedule(
    feederType: 'Metered Feeder',
    season: 'Summer',
    division: 'Jammu (JPDCL)',
    dailyCutHours: '3 Hours / Day',
    note: 'Rotational cuts during peak AC afternoon cooling demand.',
    scheduleSlots: [
      PowerSlot(period: '02:00 PM – 03:30 PM', duration: '1.5 Hours', isOutage: true),
      PowerSlot(period: '03:30 PM – 11:00 PM', duration: '7.5 Hours', isOutage: false),
      PowerSlot(period: '11:00 PM – 12:30 AM', duration: '1.5 Hours', isOutage: true),
      PowerSlot(period: '12:30 AM – 02:00 PM', duration: '13.5 Hours', isOutage: false),
    ],
  ),
  // Jammu - Summer - Unmetered
  PowerSchedule(
    feederType: 'Unmetered Feeder',
    season: 'Summer',
    division: 'Jammu (JPDCL)',
    dailyCutHours: '6.5 Hours / Day',
    note: 'Curtailment for unmetered rural feeds in plains and kandi belt.',
    scheduleSlots: [
      PowerSlot(period: '01:00 PM – 03:30 PM', duration: '2.5 Hours', isOutage: true),
      PowerSlot(period: '03:30 PM – 09:30 PM', duration: '6.0 Hours', isOutage: false),
      PowerSlot(period: '09:30 PM – 01:30 AM', duration: '4.0 Hours', isOutage: true),
      PowerSlot(period: '01:30 AM – 01:00 PM', duration: '11.5 Hours', isOutage: false),
    ],
  ),
];

class PowerScheduleScreen extends StatefulWidget {
  const PowerScheduleScreen({super.key});

  @override
  State<PowerScheduleScreen> createState() => _PowerScheduleScreenState();
}

class _PowerScheduleScreenState extends State<PowerScheduleScreen> {
  String _selectedDivision = 'Kashmir (KPDCL)';
  String _selectedFeeder = 'Metered Feeder';

  void _callPdd() {
    ActionUtils.launchPhoneCall(context, '1912');
  }

  @override
  Widget build(BuildContext context) {
    final schedule = officialPddSchedules.firstWhere(
      (s) => s.division == _selectedDivision && s.feederType == _selectedFeeder,
      orElse: () => officialPddSchedules.first,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            DualPartyEmblem(size: 30),
            SizedBox(width: 10),
            Text('PDD Power Cut Timetable'),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 36),
        children: [
          // Banner
          NeoSurface(
            padding: const EdgeInsets.all(16),
            borderRadius: 20,
            color: const Color(0xFFFFF8E1),
            borderColor: const Color(0xFFFFB300).withValues(alpha: 0.4),
            child: Row(
              children: [
                const NeoIcon(
                  Icons.electric_bolt,
                  color: AppColors.saffronDeep,
                  size: 44,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Village & Town Load Shedding',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFE65100),
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Official Power Development Department (PDD) curtailment timetable for all 20 districts.',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.mutedInk,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: _callPdd,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.saffronDeep,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.phone, size: 13, color: Colors.white),
                              SizedBox(width: 6),
                              Text(
                                'Emergency Fault Helpline: 1912',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Division Switcher
          Row(
            children: [
              Expanded(
                child: NeoFilterChip(
                  label: 'Kashmir (KPDCL)',
                  selected: _selectedDivision == 'Kashmir (KPDCL)',
                  onSelected: (_) =>
                      setState(() => _selectedDivision = 'Kashmir (KPDCL)'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: NeoFilterChip(
                  label: 'Jammu (JPDCL)',
                  selected: _selectedDivision == 'Jammu (JPDCL)',
                  onSelected: (_) =>
                      setState(() => _selectedDivision = 'Jammu (JPDCL)'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Feeder Type Switcher
          Row(
            children: [
              Expanded(
                child: NeoFilterChip(
                  label: 'Metered Feeder',
                  selected: _selectedFeeder == 'Metered Feeder',
                  onSelected: (_) =>
                      setState(() => _selectedFeeder = 'Metered Feeder'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: NeoFilterChip(
                  label: 'Unmetered (Rural)',
                  selected: _selectedFeeder == 'Unmetered Feeder',
                  onSelected: (_) =>
                      setState(() => _selectedFeeder = 'Unmetered Feeder'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Summary Card
          NeoCard(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${schedule.division} • ${schedule.season}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.mutedInk,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      schedule.feederType,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: AppColors.ink,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    schedule.dailyCutHours,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFC62828),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Daily Slot Schedule:',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 8),
          for (final slot in schedule.scheduleSlots) ...[
            NeoCard(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              margin: const EdgeInsets.only(bottom: 8),
              color: slot.isOutage ? const Color(0xFFFFFDE7) : Colors.white,
              child: Row(
                children: [
                  Icon(
                    slot.isOutage ? Icons.power_off : Icons.power,
                    color: slot.isOutage ? Colors.red : AppColors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      slot.period,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: slot.isOutage
                            ? const Color(0xFFBF360C)
                            : AppColors.ink,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: slot.isOutage
                          ? const Color(0xFFFFEBEE)
                          : AppColors.greenLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      slot.isOutage ? 'Power Cut (${slot.duration})' : 'Power On',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: slot.isOutage ? Colors.red : AppColors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 16),
          // Transformer damage escalation box
          NeoSurface(
            padding: const EdgeInsets.all(16),
            borderRadius: 18,
            color: const Color(0xFFF3E5F5),
            borderColor: const Color(0xFF8E24AA).withValues(alpha: 0.3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.bolt, color: Color(0xFF6A1B9A), size: 24),
                    SizedBox(width: 8),
                    Text(
                      'Burnt Transformer in Village?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF4A148C),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'As per citizen service charter, burnt transformers in rural areas must be replaced within 48 hours (urban: 24 hours). If delayed, report to the Congress Jan Seva Desk for immediate escalation with the Chief Engineer.',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.mutedInk,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),
                NeoButton(
                  onPressed: () => _callPdd(),
                  icon: Icons.report_problem_outlined,
                  label: 'Report Transformer Fault (1912)',
                  variant: NeoButtonVariant.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

