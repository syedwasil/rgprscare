import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/action_utils.dart';
import '../../core/theme/app_theme.dart';

class RtiLegalAidScreen extends StatefulWidget {
  const RtiLegalAidScreen({super.key});

  @override
  State<RtiLegalAidScreen> createState() => _RtiLegalAidScreenState();
}

class _RtiLegalAidScreenState extends State<RtiLegalAidScreen> {
  int _selectedTemplateIndex = 0;

  final _applicantNameCtrl = TextEditingController();
  final _villageCtrl = TextEditingController();
  final _districtCtrl = TextEditingController();
  final _refNumberCtrl = TextEditingController();

  final _templates = [
    (
      title: 'Delayed Pension Inquiry (ISSS)',
      targetOffice: 'Public Information Officer (PIO), Office of District Social Welfare Officer',
      subject: 'Information regarding delayed monthly pension under ISSS (Old Age / Widow / Disability)',
      bodyGenerator: (String name, String village, String district, String ref) => '''
To,
The Public Information Officer (PIO),
Office of District Social Welfare Officer,
District $district, Jammu & Kashmir.

Subject: Request for Information under Right to Information (RTI) Act, 2005.

Sir / Madam,
I, $name, resident of $village, District $district, had applied for pension under the Integrated Social Security Scheme (ISSS) vide Application Ref No: $ref. My pension has not been credited for the past several months.

Kindly provide the following point-wise information under Section 6 of the RTI Act:
1. Daily progress report and current file movement status of my pension application.
2. The exact official reason for withholding / delay in disbursal of my monthly pension.
3. Name, designation, and official contact of the officer responsible for the delay.
4. The exact tentative date by which the arrears and current monthly pension will be credited.

I have affixed the mandatory RTI application fee of ₹10 (Postal Order / Court Fee Stamp).

Applicant Name: $name
Address: $village, District $district, J&K
Date: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}
''',
    ),
    (
      title: 'Pending MGNREGA Wage Payment',
      targetOffice: 'Public Information Officer (PIO), Office of Block Development Officer (BDO)',
      subject: 'Information regarding non-payment of MGNREGA wages within statutory 15 days',
      bodyGenerator: (String name, String village, String district, String ref) => '''
To,
The Public Information Officer (PIO),
Office of Block Development Officer (BDO),
Block / Halqa $village, District $district, J&K.

Subject: Information regarding non-payment of MGNREGA wages under RTI Act, 2005.

Sir / Madam,
I, $name, holding MGNREGA Job Card No: $ref, performed unskilled manual work for the sanctioned village development work in Halqa $village. More than 15 days have elapsed but my wages have not been credited into my bank account.

Kindly provide the following information:
1. Date of muster roll closure and FTO (Fund Transfer Order) generation for the work performed.
2. The exact reason why wages were not paid within the statutory 15-day deadline under Section 3 of MGNREGA.
3. Amount of delay compensation calculated and payable to me as per the statutory guidelines.
4. Tentative date of credit into my DBT bank account.

Applicant: $name
Halqa: $village, District $district
''',
    ),
    (
      title: 'Ration Quota Curtailment & PDS Stock (NFSA)',
      targetOffice: 'Public Information Officer (PIO), Office of Assistant Director, Food & Civil Supplies',
      subject: 'Inquiry into short distribution of monthly food grains under National Food Security Act',
      bodyGenerator: (String name, String village, String district, String ref) => '''
To,
The Public Information Officer (PIO),
Office of Assistant Director (FCS&CA),
District $district, Jammu & Kashmir.

Subject: Request for Information under Right to Information (RTI) Act, 2005.

Sir / Madam,
I, $name, holding Ration Card No: $ref in Halqa / Ward $village, District $district. The local government fair price dealer has curtailed or refused to deliver the mandated monthly food grains (Rice & Wheat).

Kindly provide the following certified information:
1. Exact monthly allotment quota of food grains sanctioned for my ration depot for the last 6 months.
2. The certified sales register and biometric e-PoS transaction log for my ration card number $ref.
3. The official scale of distribution and government-approved retail rate per kg for AAY/PHH cardholders.
4. Name and designation of the Food Inspector responsible for monitoring distribution in my Halqa.

Applicant: $name
Halqa: $village, District $district
''',
    ),
  ];

