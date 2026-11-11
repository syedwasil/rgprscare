import 'package:flutter/material.dart';

import '../../core/action_utils.dart';
import '../../core/theme/app_theme.dart';

class RepresentativeContact {
  const RepresentativeContact({
    required this.name,
    required this.role,
    required this.tier,
    required this.district,
    required this.area,
    this.phone,
    required this.partyDesignation,
  });

  final String name;
  final String role;
  final String tier;
  final String district;
  final String area;
  final String? phone;
  final String partyDesignation;
}

const officialRepresentativeDirectory = <RepresentativeContact>[
  // 1. Srinagar
  RepresentativeContact(
    name: 'Tariq Hameed Karra',
    role: 'MLA Central Shalteng / President JKPCC',
    tier: 'Assembly & State Unit',
    district: 'Srinagar',
    area: 'Central Shalteng / Srinagar',
    phone: null, // Personal contact private
    partyDesignation: 'President, J&K Pradesh Congress Committee',
  ),
  RepresentativeContact(
    name: 'District Congress Committee (DCC) Srinagar',
    role: 'District Party Headquarters',
    tier: 'District Congress Committee',
    district: 'Srinagar',
    area: 'Congress House, Maulana Azad Road, Srinagar',
    phone: '0194-2452402',
    partyDesignation: 'INC Public Grievance & Citizen Desk',
  ),
  RepresentativeContact(
    name: 'RGPRS Srinagar Panchayati Wing',
    role: 'Halqa & Ward Seva Lead',
    tier: 'Halqa & Ward Care',
    district: 'Srinagar',
    area: 'Harwan / Khonmoh / Faqir Gujri',
    phone: '0194-2452402',
    partyDesignation: 'Rajiv Gandhi Panchayati Raj Sangathan Desk',
  ),

  // 2. Ganderbal
  RepresentativeContact(
    name: 'District Congress Committee (DCC) Ganderbal',
    role: 'District Party Headquarters',
    tier: 'District Congress Committee',
    district: 'Ganderbal',
    area: 'Main Market, Beehama Chowk, Ganderbal',
    phone: '0194-2452402',
    partyDesignation: 'INC District Public Relief Desk',
  ),
  RepresentativeContact(
    name: 'RGPRS Kangan & Gund Mountain Desk',
    role: 'Rural & Tribal Seva Lead',
    tier: 'Panchayat & Block Care',
    district: 'Ganderbal',
    area: 'Kangan / Gund / Manigam Block',
    phone: null, // Personal contact private
    partyDesignation: 'Tribal & Hill Area Care Coordinator',
  ),

  // 3. Budgam
  RepresentativeContact(
    name: 'District Congress Committee (DCC) Budgam',
    role: 'District Party Headquarters',
    tier: 'District Congress Committee',
    district: 'Budgam',
    area: 'Near New Bus Stand, Budgam Main Town',
    phone: '0194-2452402',
    partyDesignation: 'INC District Grievance Cell',
  ),
  RepresentativeContact(
    name: 'RGPRS Beerwah & Chadoora Help Desk',
    role: 'Block & Halqa Coordinator',
    tier: 'Panchayat Council Desk',
    district: 'Budgam',
    area: 'Beerwah / Khag / Chadoora Blocks',
    phone: null, // Personal contact private
    partyDesignation: 'Panchayati Raj Rural Welfare Lead',
  ),

  // 4. Anantnag
  RepresentativeContact(
    name: 'Peerzada Mohammad Syed',
    role: 'MLA Anantnag / Senior Leader JKPCC',
    tier: 'Assembly & State Unit',
    district: 'Anantnag',
    area: 'Anantnag / Dooru Constituency',
    phone: null, // Personal contact private
    partyDesignation: 'Senior Vice President, JKPCC',
  ),
  RepresentativeContact(
    name: 'District Congress Committee (DCC) Anantnag',
    role: 'District Party Headquarters',
    tier: 'District Congress Committee',
    district: 'Anantnag',
    area: 'K.P. Road / Janglat Mandi, Anantnag',
    phone: '0194-2452402',
    partyDesignation: 'South Kashmir INC Care Center',
  ),

  // 5. Kulgam
  RepresentativeContact(
    name: 'District Congress Committee (DCC) Kulgam',
    role: 'District Party Headquarters',
    tier: 'District Congress Committee',
    district: 'Kulgam',
    area: 'Main Bazar, Near Court Complex, Kulgam',
    phone: '0194-2452402',
    partyDesignation: 'INC Public Grievance Center',
  ),
  RepresentativeContact(
    name: 'RGPRS Devsar & D.H. Pora Rural Wing',
    role: 'Panchayat Seva Desk',
    tier: 'Block & Halqa Care',
    district: 'Kulgam',
    area: 'Devsar / D.H. Pora / Qaimoh Blocks',
    phone: null, // Personal contact private
    partyDesignation: 'Kisan & Youth Employment Support',
  ),

  // 6. Pulwama
  RepresentativeContact(
    name: 'District Congress Committee (DCC) Pulwama',
    role: 'District Party Headquarters',
    tier: 'District Congress Committee',
    district: 'Pulwama',
    area: 'Murran Chowk, Pulwama Main',
    phone: '0194-2452402',
    partyDesignation: 'INC Citizen Rights Desk',
  ),
  RepresentativeContact(
    name: 'RGPRS Saffron & Rural Farmer Desk',
    role: 'Kisan Care & PRI Wing',
    tier: 'Block Development Desk',
    district: 'Pulwama',
    area: 'Pampore / Tral / Awantipora',
    phone: null, // Personal contact private
    partyDesignation: 'Saffron Growers & Rural Help Desk',
  ),

  // 7. Shopian
  RepresentativeContact(
    name: 'District Congress Committee (DCC) Shopian',
    role: 'District Party Headquarters',
    tier: 'District Congress Committee',
    district: 'Shopian',
    area: 'Gol Chakkar, Batpora, Shopian',
    phone: '0194-2452402',
    partyDesignation: 'INC Public Assistance Desk',
  ),
  RepresentativeContact(
    name: 'RGPRS Apple Growers & PRI Help Desk',
    role: 'Horticulture & Village Care',
    tier: 'Halqa Panchayat Wing',
    district: 'Shopian',
    area: 'Keller / Hermain / Zainapora',
    phone: null, // Personal contact private
    partyDesignation: 'Apple Farmer & Rural Citizen Cell',
  ),

  // 8. Baramulla
  RepresentativeContact(
    name: 'Irfan Hafiz Lone',
    role: 'MLA Wagoora-Kreeri / Senior Representative',
    tier: 'Assembly',
    district: 'Baramulla',
    area: 'Wagoora-Kreeri / North Kashmir',
    phone: null, // Personal contact private
    partyDesignation: 'INC Legislative Care Representative',
  ),
  RepresentativeContact(
    name: 'District Congress Committee (DCC) Baramulla',
    role: 'District Party Headquarters',
    tier: 'District Congress Committee',
    district: 'Baramulla',
    area: 'Opposite Cariappa Park, Baramulla Main',
    phone: '0194-2452402',
    partyDesignation: 'North Kashmir Public Grievance Office',
  ),

  // 9. Kupwara
  RepresentativeContact(
    name: 'District Congress Committee (DCC) Kupwara',
    role: 'District Party Headquarters',
    tier: 'District Congress Committee',
    district: 'Kupwara',
    area: 'Bypass Road, Near Old Bus Stand, Kupwara',
    phone: '0194-2452402',
    partyDesignation: 'INC Border & Remote Area Help Desk',
  ),
  RepresentativeContact(
    name: 'RGPRS Karnah & Lolab Border Desk',
    role: 'Remote Pass & Border Village Wing',
    tier: 'Panchayat Front',
    district: 'Kupwara',
    area: 'Tangdhar (Karnah) / Lolab / Handwara',
    phone: null, // Personal contact private
    partyDesignation: 'Snow Evacuation & Ration Care',
  ),

  // 10. Bandipora
  RepresentativeContact(
    name: 'Nizamuddin Bhat',
    role: 'MLA Bandipora / Senior Leader',
    tier: 'Assembly',
    district: 'Bandipora',
    area: 'Bandipora Assembly Segment',
    phone: null, // Personal contact private
    partyDesignation: 'Congress Legislative Care Desk',
  ),
  RepresentativeContact(
    name: 'District Congress Committee (DCC) Bandipora',
    role: 'District Party Headquarters',
    tier: 'District Congress Committee',
    district: 'Bandipora',
    area: 'Gulshan Chowk, Bandipora Town',
    phone: '0194-2452402',
    partyDesignation: 'INC Citizen Service Center',
  ),

  // 11. Jammu
  RepresentativeContact(
    name: 'Raman Bhalla',
    role: 'Working President, JKPCC / Former Minister',
    tier: 'State Unit & Provincial Leadership',
    district: 'Jammu',
    area: 'Jammu South / R.S. Pura',
    phone: null, // Personal contact private
    partyDesignation: 'Working President, J&K Pradesh Congress Committee',
  ),
  RepresentativeContact(
    name: 'Tara Chand',
    role: 'Senior Vice President / Former Deputy CM',
    tier: 'Provincial Leadership',
    district: 'Jammu',
    area: 'Chhamb / Akhnoor Rural',
    phone: null, // Personal contact private
    partyDesignation: 'Former Deputy Chief Minister J&K',
  ),
  RepresentativeContact(
    name: 'J&K Pradesh Congress HQ (Jammu)',
    role: 'State Headquarters (Jammu Province)',
    tier: 'State Headquarters',
    district: 'Jammu',
    area: 'Congress Bhawan, Shaheedi Chowk, Jammu',
    phone: '0191-2544256',
    partyDesignation: 'Central Congress Public Jan Seva Desk',
  ),

  // 12. Samba
  RepresentativeContact(
    name: 'District Congress Committee (DCC) Samba',
    role: 'District Party Headquarters',
    tier: 'District Congress Committee',
    district: 'Samba',
    area: 'Main Chowk, National Highway, Samba',
    phone: '0191-2544256',
    partyDesignation: 'INC Border Farmer Assistance Cell',
  ),
  RepresentativeContact(
    name: 'RGPRS Vijaypur & Ramgarh Border Desk',
    role: 'Panchayat & Border Seva Lead',
    tier: 'Halqa Panchayat Wing',
    district: 'Samba',
    area: 'Ramgarh / Vijaypur / Ghagwal Blocks',
    phone: null, // Personal contact private
    partyDesignation: 'Border Shelling & Farmer Compensation Desk',
  ),

  // 13. Kathua
  RepresentativeContact(
    name: 'District Congress Committee (DCC) Kathua',
    role: 'District Party Headquarters',
    tier: 'District Congress Committee',
    district: 'Kathua',
    area: 'College Road, Near District Library, Kathua',
    phone: '0191-2544256',
    partyDesignation: 'INC Public Grievance Office',
  ),
  RepresentativeContact(
    name: 'RGPRS Hiranagar & Basohli Hill Desk',
    role: 'Kandi Belt & Rural Welfare Lead',
    tier: 'Panchayat Care Wing',
    district: 'Kathua',
    area: 'Hiranagar / Basohli / Billawar',
    phone: null, // Personal contact private
    partyDesignation: 'Kandi Area Water & Employment Desk',
  ),

  // 14. Udhampur
  RepresentativeContact(
    name: 'District Congress Committee (DCC) Udhampur',
    role: 'District Party Headquarters',
    tier: 'District Congress Committee',
    district: 'Udhampur',
    area: 'Sailan Talab, Udhampur Town',
    phone: '0191-2544256',
    partyDesignation: 'INC Public Redressal Desk',
  ),
  RepresentativeContact(
    name: 'RGPRS Chenani & Ramnagar Rural Desk',
    role: 'Hill Panchayat Lead',
    tier: 'Block Development Wing',
    district: 'Udhampur',
    area: 'Chenani / Ramnagar / Majalta Blocks',
    phone: null, // Personal contact private
    partyDesignation: 'Rural Road & Electricity Escalation Desk',
  ),

  // 15. Reasi
  RepresentativeContact(
    name: 'District Congress Committee (DCC) Reasi',
    role: 'District Party Headquarters',
    tier: 'District Congress Committee',
    district: 'Reasi',
    area: 'Nai Basti, Near Bus Stand, Reasi',
    phone: '0191-2544256',
    partyDesignation: 'INC District Seva Center',
  ),
  RepresentativeContact(
    name: 'RGPRS Mahore & Arnas Hill Desk',
    role: 'Remote Hill Panchayat Lead',
    tier: 'Panchayat Council Desk',
    district: 'Reasi',
    area: 'Mahore / Arnas / Pouni Blocks',
    phone: null, // Personal contact private
    partyDesignation: 'Remote Village Connectivity Help Desk',
  ),

  // 16. Rajouri
  RepresentativeContact(
    name: 'Shabir Ahmad Khan',
    role: 'Senior Leader / Former Minister',
    tier: 'Assembly & District Leadership',
    district: 'Rajouri',
    area: 'Rajouri / Manjakote',
    phone: null, // Personal contact private
    partyDesignation: 'Panchayati Raj State Advisory Patron',
  ),
  RepresentativeContact(
    name: 'District Congress Committee (DCC) Rajouri',
    role: 'District Party Headquarters',
    tier: 'District Congress Committee',
    district: 'Rajouri',
    area: 'Gujjar Mandi, Rajouri Town',
    phone: '0191-2544256',
    partyDesignation: 'Border & Gujjar-Bakerwal Welfare Desk',
  ),

  // 17. Poonch
  RepresentativeContact(
    name: 'District Congress Committee (DCC) Poonch',
    role: 'District Party Headquarters',
    tier: 'District Congress Committee',
    district: 'Poonch',
    area: 'Bus Stand Chowk, Poonch Main',
    phone: '0191-2544256',
    partyDesignation: 'INC Border Relief & Seva Center',
  ),
  RepresentativeContact(
    name: 'RGPRS Surankote & Mendhar Tribal Wing',
    role: 'Tribal & Pahari Welfare Lead',
    tier: 'Panchayat Desk',
    district: 'Poonch',
    area: 'Surankote / Mendhar / Mandi Blocks',
    phone: null, // Personal contact private
    partyDesignation: 'Tribal Rights & Forest Patta Support',
  ),

  // 18. Doda
  RepresentativeContact(
    name: 'District Congress Committee (DCC) Doda',
    role: 'District Party Headquarters',
    tier: 'District Congress Committee',
    district: 'Doda',
    area: 'Main Bus Stand Road, Doda Town',
    phone: '0191-2544256',
    partyDesignation: 'Chenab Valley INC Care Desk',
  ),
  RepresentativeContact(
    name: 'RGPRS Bhaderwah & Gandoh Rural Desk',
    role: 'Chenab PRI Coordinator',
    tier: 'Panchayat Front',
    district: 'Doda',
    area: 'Bhaderwah / Gandoh (Bhalessa) / Assar',
    phone: null, // Personal contact private
    partyDesignation: 'Chenab Valley Citizen Support Cell',
  ),

  // 19. Ramban
  RepresentativeContact(
    name: 'District Congress Committee (DCC) Ramban',
    role: 'District Party Headquarters',
    tier: 'District Congress Committee',
    district: 'Ramban',
    area: 'Main Market, Highway Road, Ramban',
    phone: '0191-2544256',
    partyDesignation: 'Highway Citizen Help Desk',
  ),
  RepresentativeContact(
    name: 'RGPRS Banihal & Gool Welfare Wing',
    role: 'Highway & Hill Panchayat Lead',
    tier: 'Panchayat Council Desk',
    district: 'Ramban',
    area: 'Banihal / Gool / Batote Blocks',
    phone: null, // Personal contact private
    partyDesignation: 'NH-44 Stranded Passenger & Rural Seva',
  ),

  // 20. Kishtwar
  RepresentativeContact(
    name: 'District Congress Committee (DCC) Kishtwar',
    role: 'District Party Headquarters',
    tier: 'District Congress Committee',
    district: 'Kishtwar',
    area: 'Chowgan Ground, Kishtwar Main Town',
    phone: '0191-2544256',
    partyDesignation: 'INC Remote Valley Assistance Office',
  ),
  RepresentativeContact(
    name: 'RGPRS Marwah, Wadwan & Paddar Desk',
    role: 'High-Altitude Cutoff Valley Lead',
    tier: 'Remote Panchayat Front',
    district: 'Kishtwar',
    area: 'Marwah / Wadwan / Warwan / Paddar',
    phone: null, // Personal contact private
    partyDesignation: 'Winter Airlift & Emergency Food Grain Cell',
  ),
];

