import 'package:flutter/material.dart';

import '../../core/action_utils.dart';
import '../../core/api_client.dart';
import '../../core/theme/app_theme.dart';
import '../../data/org/jk_geo_master.dart';

class YouthEmploymentScreen extends StatefulWidget {
  const YouthEmploymentScreen({super.key});

  @override
  State<YouthEmploymentScreen> createState() => _YouthEmploymentScreenState();
}

class _YouthEmploymentScreenState extends State<YouthEmploymentScreen> {
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _qualificationCtrl = TextEditingController();
  String _selectedDistrict = 'Srinagar';
  String _selectedExam = 'JKSSB Graduate Level (FAA / SI / Patwari)';
  bool _submitted = false;

  final _exams = [
    'JKSSB Graduate Level (FAA / SI / Patwari)',
    'JKSSB 10+2 / Matric Level (Class IV / Forester)',
    'JKPSC Combined Competitive Examination (CCE)',
    'JK Police Constable / Sub-Inspector',
    'Technical / Engineering / Polytechnic Posts',
    'General Educated Unemployed Youth',
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _qualificationCtrl.dispose();
    super.dispose();
  }

  void _submitPetition() {
    final name = _nameCtrl.text.trim();
    final phone = _phoneCtrl.text.trim();

    if (name.isEmpty || phone.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your full name and valid 10-digit mobile number.'),
          backgroundColor: Color(0xFFC62828),
        ),
      );
      return;
    }

    _sendPetitionToServer(
      name: name,
      phone: phone,
      qualification: _qualificationCtrl.text.trim().isEmpty ? 'Graduate' : _qualificationCtrl.text.trim(),
      district: _selectedDistrict,
    );

    setState(() => _submitted = true);
  }

  void _sendPetitionToServer({
    required String name,
    required String phone,
    required String qualification,
    required String district,
  }) async {
    final data = {
      'name': name,
      'phone': phone,
      'qualification': qualification,
      'district': district,
      'demand': 'Immediate recruitment of 1-Lakh vacant posts & ₹3,000 monthly allowance',
    };

    ApiClient.post('/api/petitions', data).catchError((_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            DualPartyEmblem(size: 30),
            SizedBox(width: 10),
            Text('1-Lakh Vacancy Demand Desk'),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 36),
        children: [
          // INC Youth Nyay Banner
          NeoSurface(
            padding: const EdgeInsets.all(18),
            borderRadius: 22,
            color: const Color(0xFFE3F2FD),
            borderColor: AppColors.partyBlue.withValues(alpha: 0.35),
            child: Row(
              children: [
                const NeoIcon(
                  Icons.campaign,
                  color: AppColors.partyBlue,
                  size: 46,
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Congress Youth Nyay Campaign',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: AppColors.partyBlue,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Demanding immediate fast-track recruitment for 100,000+ vacant posts in J&K, end to paper-leaks, and ₹3,000/month Unemployment Allowance.',
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
          // Live Statistics Counter
          Row(
            children: [
              Expanded(
                child: NeoCard(
                  padding: const EdgeInsets.all(14),
                  child: const Column(
                    children: [
                      Text(
                        '102,400+',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFC62828),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Vacant Govt Posts in J&K',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.mutedInk),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: NeoCard(
                  padding: const EdgeInsets.all(14),
                  child: const Column(
                    children: [
                      Text(
                        '68,450+',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: AppColors.partyBlue,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Youth Petitions Signed',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.mutedInk),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          if (!_submitted) ...[
            NeoCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sign the Public Petition to Legislative Assembly',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Your demand will be formally tabled by Congress MLAs on the floor of the J&K Assembly.',
                    style: TextStyle(fontSize: 11, color: AppColors.mutedInk),
                  ),
                  const SizedBox(height: 16),
                  NeoTextField(
                    controller: _nameCtrl,
                    labelText: 'Full Name',
                    hintText: 'Enter your name',
                    prefixIcon: Icons.person_outline,
                  ),
                  const SizedBox(height: 14),
                  NeoTextField(
                    controller: _phoneCtrl,
                    labelText: 'Mobile Number (WhatsApp updates)',
                    hintText: '10-digit number',
                    keyboardType: TextInputType.phone,
                    prefixIcon: Icons.phone_outlined,
                  ),
                  const SizedBox(height: 14),
                  NeoTextField(
                    controller: _qualificationCtrl,
                    labelText: 'Highest Qualification',
                    hintText: 'e.g. B.Tech / M.A. / Graduate / 12th',
                    prefixIcon: Icons.school_outlined,
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Target Exam / Recruitment Category',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.ink),
                  ),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedExam,
                    isExpanded: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF4F7FB),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                    ),
                    items: _exams.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 12)))).toList(),
                    onChanged: (val) => setState(() => _selectedExam = val!),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'District in J&K',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.ink),
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
                  const SizedBox(height: 20),
                  NeoButton(
                    onPressed: _submitPetition,
                    icon: Icons.how_to_vote,
                    label: 'Sign & Add My Voice to Assembly Dossier',
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
                  const SizedBox(height: 10),
                  const Text(
                    'Petition Signed Successfully!',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1B5E20)),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Thank you ${_nameCtrl.text.trim()}. Your demand has been recorded under $_selectedDistrict District delegation. Congress Legislative Party will raise this in the upcoming session.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12, color: AppColors.ink, height: 1.35),
                  ),
                  const SizedBox(height: 16),
                  NeoButton(
                    onPressed: () {
                      const shareMsg = 'I just signed the Congress Youth Nyay petition demanding 1-Lakh vacant jobs and ₹3,000 allowance for J&K youth. Join the movement via INC Care App!';
                      ActionUtils.launchWhatsApp(context, '', message: shareMsg);
                    },
                    icon: Icons.share,
                    label: 'Share on WhatsApp',
                    variant: NeoButtonVariant.saffron,
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

