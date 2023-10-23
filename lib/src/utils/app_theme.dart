import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeUtils {
  static ThemeData getBaseTheme(Brightness brightness) {
    return ThemeData(brightness: brightness);
  }

  static ThemeData get lightFlexTheme {
    var baseTheme = ThemeData(brightness: Brightness.light);
    return FlexThemeData.light(
      colors: const FlexSchemeColor(
        primary: Color(0xff2583ff),
        primaryContainer: Color(0xffa6cced),
        secondary: Color(0xffe47642),
        secondaryContainer: Color(0xfff0b395),
        tertiary: Color(0xff7cc8f8),
        tertiaryContainer: Color(0xffc5e7ff),
        appBarColor: Color(0xff2583ff),
        //Color(0xfff0b395),
        error: Color(0xffb00020),
      ),
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        useTextTheme: true,
        useM2StyleDividerInM3: true,
        //adaptiveAppBarScrollUnderOff: FlexAdaptive.all(),
        filledButtonRadius: 10.0,
        elevatedButtonRadius: 10.0,
        inputDecoratorFillColor: Colors.white70,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        inputDecoratorRadius: 8,
        inputDecoratorUnfocusedBorderIsColored: false,
        cardRadius: 8.0,
        dialogRadius: 9.0,
        datePickerDialogRadius: 9.0,
        timePickerDialogRadius: 9.0,
        appBarBackgroundSchemeColor: SchemeColor.primary,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
    ).copyWith(
      textTheme: _getTextTheme(baseTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xff2583ff),
        centerTitle: true,
      ),
      dividerTheme: DividerThemeData(
        color: Colors.grey[400],
      ),
    );
  }

  static ThemeData get darkFlexTheme {
    var baseTheme = ThemeData(brightness: Brightness.dark);
    return FlexThemeData.dark(
      colors: const FlexSchemeColor(
        primary: Color(0xff4585b5),
        primaryContainer: Color(0xff095d9e),
        secondary: Color(0xffe57c4a),
        secondaryContainer: Color(0xffdd520f),
        tertiary: Color(0xff9cd5f9),
        tertiaryContainer: Color(0xff3a7292),
        appBarColor: Color(0xffdd520f),
        error: Color(0xffcf6679),
      ),
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 13,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        useTextTheme: true,
        useM2StyleDividerInM3: true,
        //adaptiveAppBarScrollUnderOff: FlexAdaptive.all(),
        filledButtonRadius: 10.0,
        elevatedButtonRadius: 10.0,
        inputDecoratorFillColor: Colors.white70,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        inputDecoratorRadius: 8,
        inputDecoratorUnfocusedBorderIsColored: false,
        cardRadius: 8.0,
        dialogRadius: 9.0,
        datePickerDialogRadius: 9.0,
        timePickerDialogRadius: 9.0,
        appBarBackgroundSchemeColor: SchemeColor.primary,
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

  // static TextTheme _getTextTheme(ThemeData baseTheme) {
  //   return GoogleFonts.interTightTextTheme(
  //     (baseTheme.textTheme).copyWith(
  //       bodyLarge: GoogleFonts.roboto(textStyle: baseTheme.textTheme.bodyLarge),
  //       bodyMedium:
  //           GoogleFonts.roboto(textStyle: baseTheme.textTheme.bodyMedium),
  //       bodySmall: GoogleFonts.roboto(textStyle: baseTheme.textTheme.bodySmall),
  //       labelLarge: GoogleFonts.roboto(
  //           textStyle: baseTheme.textTheme.labelLarge
  //               ?.copyWith(fontWeight: FontWeight.w300)),
  //       labelMedium:
  //           GoogleFonts.roboto(textStyle: baseTheme.textTheme.labelMedium),
  //       labelSmall:
  //           GoogleFonts.roboto(textStyle: baseTheme.textTheme.labelSmall),
  //       titleSmall: GoogleFonts.leagueSpartan(
  //         textStyle:
  //             baseTheme.textTheme.titleSmall!.copyWith(letterSpacing: -0.5),
  //       ),
  //       titleMedium: GoogleFonts.leagueSpartan(
  //         textStyle: baseTheme.textTheme.titleMedium!
  //             .copyWith(fontWeight: FontWeight.w600, letterSpacing: -0.5),
  //       ),
  //       titleLarge: GoogleFonts.leagueSpartan(
  //         textStyle: baseTheme.textTheme.titleLarge!
  //             .copyWith(fontWeight: FontWeight.w600, letterSpacing: -0.5),
  //       ),
  //       displayLarge: GoogleFonts.leagueSpartan(
  //         textStyle: baseTheme.textTheme.displayLarge!
  //             .copyWith(fontWeight: FontWeight.bold, letterSpacing: -2.0),
  //       ),
  //       displayMedium: GoogleFonts.leagueSpartan(
  //         textStyle: baseTheme.textTheme.displayMedium!
  //             .copyWith(fontWeight: FontWeight.bold, letterSpacing: -2.0),
  //       ),
  //       displaySmall: GoogleFonts.leagueSpartan(
  //         textStyle: baseTheme.textTheme.displaySmall!
  //             .copyWith(fontWeight: FontWeight.bold, letterSpacing: -2.0),
  //       ),
  //       headlineSmall: GoogleFonts.leagueSpartan(
  //           textStyle: baseTheme.textTheme.headlineSmall),
  //       headlineMedium: GoogleFonts.leagueSpartan(
  //           textStyle: baseTheme.textTheme.headlineMedium),
  //       headlineLarge: GoogleFonts.leagueSpartan(
  //           textStyle: baseTheme.textTheme.headlineLarge),
  //     ),
  //   );
  // }

  static TextTheme _getTextTheme(ThemeData baseTheme) {
    return GoogleFonts.poppinsTextTheme(
      (baseTheme.textTheme).copyWith(
        titleLarge: baseTheme.textTheme.titleLarge!
            .copyWith(fontWeight: FontWeight.bold, letterSpacing: -1.5),
        titleMedium: baseTheme.textTheme.titleMedium!
            .copyWith(fontWeight: FontWeight.bold, letterSpacing: -0.75),
        titleSmall: baseTheme.textTheme.titleSmall!
            .copyWith(fontWeight: FontWeight.bold, letterSpacing: -0.75),
        headlineSmall: baseTheme.textTheme.headlineSmall!
            .copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
