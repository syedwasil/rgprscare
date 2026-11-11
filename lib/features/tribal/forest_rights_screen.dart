import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/action_utils.dart';
import '../../core/api_client.dart';
import '../../core/theme/app_theme.dart';
import '../../data/org/jk_geo_master.dart';

class ForestRightsScreen extends StatefulWidget {
  const ForestRightsScreen({super.key});

  @override
  State<ForestRightsScreen> createState() => _ForestRightsScreenState();
}

class _ForestRightsScreenState extends State<ForestRightsScreen> {
  final _claimantNameCtrl = TextEditingController();
  final _tribalClanCtrl = TextEditingController();
  final _forestRangeCtrl = TextEditingController();
  final _noticeNoCtrl = TextEditingController();
  String _selectedDistrict = 'Rajouri';
  String? _legalResponseText;

  @override
  void dispose() {
    _claimantNameCtrl.dispose();
    _tribalClanCtrl.dispose();
    _forestRangeCtrl.dispose();
    _noticeNoCtrl.dispose();
    super.dispose();
  }

  void _generateLegalReply() {
    final name = _claimantNameCtrl.text.trim();
    final clan = _tribalClanCtrl.text.trim();
    final range = _forestRangeCtrl.text.trim();
    final notice = _noticeNoCtrl.text.trim();

    if (name.isEmpty || range.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter claimant name and forest beat/range.'),
          backgroundColor: Color(0xFFC62828),
        ),
      );
      return;
    }

    ApiClient.post('/api/forest-rights', {
      'claimant': name,
      'clan': clan.isNotEmpty ? clan : 'Gujjar / Bakerwal',
      'district': _selectedDistrict,
      'forestRange': range,
      'kothaLocation': notice.isNotEmpty ? 'Notice: $notice' : 'Ancestral Kotha / Dhok',
      'status': 'Statutory Stay Invoked (Sec 4(5))',
      'filedAt': DateTime.now().toIso8601String(),
    }).catchError((_) => false);

    setState(() {
      _legalResponseText = '''
To,
The Divisional Forest Officer (DFO) / Range Officer,
Forest Division: $range,
District $_selectedDistrict, Jammu & Kashmir.

Subject: Formal Legal Objection & Stay Request under Section 4(5) of the Scheduled Tribes and Other Traditional Forest Dwellers (Recognition of Forest Rights) Act, 2006 against Eviction / Demolition Notice: $notice.

Sir / Madam,
I, $name, belonging to the traditional ${clan.isNotEmpty ? clan : 'Gujjar/Bakerwal ST'} community, am a customary forest dweller in Compartment / Range: $range, District $_selectedDistrict.

I have been served with the above-referenced eviction notice / demolition threat. I submit this formal statutory objection:

1. Under Section 4(5) of the Central Forest Rights Act (FRA), 2006 (enacted by the Parliament of India):
   "No member of a forest dwelling Scheduled Tribe or other traditional forest dweller shall be evicted or removed from forest land under his occupation till the recognition and verification procedure is complete."

2. My claim dossier for Individual Forest Land Rights / Customary Community Grazing (Dhar / Marg) is pending determination before the Village Forest Rights Committee (FRC) and Sub-Divisional Level Committee (SDLC).

3. Any eviction, fencing, demolition of Kotha/Dhok, or seizure of livestock prior to final adjudication by the District Level Committee is strictly ILLEGAL, contemptuous of Supreme Court directives, and liable for criminal prosecution under the SC/ST (Prevention of Atrocities) Act.

Therefore, you are hereby requested to immediately STAY and cancel all eviction proceedings.

Claimant Name: $name
Community: ${clan.isNotEmpty ? clan : 'Gujjar / Bakerwal'}
Forest Range: $range, District $_selectedDistrict, J&K
Date: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}

Copy to: Congress Tribal Rights & Legal Cell, Srinagar/Jammu for urgent representation before the Deputy Commissioner.
''';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            DualPartyEmblem(size: 30),
            SizedBox(width: 10),
            Text('Forest Rights & Tribal Defense'),
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
            color: const Color(0xFFF1F8E9),
            borderColor: AppColors.green.withValues(alpha: 0.4),
            child: const Row(
              children: [
                NeoIcon(
                  Icons.forest,
                  color: AppColors.green,
                  size: 46,
                ),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gujjar & Bakerwal Land Defense',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1B5E20),
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Enforcing the historic Congress Forest Rights Act (FRA 2006). Stop illegal evictions from your traditional Kothas, pastures, and ancestral land.',
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
          NeoCard(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Forest Notice / Eviction Details',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 14),
                NeoTextField(
                  controller: _claimantNameCtrl,
                  labelText: 'Claimant Name',
                  hintText: 'e.g. Choudhary Bashir Ahmad',
                  prefixIcon: Icons.person_outline,
                ),
                const SizedBox(height: 14),
                NeoTextField(
                  controller: _tribalClanCtrl,
                  labelText: 'Community / Clan / Tribe',
                  hintText: 'e.g. Gujjar, Bakerwal, Gaddi, Chopan',
                  prefixIcon: Icons.groups_outlined,
                ),
                const SizedBox(height: 14),
                NeoTextField(
                  controller: _forestRangeCtrl,
                  labelText: 'Forest Range, Block & Compartment No.',
                  hintText: 'e.g. Range Surankote / Compartment 42',
                  prefixIcon: Icons.terrain_outlined,
                ),
                const SizedBox(height: 14),
                NeoTextField(
                  controller: _noticeNoCtrl,
                  labelText: 'Notice / Threat Reference (if any)',
                  hintText: 'e.g. Notice No. DFO/2026/89 or Verbal Eviction',
                  prefixIcon: Icons.description_outlined,
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
                  onPressed: _generateLegalReply,
                  icon: Icons.shield_outlined,
                  label: 'Generate Statutory Stay Objection (FRA 2006)',
                  variant: NeoButtonVariant.primary,
                  isFullWidth: true,
                ),
              ],
            ),
          ),
          if (_legalResponseText != null) ...[
            const SizedBox(height: 18),
            NeoCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Legal Reply Dossier (FRA Sec 4(5))',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: AppColors.ink),
                      ),
                      NeoButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: _legalResponseText!));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Legal reply copied! Submit to DFO / DC office immediately.')),
                          );
                        },
                        icon: Icons.copy,
                        label: 'Copy Reply',
                        variant: NeoButtonVariant.saffron,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  NeoSurface(
                    padding: const EdgeInsets.all(14),
                    borderRadius: 14,
                    isSunken: true,
                    child: Text(
                      _legalResponseText!,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: AppColors.ink,
                        height: 1.45,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'INC Tribal Rights Free Advocate:',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.mutedInk),
                      ),
                      NeoButton(
                        onPressed: () => ActionUtils.launchPhoneCall(context, '0191-2578085'),
                        icon: Icons.phone,
                        label: '0191-2578085',
                        variant: NeoButtonVariant.surface,
                      ),
                    ],
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

