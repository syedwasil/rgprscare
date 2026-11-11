import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/action_utils.dart';
import '../../core/api_client.dart';
import '../../core/theme/app_theme.dart';
import '../../data/org/jk_geo_master.dart';
import 'blood_data.dart';

class BloodScreen extends ConsumerStatefulWidget {
  const BloodScreen({super.key});

  @override
  ConsumerState<BloodScreen> createState() => _BloodScreenState();
}

class _BloodScreenState extends ConsumerState<BloodScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final requests = ref.watch(bloodSosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            DualPartyEmblem(size: 30),
            SizedBox(width: 10),
            Text('Blood SOS & Donors'),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.partyBlue,
          unselectedLabelColor: AppColors.mutedInk,
          indicatorColor: const Color(0xFFD32F2F),
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
          tabs: const [
            Tab(text: '🚨 Emergency Requests'),
            Tab(text: '🏥 J&K Blood Banks'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFD32F2F),
        foregroundColor: Colors.white,
        onPressed: () => _showPostSosDialog(context),
        icon: const Icon(Icons.add_alert),
        label: const Text(
          'Post Blood Need',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1: Requests
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 90),
            children: [
              // Urgent alert card
              NeoSurface(
                padding: const EdgeInsets.all(16),
                color: const Color(0xFFFFEBEE),
                borderColor: const Color(0xFFD32F2F).withValues(alpha: 0.3),
                child: Row(
                  children: [
                    const Icon(Icons.favorite, color: Color(0xFFD32F2F), size: 36),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'INC Citizen Blood Seva Network',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFFC62828),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Connecting patients in J&K hospitals with verified local donors & Youth Congress volunteers.',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.ink,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${requests.length} ACTIVE BLOOD REQUESTS',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: AppColors.mutedInk,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const Text(
                    'Direct Call Family',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFD32F2F),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (requests.isEmpty)
                NeoCard(
                  padding: const EdgeInsets.all(24),
                  margin: const EdgeInsets.only(top: 8),
                  child: Column(
                    children: [
                      const Icon(Icons.check_circle_outline, color: AppColors.green, size: 48),
                      const SizedBox(height: 12),
                      const Text(
                        'No Active Emergency Blood Requests',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: AppColors.ink),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'All clear at present. J&K Hospital 24×7 blood banks are available in the next tab. Tap "Post Blood Need" below if a patient requires emergency donors.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: AppColors.mutedInk, height: 1.4),
                      ),
                    ],
                  ),
                )
              else
                for (final req in requests)
                  _BloodRequestCard(request: req),
            ],
          ),

          // Tab 2: Hospital Blood Banks
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
            children: [
              const Text(
                'Direct lines to certified blood transfusion centers across Jammu & Kashmir hospitals:',
                style: TextStyle(fontSize: 12, color: AppColors.mutedInk),
              ),
              const SizedBox(height: 14),
              for (final bank in jkBloodBanks)
                NeoCard(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      const NeoIcon(
                        Icons.local_hospital,
                        color: Color(0xFFD32F2F),
                        size: 42,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bank.hospitalName,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: AppColors.ink,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${bank.district} · ${bank.division} Division',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.mutedInk,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              bank.phone,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: AppColors.partyBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      NeoButton(
                        onPressed: () => ActionUtils.launchPhoneCall(context, bank.phone),
                        icon: Icons.call,
                        label: 'Call',
                        variant: NeoButtonVariant.green,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _transmitBloodSos({
    required String patientName,
    required String bloodGroup,
    required int unitsNeeded,
    required String hospitalName,
    required String district,
    required String contactPhone,
  }) async {
    ApiClient.post('/api/blood-sos', {
      'patientName': patientName,
      'bloodGroup': bloodGroup,
      'unitsNeeded': unitsNeeded,
      'hospitalName': hospitalName,
      'district': district,
      'contactPhone': contactPhone,
      'urgency': 'CRITICAL',
      'status': 'URGENT',
      'matchedDonor': 'Awaiting Donor Matching',
    });
  }

  void _showPostSosDialog(BuildContext context) {
    final patientNameCtrl = TextEditingController();
    final hospitalCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    String selectedBloodGroup = 'O+';
    int unitsNeeded = 1;
    String district = 'Srinagar';

    final bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
    final districts = jkDistrictNames;

    showDialog<void>(
      context: context,
      builder: (dialogCtx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.emergency, color: Color(0xFFD32F2F)),
              SizedBox(width: 8),
              Text(
                'Post Blood Requirement',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Patient Name',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                NeoSurface(
                  padding: EdgeInsets.zero,
                  borderRadius: 12,
                  isSunken: true,
                  child: TextField(
                    controller: patientNameCtrl,
                    decoration: const InputDecoration(
                      hintText: 'Enter patient full name',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Blood Group',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 4),
                          DropdownButtonFormField<String>(
                            initialValue: selectedBloodGroup,
                            items: bloodGroups
                                .map((bg) => DropdownMenuItem(value: bg, child: Text(bg, style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFFD32F2F)))))
                                .toList(),
                            onChanged: (val) {
                              if (val != null) setDialogState(() => selectedBloodGroup = val);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Units Needed',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 4),
                          DropdownButtonFormField<int>(
                            initialValue: unitsNeeded,
                            items: [1, 2, 3, 4, 5]
                                .map((u) => DropdownMenuItem(value: u, child: Text('$u Units')))
                                .toList(),
                            onChanged: (val) {
                              if (val != null) setDialogState(() => unitsNeeded = val);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Hospital / Blood Bank Location',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                NeoSurface(
                  padding: EdgeInsets.zero,
                  borderRadius: 12,
                  isSunken: true,
                  child: TextField(
                    controller: hospitalCtrl,
                    decoration: const InputDecoration(
                      hintText: 'e.g. SMHS Srinagar / GMC Jammu',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'District',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                DropdownButtonFormField<String>(
                  initialValue: district,
                  items: districts
                      .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setDialogState(() => district = val);
                  },
                ),
                const SizedBox(height: 12),
                const Text(
                  'Contact Phone Number',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                NeoSurface(
                  padding: EdgeInsets.zero,
                  borderRadius: 12,
                  isSunken: true,
                  child: TextField(
                    controller: phoneCtrl,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: '10-digit attendant phone number',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogCtx).pop(),
              child: const Text('Cancel'),
            ),
            NeoButton(
              onPressed: () {
                final name = patientNameCtrl.text.trim();
                final hosp = hospitalCtrl.text.trim();
                final phone = phoneCtrl.text.trim();
                if (name.isEmpty || phone.isEmpty) return;

                final resolvedHosp = hosp.isEmpty ? 'District Hospital' : hosp;
                ref.read(bloodSosProvider.notifier).addRequest(
                      BloodSosRequest(
                        id: 'sos-${DateTime.now().millisecondsSinceEpoch}',
                        patientName: name,
                        bloodGroup: selectedBloodGroup,
                        unitsNeeded: unitsNeeded,
                        hospitalName: resolvedHosp,
                        district: district,
                        contactPhone: phone,
                        urgency: 'CRITICAL',
                        createdAt: DateTime.now(),
                      ),
                    );

                // Broadcast directly to RGPRS & INC Central Web Control Room
                _transmitBloodSos(
                  patientName: name,
                  bloodGroup: selectedBloodGroup,
                  unitsNeeded: unitsNeeded,
                  hospitalName: resolvedHosp,
                  district: district,
                  contactPhone: phone,
                );

                Navigator.of(dialogCtx).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Emergency Blood Request Posted & Broadcast to Local Volunteers!'),
                    backgroundColor: Color(0xFFD32F2F),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: Icons.send,
              label: 'Broadcast SOS',
              variant: NeoButtonVariant.danger,
            ),
          ],
        ),
      ),
    );
  }
}

class _BloodRequestCard extends StatelessWidget {
  const _BloodRequestCard({required this.request});

  final BloodSosRequest request;

  @override
  Widget build(BuildContext context) {
    return NeoCard(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Blood group badge
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE53935), Color(0xFFC62828)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x35E53935),
                      offset: Offset(2, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    request.bloodGroup,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            request.patientName,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: AppColors.ink,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEBEE),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            request.urgency,
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFFD32F2F),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${request.unitsNeeded} Units needed · ${request.district}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.partyBlue,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.local_hospital_outlined, size: 13, color: AppColors.mutedInk),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            request.hospitalName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 11, color: AppColors.mutedInk),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Contact: ${request.contactPhone}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                ),
              ),
              NeoButton(
                onPressed: () => ActionUtils.launchPhoneCall(context, request.contactPhone),
                icon: Icons.phone_in_talk,
                label: 'Help & Donate',
                variant: NeoButtonVariant.green,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