  @override
  void dispose() {
    _applicantNameCtrl.dispose();
    _villageCtrl.dispose();
    _districtCtrl.dispose();
    _refNumberCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeTemplate = _templates[_selectedTemplateIndex];
    final name = _applicantNameCtrl.text.trim();
    final village = _villageCtrl.text.trim();
    final district = _districtCtrl.text.trim();
    final ref = _refNumberCtrl.text.trim();

    final generatedRtiText = activeTemplate.bodyGenerator(
      name.isEmpty ? '[Your Name]' : name,
      village.isEmpty ? '[Your Village / Ward]' : village,
      district.isEmpty ? '[Your District]' : district,
      ref.isEmpty ? '[Application / Job Card / Reg No]' : ref,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            DualPartyEmblem(size: 30),
            SizedBox(width: 10),
            Text('Free Legal Aid & RTI'),
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
            child: Row(
              children: [
                const NeoIcon(
                  Icons.gavel,
                  color: AppColors.partyBlue,
                  size: 48,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Jan Adhikar — Citizen RTI Desk',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: AppColors.ink,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Government officer not releasing your pension, wages, or housing funds? Generate a legally binding RTI application in 60 seconds.',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.mutedInk,
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
          // Template Chooser
          const Text(
            'CHOOSE RTI TEMPLATE',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              color: AppColors.mutedInk,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < _templates.length; i++) ...[
                  NeoFilterChip(
                    label: _templates[i].title,
                    selected: _selectedTemplateIndex == i,
                    selectedColor: AppColors.partyBlue,
                    onSelected: (_) => setState(() => _selectedTemplateIndex = i),
                  ),
                  const SizedBox(width: 8),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          // User Details Form for auto-filling
          NeoCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Details (Auto-fills into RTI)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.ink),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _applicantNameCtrl,
                        onChanged: (_) => setState(() {}),
                        decoration: const InputDecoration(
                          labelText: 'Applicant Name',
                          contentPadding: EdgeInsets.all(12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _villageCtrl,
                        onChanged: (_) => setState(() {}),
                        decoration: const InputDecoration(
                          labelText: 'Village / Halqa',
                          contentPadding: EdgeInsets.all(12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _districtCtrl,
                        onChanged: (_) => setState(() {}),
                        decoration: const InputDecoration(
                          labelText: 'District',
                          contentPadding: EdgeInsets.all(12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _refNumberCtrl,
                        onChanged: (_) => setState(() {}),
                        decoration: const InputDecoration(
                          labelText: 'Ref / Job Card / Reg No',
                          contentPadding: EdgeInsets.all(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Generated RTI Output Stage
          NeoCard(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Ready-to-Print RTI Application',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: AppColors.ink,
                      ),
                    ),
                    NeoButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: generatedRtiText));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('RTI text copied to clipboard! You can paste and print.'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: Icons.copy,
                      label: 'Copy RTI',
                      variant: NeoButtonVariant.primary,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                NeoSurface(
                  padding: const EdgeInsets.all(14),
                  borderRadius: 14,
                  isSunken: true,
                  child: Text(
                    generatedRtiText,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: AppColors.ink,
                      height: 1.45,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                // Legal filing instructions
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.saffronLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '📌 Quick Steps to Submit:',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.saffronDeep),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '1. Print or write this on plain paper.\n'
                        '2. Buy a ₹10 Postal Order from any Post Office (or paste ₹10 court fee stamp).\n'
                        '3. Hand it to the designated office or send by Registered Speed Post.\n'
                        '4. Under RTI Act 2005 Section 7(1), the officer MUST answer within 30 days.',
                        style: TextStyle(fontSize: 11, color: AppColors.ink, height: 1.35),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          // INC Legal Cell Assistance Card
          NeoCard(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                const NeoIcon(
                  Icons.scale,
                  color: AppColors.partyBlue,
                  size: 44,
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Need Free Lawyer Advice?',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.ink,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Congress Legal Cell advocates provide pro-bono guidance for poor villagers fighting unjust administrative delays.',
                        style: TextStyle(fontSize: 11, color: AppColors.mutedInk),
                      ),
                    ],
                  ),
                ),
                NeoButton(
                  onPressed: () => ActionUtils.launchPhoneCall(context, '0191-2578085'),
                  icon: Icons.call,
                  label: 'Free Legal Help',
                  variant: NeoButtonVariant.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

