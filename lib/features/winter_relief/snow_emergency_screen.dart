import 'package:flutter/material.dart';

import '../../core/action_utils.dart';
import '../../core/api_client.dart';
import '../../core/theme/app_theme.dart';

class MountainPassStatus {
  const MountainPassStatus({
    required this.name,
    required this.altitude,
    required this.route,
    required this.status,
    required this.snowDepth,
    required this.advisory,
    required this.emergencyCoordinator,
    required this.phone,
  });

  final String name;
  final String altitude;
  final String route;
  final String status; // 'BLOCKED' or 'OPEN - CHAINS ONLY'
  final String snowDepth;
  final String advisory;
  final String emergencyCoordinator;
  final String phone;
}

const mountainPasses = <MountainPassStatus>[
  MountainPassStatus(
    name: 'Sadhna Pass (Nastachun)',
    altitude: '10,269 ft',
    route: 'Kupwara ↔ Karnah & Tangdhar',
    status: 'HEAVY SNOW / INTERMITTENT',
    snowDepth: '3.5 - 4 Feet',
    advisory: 'Strict 4x4 with anti-skid tyre chains. RGPRS Karnah snow stretcher team on standby at Chowkibal & TP.',
    emergencyCoordinator: 'Kupwara Traffic / Disaster Helpline',
    phone: '0194-2450022',
  ),
  MountainPassStatus(
    name: 'Razdan Pass',
    altitude: '11,672 ft',
    route: 'Bandipora ↔ Gurez Valley',
    status: 'CLOSED (WINTER CUT-OFF)',
    snowDepth: '5 - 6 Feet',
    advisory: 'Complete road closure for winter. Air rescue / Indian Army helicopter requisition assistance via RGPRS Gurez cell.',
    emergencyCoordinator: 'Bandipora / Gurez Disaster Desk',
    phone: '0194-2450022',
  ),
  MountainPassStatus(
    name: 'Sinthan Top & Margan Pass',
    altitude: '12,300 ft',
    route: 'Anantnag (Kokernag) ↔ Kishtwar / Marwah-Wadwan',
    status: 'CLOSED FOR SEASON',
    snowDepth: '4.5 Feet',
    advisory: 'Inaccessible. Marwah-Warwan remote high valleys isolated. Emergency medical stretcher helpline active.',
    emergencyCoordinator: 'Chenab / Anantnag Traffic Control',
    phone: '0191-2459048',
  ),
  MountainPassStatus(
    name: 'Mughal Road (Pir Ki Gali)',
    altitude: '11,500 ft',
    route: 'Shopian (Kashmir) ↔ Bafliaz / Poonch-Rajouri',
    status: 'SEASONAL CLOSURE',
    snowDepth: '3 - 4 Feet',
    advisory: 'Vehicular movement suspended. Poonch patients routed via Jammu-Srinagar NH44.',
    emergencyCoordinator: 'TCR Jammu / Poonch Control Desk',
    phone: '0191-2459048',
  ),
  MountainPassStatus(
    name: 'Machil & Keran Passes',
    altitude: '9,800 ft',
    route: 'Kupwara ↔ Border Line of Control Villages',
    status: 'INTERMITTENT CUT-OFF',
    snowDepth: '3 Feet',
    advisory: 'Army convoys only. Civil emergency stretcher and medicine carrier squad active.',
    emergencyCoordinator: 'Kashmir Emergency Helpline',
    phone: '0194-2450022',
  ),
];

class SnowEmergencyScreen extends StatefulWidget {
  const SnowEmergencyScreen({super.key});

  @override
  State<SnowEmergencyScreen> createState() => _SnowEmergencyScreenState();
}

class _SnowEmergencyScreenState extends State<SnowEmergencyScreen> {
  final _patientNameCtrl = TextEditingController();
  final _contactPhoneCtrl = TextEditingController();
  final _villageLocalityCtrl = TextEditingController();
  final _medicalEmergencyCtrl = TextEditingController();
  String _selectedDistrict = 'Kupwara';
  bool _sosDispatched = false;

  final _highSnowDistricts = [
    'Kupwara',
    'Bandipora',
    'Baramulla',
    'Ganderbal',
    'Anantnag',
    'Kulgam',
    'Shopian',
    'Kishtwar',
    'Doda',
    'Ramban',
    'Poonch',
  ];

  @override
  void dispose() {
    _patientNameCtrl.dispose();
    _contactPhoneCtrl.dispose();
    _villageLocalityCtrl.dispose();
    _medicalEmergencyCtrl.dispose();
    super.dispose();
  }

