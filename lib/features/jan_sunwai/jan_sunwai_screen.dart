import 'package:flutter/material.dart';

import '../../core/api_client.dart';
import '../../core/theme/app_theme.dart';

class JanSunwaiEvent {
  const JanSunwaiEvent({
    required this.district,
    required this.blockVenue,
    required this.dateStr,
    required this.timeStr,
    required this.leadersAttending,
    required this.focusAreas,
    required this.coordinatorPhone,
  });

  final String district;
  final String blockVenue;
  final String dateStr;
  final String timeStr;
  final String leadersAttending;
  final List<String> focusAreas;
  final String coordinatorPhone;
}

const upcomingJanSunwais = <JanSunwaiEvent>[
  JanSunwaiEvent(
    district: 'Srinagar',
    blockVenue: 'Congress House, M.A. Road / Shalteng Community Hall',
    dateStr: 'Every Tuesday & Saturday',
    timeStr: '11:00 AM – 03:00 PM',
    leadersAttending: 'Tariq Hameed Karra (MLA) & JKPCC Public Committee',
    focusAreas: ['Electricity Tariff & Smart Meters', 'Ration Quotas', 'Urban Youth Unemployment'],
    coordinatorPhone: '0194-2452402',
  ),
  JanSunwaiEvent(
    district: 'Jammu',
    blockVenue: 'Congress Bhawan, Shaheedi Chowk / R.S. Pura Rural',
    dateStr: 'Every Monday & Friday',
    timeStr: '10:30 AM – 02:30 PM',
    leadersAttending: 'Raman Bhalla (Working President) & Tara Chand (Senior Leader)',
    focusAreas: ['Border Farmer Crop Damage', 'Kandi Water Scarcity', 'Elderly Pension Delays'],
    coordinatorPhone: '0191-2544256',
  ),
  JanSunwaiEvent(
    district: 'Anantnag',
    blockVenue: 'Dooru Shahabad Town Hall / Achabal Block',
    dateStr: 'Upcoming Thursday',
    timeStr: '11:30 AM – 03:30 PM',
    leadersAttending: 'Peerzada Mohammad Syed (MLA) & DCC President',
    focusAreas: ['Irrigation Canals', 'MGNREGA Pending Wages', 'Health Sub-Centre Staffing'],
    coordinatorPhone: '0194-2452402',
  ),
  JanSunwaiEvent(
    district: 'Bandipora',
    blockVenue: 'Dawar Gurez Rest House & Bandipora Dak Bungalow',
    dateStr: 'Upcoming Wednesday',
    timeStr: '11:00 AM – 02:00 PM',
    leadersAttending: 'Nizamuddin Bhat (MLA) & RGPRS District Team',
    focusAreas: ['Winter Ration Stocking', 'Snow Clearance Route Priority', 'Hospital Doctor Availability'],
    coordinatorPhone: '0194-2452402',
  ),
  JanSunwaiEvent(
    district: 'Baramulla',
    blockVenue: 'Wagoora-Kreeri Dak Bungalow / Uri Main Market',
    dateStr: 'Upcoming Friday',
    timeStr: '10:30 AM – 03:00 PM',
    leadersAttending: 'Irfan Hafiz Lone (MLA) & North Kashmir DCC Team',
    focusAreas: ['Border Village Security & Compensation', 'Orchard Hailstorm Relief', 'Village Road Potholes'],
    coordinatorPhone: '0194-2452402',
  ),
  JanSunwaiEvent(
    district: 'Doda',
    blockVenue: 'Bhaderwah Town Hall & Doda Dak Bungalow',
    dateStr: 'Upcoming Sunday',
    timeStr: '11:00 AM – 03:00 PM',
    leadersAttending: 'Chenab Valley DCC Leadership & PRI Coordinators',
    focusAreas: ['Rural School Teachers', 'Jal Shakti Water Pipeline Leakages', 'Burnt Transformers'],
    coordinatorPhone: '0191-2544256',
  ),
];

class JanSunwaiScreen extends StatefulWidget {
  const JanSunwaiScreen({super.key});

