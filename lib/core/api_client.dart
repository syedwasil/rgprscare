import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Centralized Cross-Platform API Client for RGPRS & INC J&K Citizen Care.
///
/// Fully compatible with:
/// 1. Vercel Cloud Production Backend
/// 2. Windows Desktop (localhost:4040)
/// 3. Physical Android Device connected via USB / adb reverse (localhost:4040)
/// 4. Physical Android Device connected over Wi-Fi (192.168.29.167:4040)
/// 5. Android Emulator loopback (10.0.2.2:4040)
/// 6. Web Browser (current origin)
class ApiClient {
  const ApiClient._();

  static const List<String> serverHosts = [
    // 1. Syed Wasil's Live Vercel Production Cloud Server
    'https://rgprscare.vercel.app',
    'https://rgprs-inccare.vercel.app',
    'https://quick-celesta-pt7oe23.tmp.now',
    // 2. Windows Desktop & Android USB Port Reverse
    'http://localhost:4040',
    // 3. Local Wi-Fi Physical Device Network
    'http://192.168.29.167:4040',
    // 4. Android Emulator loopback
    'http://10.0.2.2:4040',
  ];

  static const Duration timeout = Duration(milliseconds: 2500);

  static List<String> get candidateHosts {
    if (kIsWeb) {
      final origin = Uri.base.origin;
      return [origin, ...serverHosts];
    }
    return serverHosts;
  }

  /// Posts JSON data to an API endpoint across candidate server hosts.
  static Future<bool> post(String endpoint, Map<String, dynamic> data) async {
    final payload = jsonEncode(data);
    final cleanPath = endpoint.startsWith('/') ? endpoint : '/$endpoint';

    for (final host in candidateHosts) {
      try {
        final uri = Uri.parse('$host$cleanPath');
        final res = await http.post(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: payload,
        ).timeout(timeout);
        if (res.statusCode >= 200 && res.statusCode < 300) {
          return true;
        }
      } catch (_) {}
    }
    return false;
  }

  /// Fetches JSON text from an API endpoint across candidate server hosts.
  static Future<String?> get(String endpoint) async {
    final cleanPath = endpoint.startsWith('/') ? endpoint : '/$endpoint';

    for (final host in candidateHosts) {
      try {
        final uri = Uri.parse('$host$cleanPath');
        final res = await http.get(uri).timeout(timeout);
        if (res.statusCode >= 200 && res.statusCode < 300) {
          return res.body;
        }
      } catch (_) {}
    }
    return null;
  }

  /// Pushes sync operations to /api/sync.
  static Future<int> pushSync(List<Map<String, dynamic>> ops) async {
    if (ops.isEmpty) return 0;
    final payload = jsonEncode({'ops': ops});

    for (final host in candidateHosts) {
      try {
        final uri = Uri.parse('$host/api/sync');
        final res = await http.post(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: payload,
        ).timeout(timeout);
        if (res.statusCode >= 200 && res.statusCode < 300) {
          final data = jsonDecode(res.body) as Map<String, dynamic>;
          return (data['accepted'] as int?) ?? ops.length;
        }
      } catch (_) {}
    }
    return 0;
  }
}