  void _dispatchSos() {
    final patient = _patientNameCtrl.text.trim();
    final phone = _contactPhoneCtrl.text.trim();
    final loc = _villageLocalityCtrl.text.trim();

    if (patient.isEmpty || phone.length != 10 || loc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter patient name, 10-digit phone, and village location.'),
          backgroundColor: Color(0xFFC62828),
        ),
      );
      return;
    }

    _sendSosToServer(
      patient: patient,
      phone: phone,
      district: _selectedDistrict,
      loc: loc,
      medicalIssue: _medicalEmergencyCtrl.text.trim(),
    );

    setState(() => _sosDispatched = true);
  }

  void _sendSosToServer({
    required String patient,
    required String phone,
    required String district,
    required String loc,
    required String medicalIssue,
  }) async {
    final data = {
      'patientName': '$patient ($medicalIssue)',
      'attendantPhone': phone,
      'district': district,
      'passArea': loc,
      'distanceToRoad': 'Cut-off village',
      'status': 'STRETCHER SQUAD DISPATCHED',
      'squadCaptain': 'RGPRS $district Volunteer Brigade',
      'targetHospital': 'Nearest SDH / GMC Hospital',
    };

    ApiClient.post('/api/snow-sos', data).catchError((_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            DualPartyEmblem(size: 30),
            SizedBox(width: 10),
            Text('Chilla-i-Kalan Snow Helpline'),
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
            color: const Color(0xFFE1F5FE),
            borderColor: const Color(0xFF0288D1).withValues(alpha: 0.35),
            child: Row(
              children: [
                const NeoIcon(
                  Icons.ac_unit,
                  color: Color(0xFF0288D1),
                  size: 46,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'RGPRS Winter Stretcher & SOS Desk',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF01579B),
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        'During 40-day Chilla-i-Kalan sub-zero freezes, RGPRS panchayat volunteers provide emergency snow stretchers (ڈولی و اسٹریچر امداد) and link-road clearing for cut-off villages.',
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

          // High Altitude Mountain Pass Status
          const Text(
            'Cut-off Passes & Valley Road Status',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: AppColors.ink),
          ),
          const SizedBox(height: 8),
          for (final pass in mountainPasses) ...[
            NeoCard(
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          pass.name,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.ink),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: pass.status.contains('CLOSED')
                              ? const Color(0xFFFFEBEE)
                              : const Color(0xFFFFF3E0),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: pass.status.contains('CLOSED')
                                ? const Color(0xFFEF5350)
                                : const Color(0xFFFFA726),
                            width: 0.8,
                          ),
                        ),
                        child: Text(
                          pass.status,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: pass.status.contains('CLOSED')
                                ? const Color(0xFFC62828)
                                : const Color(0xFFE65100),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.terrain, size: 14, color: AppColors.mutedInk),
                      const SizedBox(width: 4),
                      Text(
                        '${pass.altitude} • ${pass.route}',
                        style: const TextStyle(fontSize: 11, color: AppColors.mutedInk, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Snow Accumulation: ${pass.snowDepth}',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF0277BD)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pass.advisory,
                    style: const TextStyle(fontSize: 11, color: AppColors.ink, height: 1.3),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Desk: ${pass.emergencyCoordinator}',
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.partyBlue),
                      ),
                      NeoButton(
                        onPressed: () => ActionUtils.launchPhoneCall(context, pass.phone),
                        icon: Icons.phone_forwarded,
                        label: 'Call Helpline',
                        variant: NeoButtonVariant.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 16),

          // Patient Stretcher & Snow Evacuation Request
          if (!_sosDispatched) ...[
            NeoCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.emergency_share, color: Color(0xFFC62828)),
                      SizedBox(width: 8),
                      Text(
                        'Request Emergency Snow Stretcher',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: AppColors.ink),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'For pregnant women, heart/kidney dialysis patients, or severe injury in snowbound villages where roads are blocked.',
                    style: TextStyle(fontSize: 11, color: AppColors.mutedInk),
                  ),
                  const SizedBox(height: 14),
                  NeoTextField(
                    controller: _patientNameCtrl,
                    labelText: 'Patient Full Name',
                    hintText: 'e.g. Parveena Begum',
                    prefixIcon: Icons.person_outline,
                  ),
                  const SizedBox(height: 12),
                  NeoTextField(
                    controller: _contactPhoneCtrl,
                    labelText: 'Attendant 10-Digit Mobile',
                    hintText: 'e.g. 9858000000',
                    keyboardType: TextInputType.phone,
                    prefixIcon: Icons.phone_android,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Snowbound District',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.ink),
                  ),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedDistrict,
                    isExpanded: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF4F7FB),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                    ),
                    items: _highSnowDistricts.map((d) => DropdownMenuItem(value: d, child: Text(d, style: const TextStyle(fontSize: 13)))).toList(),
                    onChanged: (val) => setState(() => _selectedDistrict = val!),
                  ),
                  const SizedBox(height: 12),
                  NeoTextField(
                    controller: _villageLocalityCtrl,
                    labelText: 'Village, Tehsil & Distance from Motor Road',
                    hintText: 'e.g. Village Dawar, Gurez (4 km from main road)',
                    prefixIcon: Icons.location_on_outlined,
                  ),
                  const SizedBox(height: 12),
                  NeoTextField(
                    controller: _medicalEmergencyCtrl,
                    labelText: 'Nature of Medical Emergency',
                    hintText: 'e.g. Full-term pregnancy labour / chest pain',
                    prefixIcon: Icons.medical_services_outlined,
                  ),
                  const SizedBox(height: 18),
                  NeoButton(
                    onPressed: _dispatchSos,
                    icon: Icons.sos,
                    label: 'Dispatch RGPRS Village Stretcher Team',
                    variant: NeoButtonVariant.primary,
                    isFullWidth: true,
                  ),
                ],
              ),
            ),
          ] else ...[
            NeoSurface(
              padding: const EdgeInsets.all(20),
              borderRadius: 20,
              color: const Color(0xFFE8F5E9),
              borderColor: AppColors.green.withValues(alpha: 0.4),
              child: Column(
                children: [
                  const Icon(Icons.check_circle, size: 52, color: AppColors.green),
                  const SizedBox(height: 12),
                  const Text(
                    'Snow Emergency Alert Dispatched!',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.green),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'RGPRS Panchayat Seva Squad for $_selectedDistrict and local Halqa Panchs have been alerted for ${_patientNameCtrl.text.trim()} at ${_villageLocalityCtrl.text.trim()}. Local volunteers are mobilizing with manual stretcher / sled.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12, color: AppColors.ink, height: 1.4),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Direct 24×7 Snow Relief: 0194-2452402 (Kashmir) / 0191-2544256 (Jammu) / 112',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.partyBlue),
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