class RepresentativeFinderScreen extends StatefulWidget {
  const RepresentativeFinderScreen({super.key});

  @override
  State<RepresentativeFinderScreen> createState() => _RepresentativeFinderScreenState();
}

class _RepresentativeFinderScreenState extends State<RepresentativeFinderScreen> {
  String _selectedDistrict = 'Srinagar';

  final _allDistricts = [
    // Kashmir Division (10)
    'Srinagar', 'Ganderbal', 'Budgam', 'Anantnag', 'Kulgam',
    'Pulwama', 'Shopian', 'Baramulla', 'Kupwara', 'Bandipora',
    // Jammu Division (10)
    'Jammu', 'Samba', 'Kathua', 'Udhampur', 'Reasi',
    'Rajouri', 'Poonch', 'Doda', 'Ramban', 'Kishtwar'
  ];

  @override
  Widget build(BuildContext context) {
    final reps = officialRepresentativeDirectory
        .where((r) => r.district.toLowerCase() == _selectedDistrict.toLowerCase())
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            DualPartyEmblem(size: 30),
            SizedBox(width: 10),
            Text('Find My Representative'),
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
                  Icons.person_pin_circle_outlined,
                  color: AppColors.partyBlue,
                  size: 48,
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Direct Citizen Access',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: AppColors.ink,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Connect directly with your elected local Sarpanch, BDC, DDC members & Congress Public Help coordinators.',
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
          // District Selector
          const Text(
            'SELECT YOUR DISTRICT',
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
                for (final d in _allDistricts) ...[
                  NeoFilterChip(
                    label: d,
                    selected: _selectedDistrict == d,
                    selectedColor: AppColors.partyBlue,
                    onSelected: (_) => setState(() => _selectedDistrict = d),
                  ),
                  const SizedBox(width: 8),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$_selectedDistrict REPRESENTATIVES & HELP DESK',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: AppColors.mutedInk,
                  letterSpacing: 0.8,
                ),
              ),
              Text(
                reps.isEmpty ? 'Central Desk Active' : '${reps.length} Contacts',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.partyBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (reps.isEmpty) ...[
            NeoCard(
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  const CongressEmblem(size: 46),
                  const SizedBox(height: 14),
                  Text(
                    '$_selectedDistrict District Central Help Desk',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: AppColors.ink),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Our local Halqa roster is syncing. You can reach the state coordination desk for immediate help:',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: AppColors.mutedInk),
                  ),
                  const SizedBox(height: 16),
                  NeoButton(
                    onPressed: () => ActionUtils.launchPhoneCall(context, '0194-2452402'),
                    icon: Icons.phone_in_talk,
                    label: 'Call JKPCC HQ (0194-2452402)',
                    variant: NeoButtonVariant.green,
                  ),
                ],
              ),
            ),
          ] else ...[
            for (final rep in reps)
              _RepresentativeCard(rep: rep),
          ],
        ],
      ),
    );
  }
}

