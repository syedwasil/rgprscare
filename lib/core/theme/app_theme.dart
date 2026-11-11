import 'package:flutter/material.dart';

export 'neumorphic.dart';

/// Indian National Congress (INC) / RGPRS brand palette & Light Indian theme tokens.
class AppColors {
  AppColors._();

  // Official Indian National Congress & Tiranga Palette
  static const saffron = Color(0xFFFF9933);       // Official Tiranga Saffron (Kesariya)
  static const saffronDeep = Color(0xFFE65100);   // Deep Saffron for high-contrast text & borders
  static const saffronLight = Color(0xFFFFF3E0);  // Soft Saffron tint
  
  static const white = Color(0xFFFFFFFF);         // Pure Tiranga White
  
  static const green = Color(0xFF138808);         // Official Tiranga Green (Hara)
  static const greenDeep = Color(0xFF0F6806);     // Deep Green for high-contrast text
  static const greenLight = Color(0xFFE8F5E9);    // Soft Green tint
  
  static const partyBlue = Color(0xFF135A91);     // Indian National Congress Party Blue
  static const partyBlueDark = Color(0xFF0A3C66); // Deep INC Navy Blue
  static const partyBlueLight = Color(0xFFEAF2F9);// Soft INC Blue tint
  static const navy = Color(0xFF0B2D4F);          // Deep Flag Navy
  
  // Light Indian Neumorphic Base Canvas & Surfaces
  static const canvas = Color(0xFFEEF2F7);        // Optimal crisp Light Neumorphic Canvas
  static const surface = Color(0xFFEEF2F7);       // Base Neumorphic Surface
  static const surfaceElevated = Color(0xFFF5F8FC);// Raised high-light surface
  static const paper = Color(0xFFFAFBFD);         // Crisp warm paper tone
  
  // Slate ink for crisp readability
  static const ink = Color(0xFF182433);           // Dark Navy-Slate Ink
  static const mutedInk = Color(0xFF5D7186);      // Secondary Slate Ink
  
  // Shadows for the dual-light Neumorphic engine
  static const shadowLight = Color(0xFFFFFFFF);   // Top-left diffuse highlight
  static const shadowDark = Color(0x28768B9E);    // Bottom-right soft shadow
  static const shadowDarkStrong = Color(0x3B647A8F);
  
  // Indian Accent Tokens
  static const gold = Color(0xFFD49B00);          // Gold/Brass honors & verification
  static const outline = Color(0xFFB0C0D0);       // Outline border color
  static const nightCanvas = Color(0xFF131926);
}

class AppTheme {
  AppTheme._();

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isLight = brightness == Brightness.light;
    final canvas = isLight ? AppColors.canvas : AppColors.nightCanvas;
    final surface = isLight ? AppColors.surface : const Color(0xFF1C2436);

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: AppColors.partyBlue,
      onPrimary: Colors.white,
      primaryContainer: isLight ? AppColors.partyBlueLight : const Color(0xFF1B3B5C),
      onPrimaryContainer: isLight ? AppColors.partyBlueDark : const Color(0xFFD6E6F8),
      secondary: AppColors.saffronDeep,
      onSecondary: Colors.white,
      secondaryContainer: isLight ? AppColors.saffronLight : const Color(0xFF42240C),
      onSecondaryContainer: isLight ? AppColors.saffronDeep : const Color(0xFFFFD8B3),
      tertiary: AppColors.green,
      onTertiary: Colors.white,
      tertiaryContainer: isLight ? AppColors.greenLight : const Color(0xFF103612),
      onTertiaryContainer: isLight ? AppColors.greenDeep : const Color(0xFFC7F3C4),
      error: const Color(0xFFBA1A1A),
      onError: Colors.white,
      errorContainer: const Color(0xFFFFDAD6),
      onErrorContainer: const Color(0xFF410002),
      surface: surface,
      onSurface: isLight ? AppColors.ink : Colors.white,
      onSurfaceVariant: isLight ? AppColors.mutedInk : const Color(0xFFA5B4C4),
      outline: isLight ? const Color(0xFFB0C0D0) : const Color(0xFF4F5E72),
      outlineVariant: isLight ? const Color(0xFFD7E1EC) : const Color(0xFF2C394C),
      shadow: isLight ? AppColors.shadowDark : Colors.black,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: canvas,
      fontFamily: 'sans',
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: canvas,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: colorScheme.onSurface,
          letterSpacing: 0.2,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: canvas,
        indicatorColor: AppColors.partyBlueLight,
        elevation: 0,
        labelTextStyle: const WidgetStatePropertyAll(
          TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        shadowColor: isLight ? AppColors.shadowDark : Colors.black54,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      listTileTheme: const ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant.withValues(alpha: 0.6),
        space: 1,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: canvas,
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: canvas,
        modalBackgroundColor: canvas,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.saffron,
        foregroundColor: Colors.white,
        elevation: 6,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: canvas,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.partyBlue, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: canvas,
        selectedColor: AppColors.partyBlueLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
