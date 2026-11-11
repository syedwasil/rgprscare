import 'package:flutter/material.dart';

import '../../core/action_utils.dart';
import '../../core/api_client.dart';
import '../../core/theme/app_theme.dart';
import '../../data/org/jk_geo_master.dart';

class SevaBrigadeUnit {
  const SevaBrigadeUnit({
    required this.district,
    required this.captain,
    required this.activeVolunteers,
    this.phone,
    required this.services,
  });

  final String district;
  final String captain;
  final int activeVolunteers;
  final String? phone;
  final List<String> services;
}

const sevaBrigadeUnits = <SevaBrigadeUnit>[
  SevaBrigadeUnit(
    district: 'Srinagar',
    captain: 'Congress Seva Dal Central Kashmir Brigade (M.A. Road)',
    activeVolunteers: 120,
    phone: '0194-2452402',
    services: ['Emergency Hospital Blood Runs', 'Bedridden Life-Certificate Assistance', 'Winter Relief & Warm Clothing'],
  ),
  SevaBrigadeUnit(
    district: 'Jammu',
    captain: 'Youth Congress Seva Taskforce (Shaheedi Chowk)',
    activeVolunteers: 145,
    phone: '0191-2544256',
    services: ['GMC Jammu Blood Donor Coordination', 'Pension Camp Volunteering', 'Border Area Public Care'],
  ),
  SevaBrigadeUnit(
    district: 'Bandipora',
    captain: 'Gurez & Sonawari Snow Rescue Wing',
    activeVolunteers: 64,
    phone: null,
    services: ['Snowbound Patient Transfer (Stretcher)', 'Razdan Pass Stranded Support', 'Emergency Oxygen Link'],
  ),
  SevaBrigadeUnit(
    district: 'Kupwara',
    captain: 'Karnah-Machil Border Seva Brigade',
    activeVolunteers: 78,
    phone: null,
    services: ['Sadhna Pass Winter Emergency', 'Border Area Medical Assistance', 'Ration Delivery for Elders'],
  ),
  SevaBrigadeUnit(
    district: 'Anantnag',
    captain: 'South Kashmir Seva Dal Relief Unit',
    activeVolunteers: 92,
    phone: null,
    services: ['GMC Anantnag Blood SOS', 'Winter Flood & Snow Clearing', 'RTI Document Help'],
  ),
  SevaBrigadeUnit(
    district: 'Baramulla',
    captain: 'North Kashmir Youth Brigade',
    activeVolunteers: 85,
    phone: null,
    services: ['Uri Border Shelling Relief', 'Hospital Medicine Runs', 'Panchayat Seva Camps'],
  ),
  SevaBrigadeUnit(
    district: 'Doda',
    captain: 'Chenab Valley Hill Rescue Unit',
    activeVolunteers: 70,
    phone: null,
    services: ['Mountain Road Accident SOS', 'Bhaderwah Rural Hospital Relief', 'Free Textbook Bank'],
  ),
  SevaBrigadeUnit(
    district: 'Kishtwar',
    captain: 'Marwah-Wadwan Remote Valley Brigade',
    activeVolunteers: 52,
    phone: null,
    services: ['Winter Cutoff Airlift Coordination', 'Emergency Medicine Dispatch', 'Paddar Mountain Care'],
  ),
  SevaBrigadeUnit(
    district: 'Poonch',
    captain: 'Pir Panjal Border Seva Desk',
    activeVolunteers: 60,
    phone: null,
    services: ['Mughal Road Emergency', 'Tribal Gujjar-Bakerwal Camp Support', 'Blood Donation Hotline'],
  ),
  SevaBrigadeUnit(
    district: 'Rajouri',
    captain: 'Rajouri Rural & Border Seva Wing',
    activeVolunteers: 68,
    phone: null,
    services: ['GMC Rajouri Blood Bank Coordination', 'Disabled UDID Card Assistance', 'Kisan Compensation Followup'],
  ),
];

class SevaDalBrigadeScreen extends StatefulWidget {
  const SevaDalBrigadeScreen({super.key});

  @override
  State<SevaDalBrigadeScreen> createState() => _SevaDalBrigadeScreenState();
}

