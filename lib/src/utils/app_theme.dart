import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Application themes for light and dark mode utilizing [GoogleFonts]
/// and [FlexScheme]
class AppTheme {
  /// Returns light theme
  static ThemeData get flexThemeLight {
    var baseTheme = ThemeData(brightness: Brightness.light);
    return FlexThemeData.light(
      scheme: FlexScheme.blue,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 9,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
    ).copyWith(
        textTheme: _getTextTheme(baseTheme),
        appBarTheme: const AppBarTheme(
          toolbarHeight: 100,
          elevation: 0.0,
          centerTitle: true,
        ),
        dividerTheme: DividerThemeData(
          color: Colors.grey[400],
        ));
  }

  /// Returns dark theme
  static ThemeData get flexThemeDark {
    var baseTheme = ThemeData(brightness: Brightness.dark);
    return FlexThemeData.dark(
      scheme: FlexScheme.blue,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 15,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
    ).copyWith(
        textTheme: _getTextTheme(baseTheme),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 40.0),
          ),
        ),
        appBarTheme: const AppBarTheme(
          toolbarHeight: 100,
          elevation: 0.0,
          centerTitle: true,
        ),
        dividerTheme: DividerThemeData(
          color: Colors.grey[800],
        ));
  }

  /// Returns text theme for both light and dark mode
  /// @param baseTheme theme on which to create [TextTheme]
  static TextTheme _getTextTheme(ThemeData baseTheme) {
    return GoogleFonts.leagueSpartanTextTheme(
      (baseTheme.textTheme).copyWith(
        bodyLarge: GoogleFonts.roboto(textStyle: baseTheme.textTheme.bodyLarge),
        bodyMedium:
            GoogleFonts.roboto(textStyle: baseTheme.textTheme.bodyMedium),
        bodySmall: GoogleFonts.roboto(textStyle: baseTheme.textTheme.bodySmall),
        labelLarge: GoogleFonts.roboto(
            textStyle: baseTheme.textTheme.labelLarge
                ?.copyWith(fontWeight: FontWeight.w300)),
        labelMedium:
            GoogleFonts.roboto(textStyle: baseTheme.textTheme.labelMedium),
        labelSmall:
            GoogleFonts.roboto(textStyle: baseTheme.textTheme.labelSmall),
        headlineLarge: GoogleFonts.leagueSpartan(
          textStyle: baseTheme.textTheme.headlineLarge!
              .copyWith(fontWeight: FontWeight.w600, letterSpacing: -0.5),
        ),
        headlineMedium: GoogleFonts.leagueSpartan(
          textStyle: baseTheme.textTheme.headlineMedium!
              .copyWith(fontWeight: FontWeight.w600, letterSpacing: -0.5),
        ),
        headlineSmall: GoogleFonts.leagueSpartan(
          textStyle: baseTheme.textTheme.headlineSmall!
              .copyWith(fontWeight: FontWeight.w600, letterSpacing: -0.5),
        ),
        titleSmall: GoogleFonts.leagueSpartan(
          textStyle: baseTheme.textTheme.titleSmall!
              .copyWith(fontWeight: FontWeight.w600, letterSpacing: -0.5),
        ),
        titleMedium: GoogleFonts.leagueSpartan(
          textStyle: baseTheme.textTheme.titleMedium!
              .copyWith(fontWeight: FontWeight.w600, letterSpacing: -0.5),
        ),
        titleLarge: GoogleFonts.leagueSpartan(
          textStyle: baseTheme.textTheme.titleLarge!
              .copyWith(fontWeight: FontWeight.w600, letterSpacing: -0.5),
        ),
        displayLarge: GoogleFonts.leagueSpartan(
          textStyle: baseTheme.textTheme.displayLarge!
              .copyWith(fontWeight: FontWeight.w600, letterSpacing: -2.5),
        ),
        displayMedium: GoogleFonts.leagueSpartan(
          textStyle: baseTheme.textTheme.displayMedium!
              .copyWith(fontWeight: FontWeight.w600, letterSpacing: -2.5),
        ),
        displaySmall: GoogleFonts.leagueSpartan(
          textStyle: baseTheme.textTheme.displaySmall!
              .copyWith(fontWeight: FontWeight.w600, letterSpacing: -2.5),
        ),
      ),
    );
  }
}
