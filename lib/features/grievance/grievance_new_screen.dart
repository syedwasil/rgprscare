import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../core/action_utils.dart';
import '../../core/api_client.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../data/grievance/grievance_data.dart';
import '../../data/org/jk_geo_master.dart';
import '../../data/org/org_models.dart';
import '../../data/org/org_repository.dart';
import '../../data/sync/sync_data.dart';
import '../shared/picker_sheet.dart';
import 'grievance_widgets.dart';

/// Jan Sunwai form: what happened, where, and who it is about.
/// Features Real Voice Note audio recording and Real Photo Proof attachment!
class GrievanceNewScreen extends ConsumerStatefulWidget {
  const GrievanceNewScreen({super.key});

  @override
  ConsumerState<GrievanceNewScreen> createState() => _GrievanceNewScreenState();
}

class _GrievanceNewScreenState extends ConsumerState<GrievanceNewScreen> {
  final _formKey = GlobalKey<FormState>();

  final _title = TextEditingController();
  final _description = TextEditingController();
  final _reporterName = TextEditingController();
  final _reporterPhone = TextEditingController();
  final _tehsilVillage = TextEditingController();

  GrievanceCategory _category = GrievanceCategory.water;
  OrgUnit? _area;
  bool _submitting = false;

  // Real voice recording state
  late final AudioRecorder _audioRecorder;
  Timer? _recordTimer;
  bool _isRecording = false;
  bool _hasVoiceNote = false;
  int _voiceSeconds = 0;
  String? _recordedAudioPath;

  // Real photo attachment state
  final ImagePicker _picker = ImagePicker();
  final List<String> _attachedPhotos = [];

  @override
  void initState() {
    super.initState();
    _audioRecorder = AudioRecorder();
  }

