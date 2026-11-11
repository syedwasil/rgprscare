import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import 'schemes_data.dart';

class SchemesScreen extends StatefulWidget {
  const SchemesScreen({super.key});

  @override
  State<SchemesScreen> createState() => _SchemesScreenState();
}

class _SchemesScreenState extends State<SchemesScreen> {
  final _searchController = TextEditingController();
  SchemeCategory? _selectedCategory;
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = allWelfareSchemes.where((scheme) {
      if (_selectedCategory != null && scheme.category != _selectedCategory) {
        return false;
      }
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        return scheme.title.toLowerCase().contains(q) ||
            scheme.urduTitle.toLowerCase().contains(q) ||
            scheme.hindiTitle.toLowerCase().contains(q) ||
            scheme.shortDescription.toLowerCase().contains(q) ||
            scheme.badge.toLowerCase().contains(q);
      }
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            DualPartyEmblem(size: 30),
            SizedBox(width: 10),
            Text('Mera Adhikar • Jan Kalyan Rights'),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: [
          // Banner
          NeoSurface(
            padding: const EdgeInsets.all(18),
            borderRadius: 22,
            child: Row(
              children: [
                const NeoIcon(
                  Icons.verified_user,
                  color: AppColors.saffronDeep,
                  size: 48,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Public Welfare & Entitlements',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: AppColors.ink,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Find which government schemes you are entitled to, documents required & how to apply.',
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
          const SizedBox(height: 14),
          // Search input
          NeoSurface(
            padding: EdgeInsets.zero,
            borderRadius: 16,
            isSunken: true,
            child: TextField(
              controller: _searchController,
              onChanged: (val) => setState(() => _searchQuery = val.trim()),
              decoration: InputDecoration(
                hintText: 'Search Golden card, pension, ladli beti, ration…',
                hintStyle: const TextStyle(color: AppColors.mutedInk, fontSize: 13),
                prefixIcon: const Icon(Icons.search, color: AppColors.partyBlue),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
          const SizedBox(height: 14),
          // Category filter pills
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                NeoFilterChip(
                  label: 'All Schemes',
                  selected: _selectedCategory == null,
                  onSelected: (_) => setState(() => _selectedCategory = null),
                ),
                const SizedBox(width: 8),
                NeoFilterChip(
                  label: 'Health (Golden Card)',
                  selected: _selectedCategory == SchemeCategory.health,
                  selectedColor: const Color(0xFF0077B6),
                  onSelected: (_) => setState(() => _selectedCategory = SchemeCategory.health),
                ),
                const SizedBox(width: 8),
                NeoFilterChip(
                  label: 'Pensions (ISSS)',
                  selected: _selectedCategory == SchemeCategory.pension,
                  selectedColor: AppColors.saffronDeep,
                  onSelected: (_) => setState(() => _selectedCategory = SchemeCategory.pension),
                ),
                const SizedBox(width: 8),
                NeoFilterChip(
                  label: 'Women & Daughters',
                  selected: _selectedCategory == SchemeCategory.womenChild,
                  selectedColor: const Color(0xFFC2185B),
                  onSelected: (_) => setState(() => _selectedCategory = SchemeCategory.womenChild),
                ),
                const SizedBox(width: 8),
                NeoFilterChip(
                  label: 'Farmers (PM-Kisan)',
                  selected: _selectedCategory == SchemeCategory.farmers,
                  selectedColor: AppColors.green,
                  onSelected: (_) => setState(() => _selectedCategory = SchemeCategory.farmers),
                ),
                const SizedBox(width: 8),
                NeoFilterChip(
                  label: 'Jobs & MGNREGA',
                  selected: _selectedCategory == SchemeCategory.employment,
                  selectedColor: const Color(0xFFE65100),
                  onSelected: (_) => setState(() => _selectedCategory = SchemeCategory.employment),
                ),
                const SizedBox(width: 8),
                NeoFilterChip(
                  label: 'Housing (PMAY)',
                  selected: _selectedCategory == SchemeCategory.housing,
                  selectedColor: const Color(0xFF5E35B1),
                  onSelected: (_) => setState(() => _selectedCategory = SchemeCategory.housing),
                ),
                const SizedBox(width: 8),
                NeoFilterChip(
                  label: 'Ration & Food (NFSA)',
                  selected: _selectedCategory == SchemeCategory.rationFood,
                  selectedColor: const Color(0xFF2E7D32),
                  onSelected: (_) => setState(() => _selectedCategory = SchemeCategory.rationFood),
                ),
                const SizedBox(width: 8),
                NeoFilterChip(
                  label: 'Tribal Rights (FRA)',
                  selected: _selectedCategory == SchemeCategory.tribalRights,
                  selectedColor: const Color(0xFF1B5E20),
                  onSelected: (_) => setState(() => _selectedCategory = SchemeCategory.tribalRights),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${filtered.length} CITIZEN SCHEMES',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: AppColors.mutedInk,
                  letterSpacing: 0.8,
                ),
              ),
              const Text(
                'Complete Document Guide',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.partyBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final scheme in filtered)
            _SchemeCard(scheme: scheme),
        ],
      ),
    );
  }
}

class _SchemeCard extends StatelessWidget {
  const _SchemeCard({required this.scheme});

  final WelfareScheme scheme;

  @override
  Widget build(BuildContext context) {
    final color = switch (scheme.category) {
      SchemeCategory.health => const Color(0xFF0077B6),
      SchemeCategory.pension => AppColors.saffronDeep,
      SchemeCategory.womenChild => const Color(0xFFC2185B),
      SchemeCategory.farmers => AppColors.green,
      SchemeCategory.employment => const Color(0xFFE65100),
      SchemeCategory.housing => const Color(0xFF5E35B1),
      SchemeCategory.rationFood => const Color(0xFF2E7D32),
      SchemeCategory.tribalRights => const Color(0xFF1B5E20),
    };

    return NeoCard(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      onTap: () => context.push('/schemes/${scheme.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NeoIcon(scheme.icon, color: color, size: 44),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            scheme.title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: AppColors.ink,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      scheme.urduTitle.isNotEmpty ? scheme.urduTitle : scheme.hindiTitle,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.partyBlue,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color.withValues(alpha: 0.3), width: 0.8),
                ),
                child: Text(
                  scheme.badge,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: color,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            scheme.shortDescription,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.ink,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.description_outlined, size: 14, color: AppColors.mutedInk),
                  const SizedBox(width: 4),
                  Text(
                    '${scheme.requiredDocuments.length} Documents Required',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.mutedInk,
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Text(
                    'Check Details',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppColors.partyBlue,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.partyBlue),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

