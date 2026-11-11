import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/action_utils.dart';
import '../../core/theme/app_theme.dart';

class ScholarshipItem {
  const ScholarshipItem({
    required this.title,
    required this.department,
    required this.eligibility,
    required this.benefitAmount,
    required this.lastDate,
    required this.documents,
    required this.portalUrl,
    required this.category,
  });

  final String title;
  final String department;
  final String eligibility;
  final String benefitAmount;
  final String lastDate;
  final List<String> documents;
  final String portalUrl;
  final String category;
}

const scholarshipList = <ScholarshipItem>[
  ScholarshipItem(
    title: 'PMSSS',
    department: 'AICTE & Higher Education Dept J&K',
    eligibility: '12th Pass students of J&K with family income < ₹8 Lakh/year',
    benefitAmount:
        '100% Tuition Fee + ₹1.00 Lakh/year Hostel & Maintenance allowance',
    lastDate: 'Online Counselling Phase',
    category: 'College & Higher Ed',
    portalUrl: 'aicte-jk-scholarship-gov.in',
    documents: [
      'J&K Domicile Certificate',
      '10th & 12th Marks Sheet',
      'Tehsildar Income Certificate',
      'Aadhaar seeded bank account',
      'Category Certificate (if SC/ST/OBC/SEBC)',
    ],
  ),
  ScholarshipItem(
    title: 'Post-Matric Scholarship for SC / ST / OBC / Minorities',
    department: 'Social Welfare & Tribal Affairs J&K',
    eligibility:
        'Class 11, 12, ITI, Diploma, Graduation & Post-Graduation students',
    benefitAmount: '₹3,000 to ₹15,000 annual maintenance fee + non-refundable college fees',
    lastDate: '31st January (Annually)',
    category: 'School & College',
    portalUrl: 'scholarships.gov.in (NSP Portal)',
    documents: [
      'Domicile Certificate of J&K',
      'Valid Category / Caste Certificate',
      'Income Certificate (< ₹2.5 Lakh)',
      'Previous Exam Marksheet & Fee Receipt',
      'Hostel certificate (for hostellers)',
    ],
  ),
  ScholarshipItem(
    title: 'Tribal Affairs Gujjar-Bakerwal Hostel & Stipend',
    department: 'Tribal Affairs Department J&K',
    eligibility:
        'Students belonging to Gujjar, Bakerwal & Scheduled Tribe communities',
    benefitAmount:
        'Free boarding, lodging, uniforms, books + ₹2,400 seasonal stipend',
    lastDate: 'Admissions open seasonally',
    category: 'Tribal Welfare',
    portalUrl: 'tribal.jk.gov.in',
    documents: [
      'Scheduled Tribe (ST) Certificate',
      'Ration Card / Nomadic Family proof',
      'School Admission Slip',
      'Aadhaar Card',
    ],
  ),
  ScholarshipItem(
    title: 'Begum Hazrat Mahal National Scholarship',
    department: 'Ministry of Minority Affairs',
    eligibility:
        'Meritorious minority girl students studying in Class 9th to 12th',
    benefitAmount:
        '₹5,000 to ₹6,000/year directly to girl student bank account',
    lastDate: 'Active on NSP',
    category: 'Girl Child Welfare',
    portalUrl: 'scholarships.gov.in',
    documents: [
      'Self-declaration of Minority community',
      'Marksheet with at least 50% marks',
      'Income Certificate below ₹2.0 Lakh',
      'Institution Verification Form',
    ],
  ),
];

class CoachingBatch {
  const CoachingBatch({
    required this.exam,
    required this.organizedBy,
    required this.mode,
    required this.eligibility,
    required this.status,
    required this.contactPerson,
    required this.phone,
  });

  final String exam;
  final String organizedBy;
  final String mode;
  final String eligibility;
  final String status;
  final String contactPerson;
  final String phone;
}

const officialCoachingBatches = <CoachingBatch>[
  CoachingBatch(
    exam: 'Free NEET & JEE Mentoring (Mission Shiksha)',
    organizedBy: 'Rajiv Gandhi Study Circle & Youth Congress',
    mode: 'Hybrid (Online lectures + District study rooms)',
    eligibility:
        'Rural & Economically Weaker Section (EWS) 11th & 12th students',
    status: 'Batch 2026-27 Enrollment Open',
    contactPerson: 'Rajiv Gandhi Study Circle Desk (Kashmir)',
    phone: '0194-2452402',
  ),
  CoachingBatch(
    exam: 'JKPSC CCE / UPSC Prelims Foundation Desk',
    organizedBy: 'INC Youth Mentorship Wing',
    mode: 'Weekend physical interactive batches + mock test series',
    eligibility: 'Graduates from rural panchayats and border areas',
    status: 'Test Series Active',
    contactPerson: 'INC Youth Mentorship Desk (Jammu)',
    phone: '0191-2544256',
  ),
  CoachingBatch(
    exam: 'Free College Book Bank & Study Material Distribution',
    organizedBy: 'RGPRS District Student Care Desks',
    mode: 'Available at all 20 district headquarters',
    eligibility: 'Any college or university student needing course textbooks',
    status: 'Permanent Free Service',
    contactPerson: 'RGPRS Youth & Student Desk',
    phone: '0194-2452402',
  ),
];

