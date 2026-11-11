import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/l10n/app_strings.dart';
import '../db/app_database.dart';

/// Local database handle. Created lazily and only when something actually
/// watches it — widget tests override [orgRepositoryProvider] instead, so no
/// native SQLite library is needed there.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

/// Set by `main()` before the first frame when the local database could not
/// be opened or seeded. The home screen renders it as a visible banner rather
/// than letting the app fail silently with an empty tree.
final startupErrorProvider =
    NotifierProvider<StartupErrorController, String?>(StartupErrorController.new);

class StartupErrorController extends Notifier<String?> {
  @override
  String? build() => null;

  void set(String message) => state = message;
}

/// Settings store. Overridden in `main()` once the async instance is ready
/// and in tests with mock values.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(
    'Override after SharedPreferences.getInstance() has resolved',
  ),
);

/// Active UI language.
///
/// Starts from the device language (an Urdu phone opens in Urdu), then takes
/// on whatever the user chose before — the choice is persisted, so a restart
/// never silently drops back to English.
final localeProvider =
    NotifierProvider<LocaleController, Locale>(LocaleController.new);

class LocaleController extends Notifier<Locale> {
  static const _prefsKey = 'locale';

  @override
  Locale build() {
    final platform = WidgetsBinding.instance.platformDispatcher.locale;
    return AppStrings.isSupported(platform.languageCode)
        ? Locale(platform.languageCode)
        : const Locale(AppStrings.fallbackLanguageCode);
  }

  /// Applies the stored choice at startup, once preferences are readable.
  void applyStored(String? code) {
    if (code == null || !AppStrings.isSupported(code)) return;
    state = Locale(code);
  }

  void setLanguage(String code) {
    if (!AppStrings.isSupported(code)) return;
    state = Locale(code);
    // Persisting is best-effort: losing the choice would only cost a switch,
    // so a storage failure must never break the screen.
    try {
      ref.read(sharedPreferencesProvider).setString(_prefsKey, code);
    } catch (_) {
      // Preferences unavailable (e.g. a test that did not mock them).
    }
  }
}