class _SevaDalBrigadeScreenState extends State<SevaDalBrigadeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _volNameCtrl = TextEditingController();
  final _volPhoneCtrl = TextEditingController();
  String _selectedVolDistrict = 'Srinagar';
  String _selectedBloodGroup = 'O+';
  bool _enrolled = false;

  final _bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _volNameCtrl.dispose();
    _volPhoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _transmitVolunteer({
    required String name,
    required String phone,
    required String district,
    required String bloodGroup,
  }) async {
    ApiClient.post('/api/volunteers', {
      'name': name,
      'phone': phone,
      'district': district,
      'bloodGroup': bloodGroup,
      'wing': 'Congress Seva Dal Brigade',
      'status': 'Active',
      'assignedTasks': 'Emergency Relief & Public Health Seva',
    });
  }

  void _callCaptain(String phone) {
    ActionUtils.launchPhoneCall(context, phone);
  }

  void _enrollVolunteer() {
    final name = _volNameCtrl.text.trim();
    final phone = _volPhoneCtrl.text.trim();
    if (name.isEmpty || phone.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your full name and valid 10-digit mobile number.'),
          backgroundColor: Color(0xFFC62828),
        ),
      );
      return;
    }

    // Transmit to Central Web Control Room
    _transmitVolunteer(
      name: name,
      phone: phone,
      district: _selectedVolDistrict,
      bloodGroup: _selectedBloodGroup,
    );

    setState(() => _enrolled = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            DualPartyEmblem(size: 30),
            SizedBox(width: 10),
            Text('Congress Seva Dal Brigade'),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.partyBlue,
          unselectedLabelColor: AppColors.mutedInk,
          indicatorColor: AppColors.saffron,
          indicatorWeight: 3,
          tabs: const [
            Tab(icon: Icon(Icons.emergency_outlined), text: 'District Units & SOS'),
            Tab(icon: Icon(Icons.volunteer_activism), text: 'Join Seva Brigade'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1: District Units
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 36),
            children: [
              // Banner
              NeoSurface(
                padding: const EdgeInsets.all(18),
                borderRadius: 22,
                color: const Color(0xFFE8F5E9),
                borderColor: AppColors.green.withValues(alpha: 0.35),
                child: Row(
                  children: [
                    const NeoIcon(
                      Icons.shield,
                      color: AppColors.green,
                      size: 46,
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Seva Dal Ground Relief Network',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF1B5E20),
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Grassroots volunteer corps active across all 20 districts of J&K for winter medical emergencies, blood donations & patient relief.',
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
              for (final unit in sevaBrigadeUnits) ...[
                NeoCard(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: AppColors.partyBlue, size: 20),
                              const SizedBox(width: 6),
                              Text(
                                '${unit.district} District',
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: AppColors.ink),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.greenLight,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${unit.activeVolunteers} Volunteers Active',
                              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.green),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        unit.captain,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.partyBlue),
                      ),
                      const SizedBox(height: 8),
                      for (final s in unit.services) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            children: [
                              const Icon(Icons.check, size: 14, color: AppColors.green),
                              const SizedBox(width: 6),
                              Expanded(child: Text(s, style: const TextStyle(fontSize: 11, color: AppColors.mutedInk))),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 12),
                      if (unit.phone != null && unit.phone!.isNotEmpty) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            NeoButton(
                              onPressed: () => _callCaptain(unit.phone!),
                              icon: Icons.phone_in_talk,
                              label: 'Call Seva Brigade HQ',
                              variant: NeoButtonVariant.primary,
                            ),
                          ],
                        ),
                      ] else ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColors.canvas,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.shield_outlined, size: 13, color: AppColors.green),
                                  SizedBox(width: 5),
                                  Text(
                                    'Panchayat volunteers active on ground',
                                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.mutedInk),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ],
          ),

          // Tab 2: Enroll as a Seva Dal Volunteer
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 36),
            children: [
              if (!_enrolled) ...[
                NeoCard(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          CongressEmblem(size: 32, showShadow: false),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Enroll in Congress Seva Dal',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: AppColors.ink),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Join India\'s oldest and most disciplined volunteer organization. Serve the people of Jammu & Kashmir during snowstorms, emergencies, and medical distress.',
                        style: TextStyle(fontSize: 11, color: AppColors.mutedInk, height: 1.35),
                      ),
                      const SizedBox(height: 16),
                      NeoTextField(
                        controller: _volNameCtrl,
                        labelText: 'Full Name',
                        hintText: 'Enter your name',
                        prefixIcon: Icons.badge_outlined,
                      ),
                      const SizedBox(height: 14),
                      NeoTextField(
                        controller: _volPhoneCtrl,
                        labelText: 'Mobile Number',
                        hintText: '10-digit number',
                        keyboardType: TextInputType.phone,
                        prefixIcon: Icons.phone_outlined,
                      ),
                      const SizedBox(height: 14),
                      const Text('District in J&K', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.ink)),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        initialValue: _selectedVolDistrict,
                        isExpanded: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF4F7FB),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                        ),
                        items: jkDistrictNames.map((d) => DropdownMenuItem(value: d, child: Text(d, style: const TextStyle(fontSize: 13)))).toList(),
                        onChanged: (val) => setState(() => _selectedVolDistrict = val!),
                      ),
                      const SizedBox(height: 14),
                      const Text('Blood Group (for Emergency Donor Registry)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.ink)),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        initialValue: _selectedBloodGroup,
                        isExpanded: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF4F7FB),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                        ),
                        items: _bloodGroups.map((b) => DropdownMenuItem(value: b, child: Text(b, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800)))).toList(),
                        onChanged: (val) => setState(() => _selectedBloodGroup = val!),
                      ),
                      const SizedBox(height: 20),
                      NeoButton(
                        onPressed: _enrollVolunteer,
                        icon: Icons.check_circle_outline,
                        label: 'Enroll as Seva Dal Volunteer',
                        variant: NeoButtonVariant.saffron,
                        isFullWidth: true,
                      ),
                    ],
                  ),
                ),
              ] else ...[
                NeoSurface(
                  padding: const EdgeInsets.all(22),
                  borderRadius: 20,
                  color: const Color(0xFFE8F5E9),
                  borderColor: AppColors.green.withValues(alpha: 0.4),
                  child: Column(
                    children: [
                      const Icon(Icons.volunteer_activism, size: 54, color: AppColors.green),
                      const SizedBox(height: 10),
                      const Text(
                        'Welcome to Congress Seva Dal!',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Color(0xFF1B5E20)),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Comrade ${_volNameCtrl.text.trim()}, you are now registered with $_selectedVolDistrict District Seva Brigade (Blood Group: $_selectedBloodGroup). Your local block captain will contact you for community seva activities.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12, color: AppColors.ink, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