class ScholarshipsScreen extends StatefulWidget {
  const ScholarshipsScreen({super.key});

  @override
  State<ScholarshipsScreen> createState() => _ScholarshipsScreenState();
}

class _ScholarshipsScreenState extends State<ScholarshipsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

  void _callContact(String phone) {
    ActionUtils.launchPhoneCall(context, phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            DualPartyEmblem(size: 30),
            SizedBox(width: 10),
            Text('Scholarships & Free Coaching'),
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
              icon: Icon(Icons.school_outlined),
              text: 'Student Scholarships',
            ),
            Tab(
              icon: Icon(Icons.menu_book_outlined),
              text: 'Free Coaching & Books',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1: Scholarships
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 36),
            children: [
              // Banner
              NeoSurface(
                padding: const EdgeInsets.all(16),
                borderRadius: 20,
                color: const Color(0xFFE8EAF6),
                borderColor: AppColors.partyBlue.withValues(alpha: 0.35),
                child: const Row(
                  children: [
                    NeoIcon(Icons.school, color: AppColors.partyBlue, size: 44),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Higher Education Rights for J&K Youth',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: AppColors.partyBlue,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Never miss financial support for your studies. Check eligibility, deadlines, and required document checklists.',
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
              for (final sc in scholarshipList) ...[
                NeoCard(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 14),
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
                                  sc.title,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.ink,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  sc.department,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.mutedInk,
                                    fontWeight: FontWeight.w600,
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
                              color: AppColors.partyBlueLight,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              sc.category,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: AppColors.partyBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F7FB),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.monetization_on_outlined,
                                  size: 16,
                                  color: AppColors.green,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    'Benefit: ${sc.benefitAmount}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFF1B5E20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.how_to_reg_outlined,
                                  size: 16,
                                  color: AppColors.partyBlue,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    'Eligibility: ${sc.eligibility}',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.ink,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(
                                  Icons.language,
                                  size: 16,
                                  color: AppColors.mutedInk,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Official Portal: ${sc.portalUrl}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.partyBlue,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Mandatory Documents:',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: AppColors.ink,
                        ),
                      ),
                      const SizedBox(height: 4),
                      for (final doc in sc.documents) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1.5),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                size: 14,
                                color: AppColors.green,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  doc,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.mutedInk,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: NeoButton(
                              onPressed: () {
                                final checklist =
                                    '${sc.title} - Mandatory Documents:\n'
                                    '${sc.documents.map((d) => '• $d').join('\n')}\n'
                                    'Portal: ${sc.portalUrl}\n'
                                    'Assistance: RGPRS Student Care (0194-2452402)';
                                Clipboard.setData(
                                  ClipboardData(text: checklist),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Document checklist copied! Ready to share or save.',
                                    ),
                                    backgroundColor: AppColors.partyBlue,
                                  ),
                                );
                              },
                              icon: Icons.copy,
                              label: 'Checklist',
                              variant: NeoButtonVariant.surface,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: NeoButton(
                              onPressed: () => _callContact('0194-2452402'),
                              icon: Icons.support_agent,
                              label: 'Student Cell',
                              variant: NeoButtonVariant.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),

          // Tab 2: Free Coaching Batches
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 36),
            children: [
              for (final batch in officialCoachingBatches) ...[
                NeoCard(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const NeoIcon(
                            Icons.workspace_premium_outlined,
                            color: AppColors.saffronDeep,
                            size: 40,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  batch.exam,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.ink,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  batch.organizedBy,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.partyBlue,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F7FB),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mode: ${batch.mode}',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.ink,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Target Students: ${batch.eligibility}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.mutedInk,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Current Status: ${batch.status}',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: AppColors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Contact: ${batch.contactPerson}',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.ink,
                              ),
                            ),
                          ),
                          NeoButton(
                            onPressed: () => _callContact(batch.phone),
                            icon: Icons.phone,
                            label: 'Call Desk',
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
        ],
      ),
    );
  }
}
