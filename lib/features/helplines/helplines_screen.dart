import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/action_utils.dart';
import '../../core/theme/app_theme.dart';
import 'helplines_data.dart';

class HelplinesScreen extends StatefulWidget {
  const HelplinesScreen({super.key});

  @override
  State<HelplinesScreen> createState() => _HelplinesScreenState();
}

class _HelplinesScreenState extends State<HelplinesScreen> {
  final _searchController = TextEditingController();
  HelplineCategory? _selectedCategory;
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = allHelplines.where((item) {
      if (_selectedCategory != null && item.category != _selectedCategory) {
        return false;
      }
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        return item.title.toLowerCase().contains(q) ||
            item.subtitle.toLowerCase().contains(q) ||
            item.phone.contains(q) ||
            item.region.toLowerCase().contains(q);
      }
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            DualPartyEmblem(size: 30),
            SizedBox(width: 10),
            Text('24×7 Public Helplines'),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: [
          // Banner
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFF0F3E68), Color(0xFF0B2D4F)],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(-2, -2),
                  blurRadius: 5,
                ),
                BoxShadow(
                  color: Color(0x33135A91),
                  offset: Offset(3, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: const Row(
              children: [
                NeoIcon(
                  Icons.support_agent,
                  color: Colors.white,
                  size: 46,
                  backgroundColor: AppColors.saffronDeep,
                ),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Direct Citizen Emergency Hub',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Official breakdown control rooms, hospital emergency lines & party public desks across J&K.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
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
          // Search input
          NeoSurface(
            padding: EdgeInsets.zero,
            borderRadius: 16,
            isSunken: true,
            child: TextField(
              controller: _searchController,
              onChanged: (val) => setState(() => _searchQuery = val.trim()),
              decoration: InputDecoration(
                hintText: 'Search electricity, water, ambulance, highway…',
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
                  label: 'All Helplines',
                  selected: _selectedCategory == null,
                  onSelected: (_) => setState(() => _selectedCategory = null),
                ),
                const SizedBox(width: 8),
                NeoFilterChip(
                  label: 'Universal (112)',
                  selected: _selectedCategory == HelplineCategory.emergency,
                  selectedColor: const Color(0xFFD32F2F),
                  onSelected: (_) => setState(() => _selectedCategory = HelplineCategory.emergency),
                ),
                const SizedBox(width: 8),
                NeoFilterChip(
                  label: 'Electricity (PDD)',
                  selected: _selectedCategory == HelplineCategory.electricity,
                  selectedColor: AppColors.saffronDeep,
                  onSelected: (_) => setState(() => _selectedCategory = HelplineCategory.electricity),
                ),
                const SizedBox(width: 8),
                NeoFilterChip(
                  label: 'Water (Jal Shakti)',
                  selected: _selectedCategory == HelplineCategory.water,
                  selectedColor: const Color(0xFF0077B6),
                  onSelected: (_) => setState(() => _selectedCategory = HelplineCategory.water),
                ),
                const SizedBox(width: 8),
                NeoFilterChip(
                  label: 'Ambulance & SKIMS',
                  selected: _selectedCategory == HelplineCategory.health,
                  selectedColor: AppColors.green,
                  onSelected: (_) => setState(() => _selectedCategory = HelplineCategory.health),
                ),
                const SizedBox(width: 8),
                NeoFilterChip(
                  label: 'Highway & Disaster',
                  selected: _selectedCategory == HelplineCategory.disaster,
                  selectedColor: const Color(0xFFF57C00),
                  onSelected: (_) => setState(() => _selectedCategory = HelplineCategory.disaster),
                ),
                const SizedBox(width: 8),
                NeoFilterChip(
                  label: 'Women & Child (181)',
                  selected: _selectedCategory == HelplineCategory.womenChild,
                  selectedColor: const Color(0xFF7B1FA2),
                  onSelected: (_) => setState(() => _selectedCategory = HelplineCategory.womenChild),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Count header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${filtered.length} OFFICIAL HELPLINES',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: AppColors.mutedInk,
                  letterSpacing: 0.8,
                ),
              ),
              const Text(
                'Free Direct Calling',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.greenDeep,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (filtered.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: NeoCard(
                padding: const EdgeInsets.all(28),
                child: const Column(
                  children: [
                    Icon(Icons.search_off, size: 48, color: AppColors.mutedInk),
                    SizedBox(height: 12),
                    Text(
                      'No matching helplines found',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.ink),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Try searching for "112", "Electricity", "Water" or "Highway".',
                      style: TextStyle(fontSize: 12, color: AppColors.mutedInk),
                    ),
                  ],
                ),
              ),
            ),
          for (final contact in filtered)
            _HelplineCard(contact: contact),
        ],
      ),
    );
  }
}

class _HelplineCard extends StatelessWidget {
  const _HelplineCard({required this.contact});

  final HelplineContact contact;

  @override
  Widget build(BuildContext context) {
    final iconColor = switch (contact.category) {
      HelplineCategory.emergency => const Color(0xFFD32F2F),
      HelplineCategory.electricity => AppColors.saffronDeep,
      HelplineCategory.water => const Color(0xFF0077B6),
      HelplineCategory.health => AppColors.green,
      HelplineCategory.disaster => const Color(0xFFE65100),
      HelplineCategory.womenChild => const Color(0xFF7B1FA2),
      HelplineCategory.partyHelpDesk => AppColors.partyBlue,
    };

    return NeoCard(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NeoIcon(
                contact.icon,
                color: iconColor,
                size: 42,
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
                            contact.title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: AppColors.ink,
                            ),
                          ),
                        ),
                        if (contact.is24x7)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.greenLight,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              '24×7',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                color: AppColors.greenDeep,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      contact.subtitle,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.mutedInk,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.partyBlueLight,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            contact.region,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppColors.partyBlue,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        if (contact.isTollFree)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.saffronLight,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'TOLL-FREE',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                color: AppColors.saffronDeep,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 12),
          // Action row
          Row(
            children: [
              Expanded(
                child: NeoButton(
                  onPressed: () => _callNumber(context, contact.phone),
                  icon: Icons.phone_in_talk,
                  label: 'Call ${contact.phone}',
                  variant: NeoButtonVariant.green,
                ),
              ),
              const SizedBox(width: 10),
              NeoIconButton(
                icon: Icons.copy,
                size: 44,
                tooltip: 'Copy Number',
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: contact.phone));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${contact.title} number copied: ${contact.phone}'),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ],
          ),
          if (contact.alternatePhone != null) ...[
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _callNumber(context, contact.alternatePhone!),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.phone_forwarded, size: 14, color: AppColors.partyBlue),
                    const SizedBox(width: 6),
                    Text(
                      'Alt line: ${contact.alternatePhone}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.partyBlue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _callNumber(BuildContext context, String number) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.phone_in_talk, color: AppColors.green),
            const SizedBox(width: 10),
            const Text('Dial Helpline'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contact.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
            const SizedBox(height: 4),
            Text('Number: $number', style: const TextStyle(color: AppColors.partyBlue, fontWeight: FontWeight.w900, fontSize: 18)),
            const SizedBox(height: 10),
            const Text('This will place a direct phone call on your phone.', style: TextStyle(fontSize: 12, color: AppColors.mutedInk)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          NeoButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              ActionUtils.launchPhoneCall(context, number);
            },
            icon: Icons.call,
            label: 'Call Now',
            variant: NeoButtonVariant.green,
          ),
        ],
      ),
    );
  }
}