  @override
  void dispose() {
    _recordTimer?.cancel();
    _audioRecorder.dispose();
    _title.dispose();
    _description.dispose();
    _reporterName.dispose();
    _reporterPhone.dispose();
    _tehsilVillage.dispose();
    super.dispose();
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      await _stopRecording();
    } else {
      await _startRecording();
    }
  }

  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final dir = await getApplicationDocumentsDirectory();
        final path = '${dir.path}/voice_complaint_${DateTime.now().millisecondsSinceEpoch}.m4a';

        await _audioRecorder.start(
          const RecordConfig(encoder: AudioEncoder.aacLc),
          path: path,
        );

        setState(() {
          _isRecording = true;
          _hasVoiceNote = false;
          _voiceSeconds = 0;
          _recordedAudioPath = path;
        });

        _recordTimer?.cancel();
        _recordTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (!mounted) return;
          setState(() {
            _voiceSeconds++;
          });
        });
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Microphone permission required to record voice complaint.')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not start recording: $e')),
      );
    }
  }

  Future<void> _stopRecording() async {
    _recordTimer?.cancel();
    try {
      final path = await _audioRecorder.stop();
      setState(() {
        _isRecording = false;
        _hasVoiceNote = true;
        _recordedAudioPath = path ?? _recordedAudioPath;
        if (_description.text.trim().isEmpty) {
          _description.text = '[Voice Complaint Recorded: 0:${_voiceSeconds.toString().padLeft(2, '0')}]';
        }
      });
    } catch (_) {
      setState(() => _isRecording = false);
    }
  }

  void _deleteRecording() {
    _recordTimer?.cancel();
    if (_recordedAudioPath != null) {
      try {
        final f = File(_recordedAudioPath!);
        if (f.existsSync()) f.deleteSync();
      } catch (_) {}
    }
    setState(() {
      _isRecording = false;
      _hasVoiceNote = false;
      _voiceSeconds = 0;
      _recordedAudioPath = null;
    });
  }

  Future<void> _pickPhoto(ImageSource source) async {
    if (_attachedPhotos.length >= 3) return;
    try {
      final XFile? file = await _picker.pickImage(
        source: source,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );
      if (file != null && mounted) {
        setState(() {
          _attachedPhotos.add(file.path);
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not attach photo: $e')),
      );
    }
  }

  void _showPhotoOptions() {
    if (_attachedPhotos.length >= 3) return;
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Attach Photo Evidence (تصویر منسلک کریں)',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: AppColors.partyBlue),
                title: const Text('Take Photo with Camera', style: TextStyle(fontWeight: FontWeight.w700)),
                onTap: () {
                  Navigator.of(ctx).pop();
                  _pickPhoto(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: AppColors.green),
                title: const Text('Choose from Gallery', style: TextStyle(fontWeight: FontWeight.w700)),
                onTap: () {
                  Navigator.of(ctx).pop();
                  _pickPhoto(ImageSource.gallery);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final districts = ref.watch(districtsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          s.newGrievance,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 36),
          children: [
            // Instructions banner
            NeoSurface(
              padding: const EdgeInsets.all(16),
              borderRadius: 18,
              child: Row(
                children: [
                  const NeoIcon(
                    Icons.how_to_reg,
                    color: AppColors.partyBlue,
                    size: 40,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Panchayat Jan Sunwai • J&K Congress',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: AppColors.ink,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Submit with voice note, text, or photos. Track progress with guaranteed SLA resolution.',
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
            // Real Voice Complaint Banner
            NeoSurface(
              padding: const EdgeInsets.all(16),
              borderRadius: 18,
              color: _isRecording
                  ? const Color(0xFFFFEBEE)
                  : (_hasVoiceNote ? AppColors.greenLight : null),
              borderColor: _isRecording
                  ? const Color(0xFFD32F2F)
                  : (_hasVoiceNote ? AppColors.green : null),
              onTap: _toggleRecording,
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isRecording
                          ? const Color(0xFFD32F2F)
                          : (_hasVoiceNote ? AppColors.green : AppColors.saffronDeep),
                      boxShadow: [
                        BoxShadow(
                          color: (_isRecording ? const Color(0xFFD32F2F) : AppColors.saffronDeep)
                              .withValues(alpha: 0.35),
                          offset: const Offset(2, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Icon(
                      _isRecording ? Icons.stop : (_hasVoiceNote ? Icons.mic_external_on : Icons.mic),
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isRecording
                              ? 'Recording… 0:${_voiceSeconds.toString().padLeft(2, '0')} (Tap to Stop)'
                              : (_hasVoiceNote
                                  ? 'Voice Recorded (0:${_voiceSeconds.toString().padLeft(2, '0')})'
                                  : 'Record Voice Complaint (آواز ریکارڈ کریں)'),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: _isRecording
                                ? const Color(0xFFD32F2F)
                                : (_hasVoiceNote ? AppColors.greenDeep : AppColors.ink),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _isRecording
                              ? 'Live recording in progress. Speak clearly…'
                              : (_hasVoiceNote
                                  ? 'Real voice note attached to dossier'
                                  : 'Can\'t type? Speak your issue in your mother tongue.'),
                          style: const TextStyle(fontSize: 11, color: AppColors.mutedInk),
                        ),
                      ],
                    ),
                  ),
                  if (_hasVoiceNote)
                    IconButton(
                      icon: const Icon(Icons.delete_outline, size: 22, color: Colors.red),
                      tooltip: 'Delete recording',
                      onPressed: _deleteRecording,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            NeoTextField(
              controller: _title,
              labelText: s.grievanceTitle,
              hintText: 'e.g. Broken transformer in Ward 3 / Dry drinking tap',
              prefixIcon: Icons.edit_note,
              textCapitalization: TextCapitalization.sentences,
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? s.titleRequired
                  : null,
            ),
            const SizedBox(height: 16),
            NeoTextField(
              controller: _description,
              labelText: s.grievanceDescription,
              hintText: s.descriptionRequired,
              prefixIcon: Icons.description_outlined,
              minLines: 3,
              maxLines: 6,
              textCapitalization: TextCapitalization.sentences,
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? s.descriptionRequired
                  : null,
            ),
            const SizedBox(height: 16),
            // Real Photo Attachment Section
            NeoCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.camera_alt_outlined, size: 18, color: AppColors.partyBlue),
                          SizedBox(width: 8),
                          Text(
                            'Photo Evidence (تصویر منسلک کریں)',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.ink),
                          ),
                        ],
                      ),
                      Text(
                        '${_attachedPhotos.length}/3 Added',
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.mutedInk),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (_attachedPhotos.isNotEmpty) ...[
                    for (int i = 0; i < _attachedPhotos.length; i++)
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.canvas,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.outline, width: 0.8),
                        ),
                        child: Row(
                          children: [
                            if (File(_attachedPhotos[i]).existsSync())
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(_attachedPhotos[i]),
                                  width: 42,
                                  height: 42,
                                  fit: BoxFit.cover,
                                ),
                              )
                            else
                              const Icon(Icons.photo_outlined, size: 24, color: AppColors.partyBlue),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                _attachedPhotos[i].split(Platform.pathSeparator).last,
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.ink),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, size: 18, color: Colors.red),
                              onPressed: () => setState(() => _attachedPhotos.removeAt(i)),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 6),
                  ],
                  if (_attachedPhotos.length < 3)
                    NeoButton(
                      onPressed: _showPhotoOptions,
                      icon: Icons.add_a_photo_outlined,
                      label: 'Attach Photo (Camera / Gallery)',
                      variant: NeoButtonVariant.surface,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Category selector card
            NeoCard(
              padding: const EdgeInsets.all(14),
              onTap: () async {
                final chosen = await showOptionsSheet<GrievanceCategory>(
                  context: context,
                  title: s.category,
                  options: GrievanceCategory.values,
                  selected: _category,
                  label: (category) => categoryLabel(context, category),
                );
                if (chosen != null) setState(() => _category = chosen);
              },
              child: Row(
                children: [
                  const NeoIcon(
                    Icons.category_outlined,
                    color: AppColors.saffronDeep,
                    size: 38,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.category,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.mutedInk,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          categoryLabel(context, _category),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppColors.ink,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, color: AppColors.partyBlue),
                ],
              ),
            ),
            const SizedBox(height: 14),
            // Mandatory District Selector for J&K (All 20 Districts)
            NeoCard(
              padding: const EdgeInsets.all(14),
              onTap: () async {
                final availableUnits = (districts.value?.isNotEmpty ?? false)
                    ? districts.value!
                    : jkAllDistricts;
                final chosen = await showOptionsSheet<OrgUnit>(
                  context: context,
                  title: 'Select J&K District (ضلع منتخب کریں)',
                  options: availableUnits,
                  selected: _area,
                  label: (unit) {
                    final sec = (unit.nameUr?.isNotEmpty ?? false)
                        ? unit.nameUr!
                        : (unit.nameHi ?? '');
                    return sec.isNotEmpty ? '${unit.nameEn} ($sec)' : unit.nameEn;
                  },
                );
                if (chosen != null) setState(() => _area = chosen);
              },
              child: Row(
                children: [
                  const NeoIcon(
                    Icons.location_city,
                    color: AppColors.partyBlue,
                    size: 38,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select District (ضلع)',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.mutedInk,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _area?.localizedName(s) ?? 'Select District in J&K (ضلع)',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: _area == null
                                ? const Color(0xFFC62828)
                                : AppColors.ink,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, color: AppColors.partyBlue),
                ],
              ),
            ),
            const SizedBox(height: 14),
            // Tehsil & Village input
            NeoTextField(
              controller: _tehsilVillage,
              labelText: 'Tehsil / Block / Halqa Village',
              hintText: 'e.g. Tehsil Bijbehara, Halqa Waghama, Ward 3',
              prefixIcon: Icons.holiday_village_outlined,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 20),
            // Citizen contact details
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                'YOUR DETAILS (آپ کے کوائف)',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: AppColors.mutedInk,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const SizedBox(height: 10),
            NeoTextField(
              controller: _reporterName,
              labelText: s.fullName,
              hintText: 'Your Full Name (اختیاری)',
              prefixIcon: Icons.person_outline,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 14),
            NeoTextField(
              controller: _reporterPhone,
              labelText: s.phone,
              hintText: '10-digit mobile number for status SMS',
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 26),
            // Submit button
            NeoButton(
              onPressed: _submitting ? null : _submit,
              isFullWidth: true,
              icon: Icons.send_rounded,
              label: _submitting ? 'Submitting…' : s.submit,
              variant: NeoButtonVariant.primary,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (_area == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your District in J&K to assign your complaint.'),
          backgroundColor: Color(0xFFC62828),
        ),
      );
      return;
    }

    setState(() => _submitting = true);
    final repository = ref.read(grievanceRepositoryProvider);

    final locality = _tehsilVillage.text.trim();
    var combinedDescription = _description.text.trim();
    if (locality.isNotEmpty) {
      combinedDescription += '\n\n📍 Location: $locality, ${_area!.nameEn} District';
    }
    if (_hasVoiceNote && _recordedAudioPath != null) {
      combinedDescription += '\n🎙️ Voice Note: Attached (0:${_voiceSeconds.toString().padLeft(2, '0')}) [${_recordedAudioPath!.split(Platform.pathSeparator).last}]';
    }
    if (_attachedPhotos.isNotEmpty) {
      combinedDescription += '\n📸 Photos Attached (${_attachedPhotos.length}): ${_attachedPhotos.map((p) => p.split(Platform.pathSeparator).last).join(', ')}';
    }

    final created = await repository.create(
      title: _title.text.trim(),
      description: combinedDescription,
      category: _category,
      unitId: _area?.id,
      reporterName: _reporterName.text.trim().isEmpty
          ? null
          : _reporterName.text.trim(),
      reporterPhone: _reporterPhone.text.trim().isEmpty
          ? null
          : _reporterPhone.text.trim(),
    );

    // Prepare Base64 encoding of photos and voice note for real transmission to Control Room & Admin Portal
    List<String> photoBase64List = [];
    for (final p in _attachedPhotos) {
      try {
        final f = File(p);
        if (f.existsSync()) {
          final bytes = await f.readAsBytes();
          // Compress or format as base64 data URI
          final b64 = base64Encode(bytes);
          photoBase64List.add('data:image/jpeg;base64,$b64');
        }
      } catch (_) {}
    }

    String? voiceBase64;
    if (_hasVoiceNote && _recordedAudioPath != null) {
      try {
        final vFile = File(_recordedAudioPath!);
        if (vFile.existsSync()) {
          final vBytes = await vFile.readAsBytes();
          voiceBase64 = 'data:audio/m4a;base64,${base64Encode(vBytes)}';
        }
      } catch (_) {}
    }

    // Direct live broadcast to RGPRS Central Control Room across candidates
    ApiClient.post('/api/grievances', {
      'id': created.refCode,
      'title': _title.text.trim(),
      'description': combinedDescription,
      'category': _category.name.substring(0, 1).toUpperCase() + _category.name.substring(1),
      'district': _area?.nameEn ?? 'Srinagar',
      'tehsil': locality,
      'citizenName': _reporterName.text.trim().isEmpty ? 'Citizen' : _reporterName.text.trim(),
      'citizenPhone': _reporterPhone.text.trim().isEmpty ? 'Anonymous' : _reporterPhone.text.trim(),
      'hasVoice': _hasVoiceNote,
      'voiceSnippet': _hasVoiceNote ? 'Voice Statement Attached (0:${_voiceSeconds.toString().padLeft(2, '0')})' : '',
      'voiceBase64': voiceBase64 ?? '',
      'hasPhoto': _attachedPhotos.isNotEmpty,
      'photoBase64': photoBase64List.isNotEmpty ? photoBase64List.first : '',
      'photos': photoBase64List,
      'slaHoursLeft': 72,
      'status': 'Pending',
      'assignedLeader': 'Unassigned',
      'notes': 'Synced live from RGPRS J&K Mobile App',
      'submittedAt': DateTime.now().toIso8601String(),
    });

    if (!mounted) return;
    ref.invalidate(grievanceListProvider);

    // Also trigger outbox drain in background
    ref.read(syncEngineProvider).drainOnce().then((_) {
      ref.invalidate(pendingSyncCountProvider);
    }).catchError((_) {});

    // Show Complaint Acknowledgement Receipt Slip modal
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            CongressEmblem(size: 32, showShadow: false),
            SizedBox(width: 10),
            Text('Grievance Receipt Slip', style: TextStyle(fontWeight: FontWeight.w900)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Complaint Registered Successfully!',
              style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.greenDeep),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.partyBlue.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ref Code: ${created.refCode}', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: AppColors.partyBlue)),
                  const SizedBox(height: 4),
                  Text('District: ${_area?.nameEn ?? "J&K"}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                  Text('Issue: ${created.title}', style: const TextStyle(fontSize: 12)),
                  Text('Resolution SLA: 72 Hours', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.saffronDeep)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (_hasVoiceNote || _attachedPhotos.isNotEmpty) ...[
              Text(
                'Attachments: ${_hasVoiceNote ? "🎙️ Audio Statement " : ""}${_attachedPhotos.isNotEmpty ? "📸 ${_attachedPhotos.length} Photos" : ""}',
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.greenDeep),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final receipt = 'RGPRS INC Jan Sunwai Slip\nRef: ${created.refCode}\nIssue: ${created.title}\nDate: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
              ActionUtils.launchWhatsApp(context, '', message: receipt);
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.share, size: 16),
                SizedBox(width: 4),
                Text('Share Receipt'),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.partyBlue,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              context.pop();
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}
