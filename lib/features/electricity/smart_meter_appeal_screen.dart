import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/action_utils.dart';
import '../../core/api_client.dart';
import '../../core/theme/app_theme.dart';
import '../../data/org/jk_geo_master.dart';

class SmartMeterAppealScreen extends StatefulWidget {
  const SmartMeterAppealScreen({super.key});

  @override
  State<SmartMeterAppealScreen> createState() => _SmartMeterAppealScreenState();
}

class _SmartMeterAppealScreenState extends State<SmartMeterAppealScreen> {
  final _consumerNoCtrl = TextEditingController();
  final _consumerNameCtrl = TextEditingController();
  final _unitsCtrl = TextEditingController();
  final _billedAmountCtrl = TextEditingController();
  String _selectedDistrict = 'Srinagar';
  final String _connectionType = 'Domestic (Metered)';
  String? _appealText;
  bool _disputeSynced = false;

  @override
  void dispose() {
    _consumerNoCtrl.dispose();
    _consumerNameCtrl.dispose();
    _unitsCtrl.dispose();
    _billedAmountCtrl.dispose();
    super.dispose();
  }

  void _generateAppeal() {
    final name = _consumerNameCtrl.text.trim();
    final consumerNo = _consumerNoCtrl.text.trim();
    final units = double.tryParse(_unitsCtrl.text.trim()) ?? 0;
    final billed = double.tryParse(_billedAmountCtrl.text.trim()) ?? 0;

    if (name.isEmpty || consumerNo.isEmpty || billed <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter consumer name, consumer ID, and billed amount.'),
          backgroundColor: Color(0xFFC62828),
        ),
      );
      return;
    }

    // Rough official approved domestic tariff calculation: ~₹2.80 - ₹3.80 per unit
    final estimatedFairBill = (units * 3.40) + 120; // unit rate + fixed electricity duty
    final excessAmount = (billed - estimatedFairBill).clamp(0, 999999);

    setState(() {
      _appealText = '''
To,
The Executive Engineer (Electric Division) /
Chairman, Consumer Grievance Redressal Forum (CGRF),
Joint Electricity Regulatory Commission (JERC),
District $_selectedDistrict, Jammu & Kashmir.

Subject: Formal Dispute & Statutory Appeal against Exorbitant & Inflated Smart Meter Electricity Bill.

Sir / Madam,
I, $name, am a registered domestic consumer under your division bearing:
- Consumer Account No: $consumerNo
- Installation Type: $_connectionType
- District: $_selectedDistrict, J&K

For the current billing cycle, I have been issued an exorbitant bill of ₹${billed.toStringAsFixed(0)} for $units units consumed. As per the approved tariff schedule of JERC for J&K, the estimated fair bill should not exceed ₹${estimatedFairBill.toStringAsFixed(0)}.

The current bill shows an arbitrary surcharge / unjustified inflated amount of approximately ₹${excessAmount.toStringAsFixed(0)}. 

Under Section 42(5) of the Electricity Act and JERC Consumer Protection Regulations:
1. Kindly put this disputed bill on hold and refrain from issuing disconnection notices.
2. Direct the technical squad to inspect and test the electronic smart meter accuracy in my presence.
3. Issue a revised, corrected electricity bill strictly adhering to actual energy consumption.

Applicant Consumer: $name
Consumer ID: $consumerNo
District: $_selectedDistrict, J&K
Date: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}

Copy to: Congress Public Electricity Redressal Cell for follow-up and representation.
''';
    });
  }

  void _submitDisputeToServer() async {
    final name = _consumerNameCtrl.text.trim();
    final consumerNo = _consumerNoCtrl.text.trim();
    final units = int.tryParse(_unitsCtrl.text.trim()) ?? 0;
    final charged = double.tryParse(_billedAmountCtrl.text.trim()) ?? 0.0;
    final fairTariff = units <= 200 ? units * 2.50 : (200 * 2.50) + ((units - 200) * 3.80);
    final excess = charged > fairTariff ? charged - fairTariff : 0.0;

    final data = {
      'consumerName': name,
      'consumerNo': consumerNo,
      'district': _selectedDistrict,
      'unitsBilled': units,
      'amountCharged': charged.round(),
      'legitimateTariff': fairTariff.round(),
      'discrepancy': excess.round(),
      'status': 'Representation Filed with Control Room',
    };

    final ok = await ApiClient.post('/api/smart-meters', data);
    if (ok && mounted) {
      setState(() => _disputeSynced = true);
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Dispute appeal logged with RGPRS Central Web Control Room!'),
          backgroundColor: AppColors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            DualPartyEmblem(size: 30),
            SizedBox(width: 10),
            Text('Smart Meter & Bill Appeal'),
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
            color: const Color(0xFFFFF3E0),
            borderColor: AppColors.saffronDeep.withValues(alpha: 0.4),
            child: const Row(
              children: [
                NeoIcon(
                  Icons.electric_meter,
                  color: AppColors.saffronDeep,
                  size: 46,
                ),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Inflated Electricity Bill Redressal',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFBF360C),
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Congress Public Cell helping citizens challenge arbitrary smart meter billing, false arrears, and unfair disconnection threats.',
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
                  'Enter Electricity Bill Details',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 14),
                NeoTextField(
                  controller: _consumerNameCtrl,
                  labelText: 'Consumer Name (on bill)',
                  hintText: 'e.g. Mohammad Shafi',
                  prefixIcon: Icons.person_outline,
                ),
                const SizedBox(height: 14),
                NeoTextField(
                  controller: _consumerNoCtrl,
                  labelText: 'Consumer ID / Account No.',
                  hintText: 'e.g. 0201010045672',
                  prefixIcon: Icons.badge_outlined,
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: NeoTextField(
                        controller: _unitsCtrl,
                        labelText: 'Units Consumed (KWh)',
                        hintText: 'e.g. 180',
                        keyboardType: TextInputType.number,
                        prefixIcon: Icons.speed,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: NeoTextField(
                        controller: _billedAmountCtrl,
                        labelText: 'Billed Amount (₹)',
                        hintText: 'e.g. 4850',
                        keyboardType: TextInputType.number,
                        prefixIcon: Icons.currency_rupee,
                      ),
                    ),
                  ],
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
                  onPressed: _generateAppeal,
                  icon: Icons.gavel,
                  label: 'Generate Legal Dispute Appeal',
                  variant: NeoButtonVariant.primary,
                  isFullWidth: true,
                ),
              ],
            ),
          ),
          if (_appealText != null) ...[
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
                        'Your Legal Appeal Dossier',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: AppColors.ink),
                      ),
                      NeoButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: _appealText!));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Appeal letter copied! Print or submit to Executive Engineer.')),
                          );
                        },
                        icon: Icons.copy,
                        label: 'Copy Appeal',
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
                      _appealText!,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: AppColors.ink,
                        height: 1.45,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: NeoButton(
                      onPressed: _disputeSynced ? null : _submitDisputeToServer,
                      icon: _disputeSynced ? Icons.cloud_done : Icons.cloud_upload_outlined,
                      label: _disputeSynced ? 'Logged with J&K Control Room' : 'Transmit Dispute to Control Room',
                      variant: _disputeSynced ? NeoButtonVariant.green : NeoButtonVariant.primary,
                      isFullWidth: true,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Escalate to INC Electricity Desk:',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.mutedInk),
                      ),
                      NeoButton(
                        onPressed: () => ActionUtils.launchPhoneCall(context, '0194-2452402'),
                        icon: Icons.phone,
                        label: '0194-2452402',
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
