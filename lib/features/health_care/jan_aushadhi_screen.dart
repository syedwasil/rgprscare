import 'package:flutter/material.dart';

import '../../core/action_utils.dart';
import '../../core/theme/app_theme.dart';

class GenericMedicine {
  const GenericMedicine({
    required this.genericName,
    required this.brandEquivalent,
    required this.category,
    required this.fairGenericPrice,
    required this.brandedPrice,
    required this.savingsPercent,
    required this.dosage,
  });

  final String genericName;
  final String brandEquivalent;
  final String category;
  final double fairGenericPrice;
  final double brandedPrice;
  final int savingsPercent;
  final String dosage;
}

const genericMedicinesList = <GenericMedicine>[
  GenericMedicine(
    genericName: 'Paracetamol 650 mg',
    brandEquivalent: 'Dolo 650 / Calpol',
    category: 'Fever & Pain Relief',
    fairGenericPrice: 12.0,
    brandedPrice: 35.0,
    savingsPercent: 66,
    dosage: '10 tablets per strip',
  ),
  GenericMedicine(
    genericName: 'Metformin 500 mg',
    brandEquivalent: 'Glycomet 500',
    category: 'Diabetes Care',
    fairGenericPrice: 15.0,
    brandedPrice: 58.0,
    savingsPercent: 74,
    dosage: '10 tablets per strip',
  ),
  GenericMedicine(
    genericName: 'Atorvastatin 10 mg',
    brandEquivalent: 'Atorva / Lipitor',
    category: 'Heart & Cholesterol',
    fairGenericPrice: 22.0,
    brandedPrice: 125.0,
    savingsPercent: 82,
    dosage: '10 tablets per strip',
  ),
  GenericMedicine(
    genericName: 'Telmisartan 40 mg',
    brandEquivalent: 'Telma 40',
    category: 'Blood Pressure / Hypertension',
    fairGenericPrice: 18.0,
    brandedPrice: 98.0,
    savingsPercent: 82,
    dosage: '10 tablets per strip',
  ),
  GenericMedicine(
    genericName: 'Azithromycin 500 mg',
    brandEquivalent: 'Azithral 500',
    category: 'Antibiotic',
    fairGenericPrice: 45.0,
    brandedPrice: 135.0,
    savingsPercent: 67,
    dosage: '3 tablets pack',
  ),
  GenericMedicine(
    genericName: 'Pantoprazole 40 mg',
    brandEquivalent: 'Pan 40 / Pantocid',
    category: 'Acidity & Gas Relief',
    fairGenericPrice: 20.0,
    brandedPrice: 115.0,
    savingsPercent: 83,
    dosage: '10 tablets per strip',
  ),
  GenericMedicine(
    genericName: 'Amoxicillin + Clavulanate 625 mg',
    brandEquivalent: 'Augmentin 625 Duo',
    category: 'Broad Spectrum Antibiotic',
    fairGenericPrice: 55.0,
    brandedPrice: 195.0,
    savingsPercent: 72,
    dosage: '6 tablets per strip',
  ),
  GenericMedicine(
    genericName: 'Montelukast + Levocetirizine',
    brandEquivalent: 'Montair LC',
    category: 'Allergy, Cough & Asthma',
    fairGenericPrice: 28.0,
    brandedPrice: 165.0,
    savingsPercent: 83,
    dosage: '10 tablets per strip',
  ),
  GenericMedicine(
    genericName: 'Human Regular Insulin 40 IU/ml',
    brandEquivalent: 'Huminsulin R',
    category: 'Insulin for Diabetes',
    fairGenericPrice: 140.0,
    brandedPrice: 460.0,
    savingsPercent: 70,
    dosage: '10 ml vial',
  ),
  GenericMedicine(
    genericName: 'Calcium Carbonate + Vitamin D3',
    brandEquivalent: 'Shelcal 500',
    category: 'Bone & Joint Health',
    fairGenericPrice: 25.0,
    brandedPrice: 110.0,
    savingsPercent: 77,
    dosage: '15 tablets per strip',
  ),
];

class HealthCampCenter {
  const HealthCampCenter({
    required this.name,
    required this.district,
    required this.organizer,
    required this.services,
    required this.address,
    required this.phone,
  });

  final String name;
  final String district;
  final String organizer;
  final String services;
  final String address;
  final String phone;
}

const congressHealthDesks = <HealthCampCenter>[
  HealthCampCenter(
    name: 'Congress Medical Relief Cell — Kashmir HQ',
    district: 'Srinagar',
    organizer: 'J&K Pradesh Congress Committee Medical Wing',
    services: 'Free Doctor Consultation, Sugar/BP Screening & Free Medicine Distribution',
    address: 'Congress House, Maulana Azad Road, Srinagar',
    phone: '0191-2578085',
  ),
  HealthCampCenter(
    name: 'Congress Medical Relief Cell — Jammu HQ',
    district: 'Jammu',
    organizer: 'Congress Seva Dal Health Mission',
    services:
        'Weekly Free Medical Checkup, Specialist Advice & Patient Support',
    address: 'Congress Bhawan, Shaheedi Chowk, Jammu',
    phone: '0191-2578085',
  ),
  HealthCampCenter(
    name: 'Congress Jan Seva Arogya Desk Anantnag',
    district: 'Anantnag',
    organizer: 'DCC Anantnag Community Care',
    services: 'Free Diagnostics assistance, Golden Card Grievance & Generic Medicine Guidance',
    address: 'K.P. Road / Janglat Mandi, Anantnag',
    phone: '0191-2578085',
  ),
  HealthCampCenter(
    name: 'Congress Health & Rural Seva Desk Baramulla',
    district: 'Baramulla',
    organizer: 'Youth Congress Health Brigade',
    services: 'Emergency Ambulance Assistance & Border Area Free Medical Camps',
    address: 'Opposite Cariappa Park, Baramulla Main',
    phone: '0191-2578085',
  ),
  HealthCampCenter(
    name: 'Chenab Valley Public Medical Relief Desk',
    district: 'Doda',
    organizer: 'DCC Doda & Bhaderwah Seva Front',
    services: 'High-Altitude Patient Transport & Free Essential Drugs Camp',
    address: 'Main Bus Stand Road, Doda Town',
    phone: '0191-2578085',
  ),
  HealthCampCenter(
    name: 'Poonch-Rajouri Border Area Medical Desk',
    district: 'Rajouri',
    organizer: 'Rajiv Gandhi Tribal Healthcare Mission',
    services: 'Mobile Medical Camps in Border and Gujjar-Bakerwal Settlements',
    address: 'Gujjar Mandi, Rajouri Town',
    phone: '0191-2578085',
  ),
];

