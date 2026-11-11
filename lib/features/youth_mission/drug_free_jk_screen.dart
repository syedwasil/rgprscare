import 'package:flutter/material.dart';

import '../../core/action_utils.dart';
import '../../core/api_client.dart';
import '../../core/theme/app_theme.dart';
import '../../data/org/jk_geo_master.dart';

class RehabCenter {
  const RehabCenter({
    required this.name,
    required this.district,
    required this.location,
    required this.beds,
    required this.facilities,
    required this.helpline,
  });

  final String name;
  final String district;
  final String location;
  final int beds;
  final List<String> facilities;
  final String helpline;
}

const deaddictionCenters = <RehabCenter>[
  RehabCenter(
    name: 'SMHS Govt Youth De-Addiction Center',
    district: 'Srinagar',
    location: 'Shireen Bagh, SMHS Hospital Complex, Srinagar',
    beds: 30,
    facilities: ['OPD & In-Patient Detox', 'Psychiatric Counseling', 'Free Harm-Reduction Medicine'],
    helpline: '0194-2503111',
  ),
  RehabCenter(
    name: 'GMC Psychiatric Diseases Hospital (Rehab Wing)',
    district: 'Jammu',
    location: 'Bakshi Nagar / Ambphalla, Jammu',
    beds: 25,
    facilities: ['Substance Detoxification', 'Cognitive Behavioral Therapy (CBT)', 'Family Counseling'],
    helpline: '0191-2584283',
  ),
  RehabCenter(
    name: 'GMC Anantnag Addiction Treatment Facility (ATF)',
    district: 'Anantnag',
    location: 'Janglat Mandi, South Kashmir',
    beds: 15,
    facilities: ['Opioid Substitution Therapy (OST)', 'Clinical Psychologist Sessions', 'Youth Peer Group'],
    helpline: '01932-222112',
  ),
  RehabCenter(
    name: 'GMC Baramulla De-Addiction Center',
    district: 'Baramulla',
    location: 'Kanthbagh, Baramulla Town, North Kashmir',
    beds: 15,
    facilities: ['Inpatient Detox', 'Medication-Assisted Recovery', 'Social Reintegration Desk'],
    helpline: '01952-238455',
  ),
  RehabCenter(
    name: 'District Hospital Rajouri ATF Center',
    district: 'Rajouri',
    location: 'Kheora, GMC Complex, Rajouri',
    beds: 12,
    facilities: ['Detoxification Unit', 'Confidential Youth Helpline', 'Community Relapse Prevention'],
    helpline: '01962-262111',
  ),
];

class DrugFreeJkScreen extends StatefulWidget {
  const DrugFreeJkScreen({super.key});

  @override
  State<DrugFreeJkScreen> createState() => _DrugFreeJkScreenState();
}

