import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/action_utils.dart';
import '../../core/theme/app_theme.dart';
import 'schemes_data.dart';

class SchemeDetailScreen extends StatefulWidget {
  const SchemeDetailScreen({super.key, required this.schemeId});

  final String schemeId;

  @override
  State<SchemeDetailScreen> createState() => _SchemeDetailScreenState();
}

class _SchemeDetailScreenState extends State<SchemeDetailScreen> {
  final Set<int> _checkedDocs = {};

  @override
  Widget build(BuildContext context) {
    final scheme = allWelfareSchemes.firstWhere(
      (s) => s.id == widget.schemeId,
      orElse: () => allWelfareSchemes.first,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          scheme.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
        children: [
          // Header Card
          NeoCard(
            padding: const EdgeInsets.all(20),
            hasTricolorTop: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NeoIcon(scheme.icon, size: 48, color: AppColors.partyBlue),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.saffronLight,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              scheme.badge,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: AppColors.saffronDeep,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            scheme.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: AppColors.ink,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            scheme.urduTitle.isNotEmpty ? scheme.urduTitle : scheme.hindiTitle,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.partyBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1),
                const SizedBox(height: 14),
                const Text(
                  'Scheme Benefits Overview',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  scheme.fullBenefit,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.ink,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Eligibility Criteria
          NeoCard(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.checklist_rtl, color: AppColors.green, size: 22),
                    SizedBox(width: 10),
                    Text(
                      'Who is Eligible?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: AppColors.ink,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                for (final rule in scheme.eligibilityCriteria) ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          size: 18,
                          color: AppColors.green,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            rule,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.ink,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Required Documents Checklist with Interactive Checkmarks!
          NeoCard(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.folder_shared_outlined, color: AppColors.saffronDeep, size: 22),
                        SizedBox(width: 10),
                        Text(
                          'Required Documents',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: AppColors.ink,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${_checkedDocs.length}/${scheme.requiredDocuments.length} Ready',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.partyBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Tap each document you have ready to ensure your application won\'t be rejected:',
                  style: TextStyle(fontSize: 11, color: AppColors.mutedInk),
                ),
                const SizedBox(height: 14),
                for (int i = 0; i < scheme.requiredDocuments.length; i++) ...[
                  Builder(
                    builder: (context) {
                      final hasDoc = _checkedDocs.contains(i);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (hasDoc) {
                              _checkedDocs.remove(i);
                            } else {
                              _checkedDocs.add(i);
                            }
                          });
                        },
                        child: NeoCard(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          margin: const EdgeInsets.only(bottom: 8),
                          isSunken: hasDoc,
                          borderColor: hasDoc ? AppColors.green : null,
                          child: Row(
                            children: [
                              Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: hasDoc ? AppColors.green : Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: hasDoc ? AppColors.green : AppColors.outline,
                                    width: 1.6,
                                  ),
                                ),
                                child: hasDoc
                                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                                    : null,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  scheme.requiredDocuments[i],
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: hasDoc ? FontWeight.w800 : FontWeight.w600,
                                    color: hasDoc ? AppColors.greenDeep : AppColors.ink,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          // How to Apply & Office
          NeoCard(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.how_to_reg_outlined, color: AppColors.partyBlue, size: 22),
                    SizedBox(width: 10),
                    Text(
                      'How to Apply',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: AppColors.ink,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  scheme.howToApply,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.ink,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 14),
                const Divider(height: 1),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.place_outlined, size: 16, color: AppColors.mutedInk),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Designated Office: ${scheme.officialPortalOrOffice}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.partyBlue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.phone_outlined, size: 16, color: AppColors.mutedInk),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'Helpline: ${scheme.helpline}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.greenDeep,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    NeoButton(
                      onPressed: () => ActionUtils.launchPhoneCall(context, scheme.helpline),
                      icon: Icons.call,
                      label: 'Call',
                      variant: NeoButtonVariant.green,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Need Help Button
          NeoButton(
            onPressed: () => context.push('/grievance/new'),
            icon: Icons.support_agent,
            label: 'Get Help Applying From INC Coordinator',
            variant: NeoButtonVariant.saffron,
            isFullWidth: true,
          ),
        ],
      ),
    );
  }
}