class _RepresentativeCard extends StatelessWidget {
  const _RepresentativeCard({required this.rep});

  final RepresentativeContact rep;

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
              const CongressEmblem(size: 42, showShadow: false),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            rep.name,
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
                            color: AppColors.partyBlueLight,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            rep.tier,
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: AppColors.partyBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      rep.role,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.saffronDeep,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${rep.area} · ${rep.partyDesignation}',
                      style: const TextStyle(fontSize: 11, color: AppColors.mutedInk),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 10),
          if (rep.phone != null && rep.phone!.isNotEmpty) ...[
            Row(
              children: [
                Expanded(
                  child: NeoButton(
                    onPressed: () => ActionUtils.launchPhoneCall(context, rep.phone!),
                    icon: Icons.call,
                    label: 'Call Official Desk',
                    variant: NeoButtonVariant.green,
                  ),
                ),
                const SizedBox(width: 10),
                NeoIconButton(
                  icon: Icons.chat_bubble_outline,
                  color: AppColors.partyBlue,
                  tooltip: 'Send WhatsApp message',
                  onPressed: () {
                    final msg = 'Salam / Namaskar, I am contacting regarding ${rep.area} through the RGPRS Care app.';
                    ActionUtils.launchWhatsApp(context, rep.phone!, message: msg);
                  },
                ),
              ],
            ),
          ] else ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.canvas,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.outline, width: 0.8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.shield_outlined, size: 14, color: AppColors.mutedInk),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Personal contact is private. Contact via District Party Office or Jan Sunwai.',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.mutedInk),
                    ),
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