  @override
  State<JanSunwaiScreen> createState() => _JanSunwaiScreenState();
}

class _JanSunwaiScreenState extends State<JanSunwaiScreen> {
  String _selectedDistrict = 'All J&K';
  final _districts = ['All J&K', 'Srinagar', 'Jammu', 'Anantnag', 'Bandipora', 'Baramulla', 'Doda'];

  void _bookSlot(JanSunwaiEvent event) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            CongressEmblem(size: 32, showShadow: false),
            SizedBox(width: 10),
            Text('Book Hearing Slot', style: TextStyle(fontWeight: FontWeight.w900)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your slot has been reserved for the Jan Sunwai at:',
              style: TextStyle(fontSize: 12, color: AppColors.mutedInk),
            ),
            const SizedBox(height: 6),
            Text(
              event.blockVenue,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.ink),
            ),
            const SizedBox(height: 4),
            Text(
              'Date & Time: ${event.dateStr} (${event.timeStr})',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.partyBlue),
            ),
            const SizedBox(height: 12),
            const Text(
              '📌 Bring your complaint documents, photos, or electricity/ration bills. Congress representatives will personally receive and sign your file.',
              style: TextStyle(fontSize: 11, color: AppColors.ink, height: 1.3),
            ),
          ],
        ),
        actions: [
          NeoButton(
            onPressed: () {
              ApiClient.post('/api/jan-sunwai', {
                'district': event.district,
                'venue': event.blockVenue,
                'date': event.dateStr,
                'time': event.timeStr,
                'leaders': event.leadersAttending,
                'focusAreas': event.focusAreas.join(', '),
                'coordinatorPhone': event.coordinatorPhone,
                'slotsBooked': 1,
              }).catchError((_) => false);
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Appointment confirmed! See you at the Jan Sunwai.'),
                  backgroundColor: AppColors.green,
                ),
              );
            },
            label: 'Confirm Appointment',
            variant: NeoButtonVariant.primary,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = upcomingJanSunwais.where((e) {
      if (_selectedDistrict == 'All J&K') return true;
      return e.district.toLowerCase() == _selectedDistrict.toLowerCase();
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            DualPartyEmblem(size: 30),
            SizedBox(width: 10),
            Text('Village Jan Sunwai Schedule'),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 36),
        children: [
          // Banner
          NeoSurface(
            padding: const EdgeInsets.all(18),
            borderRadius: 22,
            color: const Color(0xFFE8EAF6),
            borderColor: AppColors.partyBlue.withValues(alpha: 0.35),
            child: Row(
              children: [
                const NeoIcon(
                  Icons.groups,
                  color: AppColors.partyBlue,
                  size: 46,
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Direct Public Grievance Hearings',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: AppColors.partyBlue,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Meet your elected Congress MLAs, DCC Presidents, and PRI leaders in person at your local Tehsil/Block. Hand over your problem dossier directly.',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.ink,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // District filter
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final d in _districts) ...[
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: NeoFilterChip(
                      label: d,
                      selected: _selectedDistrict == d,
                      onSelected: (_) => setState(() => _selectedDistrict = d),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          for (final event in filtered) ...[
            NeoCard(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.partyBlueLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${event.district} District',
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: AppColors.partyBlue),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 14, color: AppColors.saffronDeep),
                          const SizedBox(width: 4),
                          Text(
                            event.dateStr,
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.saffronDeep),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    event.blockVenue,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: AppColors.ink),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.person, size: 14, color: AppColors.mutedInk),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Presided by: ${event.leadersAttending}',
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.ink),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: event.focusAreas.map((area) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F7FB),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.outline, width: 0.8),
                      ),
                      child: Text(area, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.mutedInk)),
                    )).toList(),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.schedule, size: 14, color: AppColors.mutedInk),
                          const SizedBox(width: 4),
                          Text(event.timeStr, style: const TextStyle(fontSize: 11, color: AppColors.mutedInk, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      NeoButton(
                        onPressed: () => _bookSlot(event),
                        icon: Icons.event_available,
                        label: 'Book Slot',
                        variant: NeoButtonVariant.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