class _DrugFreeJkScreenState extends State<DrugFreeJkScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Confidential Help Form
  final _aliasCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _situationCtrl = TextEditingController();
  String _selectedDistrict = 'Srinagar';
  bool _confidentialRequestSent = false;

  // Sports Kit Request Form (Rajiv Gandhi Youth Village Mission)
  final _clubNameCtrl = TextEditingController();
  final _captainNameCtrl = TextEditingController();
  final _captainPhoneCtrl = TextEditingController();
  final _panchayatCtrl = TextEditingController();
  String _sportsType = 'Cricket Kit (Full Willow Bats, Pads & Leather Balls)';
  bool _sportsKitRequested = false;

  final _sportsOptions = [
    'Cricket Kit (Full Willow Bats, Pads & Leather Balls)',
    'Football & Goalkeeper Kit',
    'Volleyball & High-Tension Net Set',
    'Badminton Racquets & Tournament Nets',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _aliasCtrl.dispose();
    _phoneCtrl.dispose();
    _situationCtrl.dispose();
    _clubNameCtrl.dispose();
    _captainNameCtrl.dispose();
    _captainPhoneCtrl.dispose();
    _panchayatCtrl.dispose();
    super.dispose();
  }

  void _submitConfidentialHelp() {
    if (_phoneCtrl.text.trim().length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid 10-digit mobile for private counselor callback.'),
          backgroundColor: Color(0xFFC62828),
        ),
      );
      return;
    }
    setState(() => _confidentialRequestSent = true);
  }

  void _submitSportsKit() {
    if (_clubNameCtrl.text.trim().isEmpty ||
        _captainNameCtrl.text.trim().isEmpty ||
        _captainPhoneCtrl.text.trim().length != 10 ||
        _panchayatCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all club details, Panchayat name, and 10-digit phone.'),
          backgroundColor: Color(0xFFC62828),
        ),
      );
      return;
    }

    _sendSportsKitToServer(
      clubName: _clubNameCtrl.text.trim(),
      captainName: _captainNameCtrl.text.trim(),
      captainPhone: _captainPhoneCtrl.text.trim(),
      panchayat: _panchayatCtrl.text.trim(),
      district: _selectedDistrict,
      kitType: _sportsType,
    );

    setState(() => _sportsKitRequested = true);
  }

  void _sendSportsKitToServer({
    required String clubName,
    required String captainName,
    required String captainPhone,
    required String panchayat,
    required String district,
    required String kitType,
  }) async {
    final data = {
      'clubName': clubName,
      'captainName': captainName,
      'captainPhone': captainPhone,
      'panchayat': panchayat,
      'district': district,
      'kitType': kitType,
      'status': 'PENDING ALLOCATION',
    };

    ApiClient.post('/api/sports-kits', data).catchError((_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            DualPartyEmblem(size: 30),
            SizedBox(width: 10),
            Text('Drug-Free J&K Youth Wing'),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.partyBlue,
          unselectedLabelColor: AppColors.mutedInk,
          indicatorColor: AppColors.saffron,
          indicatorWeight: 3,
          isScrollable: true,
          tabs: const [
            Tab(icon: Icon(Icons.healing_outlined), text: 'Rehab Centers'),
            Tab(icon: Icon(Icons.security), text: '100% Confidential Help'),
            Tab(icon: Icon(Icons.sports_soccer), text: 'Youth Sports Kits'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1: Rehab Center Directory
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 36),
            children: [
              // Banner
              NeoSurface(
                padding: const EdgeInsets.all(18),
                borderRadius: 22,
                color: const Color(0xFFEDE7F6),
                borderColor: const Color(0xFF673AB7).withValues(alpha: 0.35),
                child: const Row(
                  children: [
                    NeoIcon(
                      Icons.volunteer_activism,
                      color: Color(0xFF512DA8),
                      size: 46,
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rajiv Gandhi Youth Care Mission',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF311B92),
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Free medical treatment, hospital bed booking assistance, and psycho-social recovery for our youth trapped by narcotics supply cartels.',
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
              const Text(
                'De-Addiction Centers & Treatment Facilities in J&K',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: AppColors.ink),
              ),
              const SizedBox(height: 8),
              for (final c in deaddictionCenters) ...[
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
                              c.name,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.ink),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.partyBlue.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${c.beds} Detox Beds',
                              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.partyBlue),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 14, color: AppColors.mutedInk),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '${c.location} (${c.district})',
                              style: const TextStyle(fontSize: 11, color: AppColors.mutedInk, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: c.facilities
                            .map((f) => Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F8E9),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    '✓ $f',
                                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF2E7D32)),
                                  ),
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Helpline: ${c.helpline}',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.partyBlue),
                          ),
                          NeoButton(
                            onPressed: () => ActionUtils.launchPhoneCall(context, c.helpline),
                            icon: Icons.phone,
                            label: 'Call Helpline',
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

          // Tab 2: Confidential Help Request
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 36),
            children: [
              if (!_confidentialRequestSent) ...[
                NeoCard(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.lock, color: AppColors.partyBlue),
                          SizedBox(width: 8),
                          Text(
                            'Strictly Confidential Request',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: AppColors.ink),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Your identity will NEVER be shared with police, relatives, or any public body. Our verified medical counselor will contact you privately.',
                        style: TextStyle(fontSize: 11, color: AppColors.mutedInk, height: 1.35),
                      ),
                      const SizedBox(height: 14),
                      NeoTextField(
                        controller: _aliasCtrl,
                        labelText: 'Alias / Preferred Name (Optional)',
                        hintText: 'e.g. Sahil / Friend',
                        prefixIcon: Icons.badge_outlined,
                      ),
                      const SizedBox(height: 12),
                      NeoTextField(
                        controller: _phoneCtrl,
                        labelText: 'Private 10-Digit Phone (WhatsApp / Call)',
                        hintText: 'e.g. 9858000000',
                        keyboardType: TextInputType.phone,
                        prefixIcon: Icons.phone_android,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Your District',
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
                        items: jkDistrictNames.map((d) => DropdownMenuItem(value: d, child: Text(d, style: const TextStyle(fontSize: 13)))).toList(),
                        onChanged: (val) => setState(() => _selectedDistrict = val!),
                      ),
                      const SizedBox(height: 12),
                      NeoTextField(
                        controller: _situationCtrl,
                        labelText: 'Brief Situation (Self / Brother / Friend)',
                        hintText: 'e.g. Looking for detox medicine and hospital bed support for 22yo cousin',
                        prefixIcon: Icons.chat_bubble_outline,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 20),
                      NeoButton(
                        onPressed: _submitConfidentialHelp,
                        icon: Icons.shield,
                        label: 'Submit Confidential Request',
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
                  child: const Column(
                    children: [
                      Icon(Icons.check_circle, size: 52, color: AppColors.green),
                      SizedBox(height: 12),
                      Text(
                        'Confidential Request Received',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.green),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'A dedicated medical counselor from Rajiv Gandhi Youth Care Mission will reach out via discrete call / WhatsApp message within 4 hours. You are not alone.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: AppColors.ink, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),

          // Tab 3: Youth Sports Kits (Village Halqa Sponsorship)
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 36),
            children: [
              NeoSurface(
                padding: const EdgeInsets.all(18),
                borderRadius: 22,
                color: const Color(0xFFFFF3E0),
                borderColor: AppColors.saffronDeep.withValues(alpha: 0.35),
                child: const Row(
                  children: [
                    NeoIcon(
                      Icons.sports_cricket,
                      color: AppColors.saffronDeep,
                      size: 46,
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rajiv Gandhi Sports Swaraj',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFFBF360C),
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Diverting youth energy towards fitness and championships. RGPRS sponsors high-quality tournament sports kits for village Panchayat clubs.',
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
              if (!_sportsKitRequested) ...[
                NeoCard(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Apply for Panchayat Village Sports Kit',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: AppColors.ink),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Open for all youth clubs, Halqa teams, and local tournaments across J&K.',
                        style: TextStyle(fontSize: 11, color: AppColors.mutedInk),
                      ),
                      const SizedBox(height: 14),
                      NeoTextField(
                        controller: _clubNameCtrl,
                        labelText: 'Village Youth Club / Team Name',
                        hintText: 'e.g. Chenab Valley Youth Cricket Club',
                        prefixIcon: Icons.group_work_outlined,
                      ),
                      const SizedBox(height: 12),
                      NeoTextField(
                        controller: _captainNameCtrl,
                        labelText: 'Team Captain / Convener Name',
                        hintText: 'e.g. Aadil Bashir',
                        prefixIcon: Icons.person_outline,
                      ),
                      const SizedBox(height: 12),
                      NeoTextField(
                        controller: _captainPhoneCtrl,
                        labelText: 'Captain 10-Digit Mobile',
                        hintText: 'e.g. 9419000000',
                        keyboardType: TextInputType.phone,
                        prefixIcon: Icons.phone_android,
                      ),
                      const SizedBox(height: 12),
                      NeoTextField(
                        controller: _panchayatCtrl,
                        labelText: 'Halqa Panchayat & Block / Tehsil',
                        hintText: 'e.g. Halqa Panchayat Pattan, Ward 3',
                        prefixIcon: Icons.home_work_outlined,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Required Sports Equipment Kit',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.ink),
                      ),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        initialValue: _sportsType,
                        isExpanded: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF4F7FB),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                        ),
                        items: _sportsOptions.map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(fontSize: 12)))).toList(),
                        onChanged: (val) => setState(() => _sportsType = val!),
                      ),
                      const SizedBox(height: 20),
                      NeoButton(
                        onPressed: _submitSportsKit,
                        icon: Icons.card_giftcard,
                        label: 'Submit Sports Kit Sponsorship Form',
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
                        'Sponsorship Application Approved!',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.green),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Congratulations ${_clubNameCtrl.text.trim()}! Your application for $_sportsType has been dispatched to your local RGPRS Block Youth Coordinator. Kits will be presented during the upcoming Rajiv Gandhi Panchayat Cup.',
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
