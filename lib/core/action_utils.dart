import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'theme/app_theme.dart';

/// Central actionable utilities for dialing phones, WhatsApp chats, emails,
/// and external portals. Replaces static copy-paste with direct device actions.
class ActionUtils {
  ActionUtils._();

  /// Direct phone dialer. Cleans number and triggers the system phone app.
  /// Falls back to clipboard if dialer is unavailable (e.g. tablet without cell).
  static Future<void> launchPhoneCall(BuildContext context, String rawPhone) async {
    final cleanPhone = rawPhone.replaceAll(RegExp(r'[^\d+]'), '');
    if (cleanPhone.isEmpty) return;

    final uri = Uri.parse('tel:$cleanPhone');
    try {
      final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched && context.mounted) {
        _fallbackClipboard(context, rawPhone, 'Dialing');
      }
    } catch (_) {
      if (context.mounted) {
        _fallbackClipboard(context, rawPhone, 'Dialing');
      }
    }
  }

  /// Direct WhatsApp chat. Formats 10-digit Indian numbers with +91 country code.
  static Future<void> launchWhatsApp(
    BuildContext context,
    String rawPhone, {
    String? message,
  }) async {
    var digits = rawPhone.replaceAll(RegExp(r'\D'), '');
    if (digits.length == 10) {
      digits = '91$digits';
    } else if (digits.startsWith('0') && digits.length == 11) {
      digits = '91${digits.substring(1)}';
    }

    final query = message != null && message.isNotEmpty
        ? '?text=${Uri.encodeComponent(message)}'
        : '';
    final uri = Uri.parse('https://wa.me/$digits$query');

    try {
      final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched && context.mounted) {
        _fallbackClipboard(context, rawPhone, 'WhatsApp');
      }
    } catch (_) {
      if (context.mounted) {
        _fallbackClipboard(context, rawPhone, 'WhatsApp');
      }
    }
  }

  /// Direct email launcher.
  static Future<void> launchEmail(
    BuildContext context,
    String email, {
    String? subject,
    String? body,
  }) async {
    final params = <String, String>{};
    if (subject != null) params['subject'] = subject;
    if (body != null) params['body'] = body;

    final uri = Uri(
      scheme: 'mailto',
      path: email.trim(),
      queryParameters: params.isNotEmpty ? params : null,
    );

    try {
      final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched && context.mounted) {
        _fallbackClipboard(context, email, 'Email');
      }
    } catch (_) {
      if (context.mounted) {
        _fallbackClipboard(context, email, 'Email');
      }
    }
  }

  /// Direct browser / external link launcher.
  static Future<void> launchWeb(BuildContext context, String url) async {
    var validUrl = url.trim();
    if (!validUrl.startsWith('http://') && !validUrl.startsWith('https://')) {
      validUrl = 'https://$validUrl';
    }
    final uri = Uri.parse(validUrl);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      if (context.mounted) {
        _fallbackClipboard(context, url, 'Link');
      }
    }
  }

  static void _fallbackClipboard(BuildContext context, String text, String action) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.partyBlue,
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '$action: $text (Copied to clipboard)',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