class JanAushadhiScreen extends StatefulWidget {
  const JanAushadhiScreen({super.key});

  @override
  State<JanAushadhiScreen> createState() => _JanAushadhiScreenState();
}

class _JanAushadhiScreenState extends State<JanAushadhiScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  String _query = '';
  String _selectedDistrict = 'All J&K';

  final _districts = [
    'All J&K',
    'Srinagar',
    'Jammu',
    'Anantnag',
    'Baramulla',
    'Doda',
    'Rajouri',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _callNumber(String phone) {
    ActionUtils.launchPhoneCall(context, phone);
  }

  @override
  Widget build(BuildContext context) {
    final filteredMedicines = genericMedicinesList.where((m) {
      if (_query.isEmpty) return true;
      final q = _query.toLowerCase();
      return m.genericName.toLowerCase().contains(q) ||
          m.brandEquivalent.toLowerCase().contains(q) ||
          m.category.toLowerCase().contains(q);
    }).toList();

    final filteredDesks = congressHealthDesks.where((k) {
      if (_selectedDistrict == 'All J&K') return true;
      return k.district.toLowerCase() == _selectedDistrict.toLowerCase();
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            DualPartyEmblem(size: 30),
            SizedBox(width: 10),
            Text('Congress Arogya & Generic Meds'),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.partyBlue,
          unselectedLabelColor: AppColors.mutedInk,
          indicatorColor: AppColors.saffron,
          indicatorWeight: 3,
          tabs: const [
            Tab(
              icon: Icon(Icons.medication_liquid),
              text: 'Generic Salt Savings',
            ),
            Tab(
              icon: Icon(Icons.medical_services_outlined),
              text: 'INC Free Health Camps',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1: Generic Medicines vs Branded Monopolies
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 36),
            children: [
              // Congress Medical Relief Banner
              NeoSurface(
                padding: const EdgeInsets.all(16),
                borderRadius: 20,
                color: const Color(0xFFE8F5E9),
                borderColor: AppColors.green.withValues(alpha: 0.35),
                child: Row(
                  children: [
                    const NeoIcon(
                      Icons.health_and_safety,
                      color: AppColors.green,
                      size: 44,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'INC Jan Arogya • 50% to 90% Savings',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF1B5E20),
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Stop paying extra for expensive pharmaceutical brand names. Ask your chemist for identical WHO-GMP generic salts.',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.mutedInk,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: () => _callNumber('0191-2578085'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.green,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.phone,
                                    size: 13,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'Congress Medical Desk: 0191-2578085',
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
              NeoTextField(
                controller: _searchController,
                labelText: 'Search Generic Salt or Medicine',
                hintText: 'e.g. Paracetamol, Sugar, BP, Insulin...',
                prefixIcon: Icons.search,
                onChanged: (val) => setState(() => _query = val.trim()),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${filteredMedicines.length} Salts Listed',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppColors.mutedInk,
                    ),
                  ),
                  const Text(
                    'Fair Salt Price vs Branded Rate',
                    style: TextStyle(fontSize: 11, color: AppColors.mutedInk),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              for (final med in filteredMedicines) ...[
                NeoCard(
                  padding: const EdgeInsets.all(14),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  med.genericName,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.ink,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Branded market copy: ${med.brandEquivalent}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.mutedInk,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                Text(
                                  '(${med.category} • ${med.dosage})',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.partyBlue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.greenLight,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.green.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              '${med.savingsPercent}% SAVINGS',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: AppColors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F7FB),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Fair Generic Salt Price',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.mutedInk,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '₹${med.fairGenericPrice.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.green,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  'Private Branded Markup',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.mutedInk,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '₹${med.brandedPrice.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFC62828),
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),

          // Tab 2: Congress Free Health Camps & Relief Centers
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 36),
            children: [
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
                          onSelected: (_) =>
                              setState(() => _selectedDistrict = d),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 16),
              for (final k in filteredDesks) ...[
                NeoCard(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const NeoIcon(
                        Icons.medical_services,
                        color: AppColors.partyBlue,
                        size: 42,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              k.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: AppColors.ink,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              k.services,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.greenDeep,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              k.address,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.mutedInk,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'District: ${k.district} • Organized by ${k.organizer}',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppColors.partyBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      NeoIconButton(
                        icon: Icons.phone,
                        onPressed: () => _callNumber(k.phone),
                        color: AppColors.green,
                        tooltip: 'Call Health Desk',
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
