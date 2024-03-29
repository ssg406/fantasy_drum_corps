import 'package:flutter/material.dart';

class AppColors {
  static const ColorScheme flexSchemeDark = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xff90caf9),
    onPrimary: Color(0xff0f1314),
    primaryContainer: Color(0xff0d47a1),
    onPrimaryContainer: Color(0xffe1eaf9),
    secondary: Color(0xffe1f5fe),
    onSecondary: Color(0xff141414),
    secondaryContainer: Color(0xff1a567d),
    onSecondaryContainer: Color(0xffe3edf3),
    tertiary: Color(0xff81d4fa),
    onTertiary: Color(0xff0e1414),
    tertiaryContainer: Color(0xff004b73),
    onTertiaryContainer: Color(0xffdfebf1),
    error: Color(0xffcf6679),
    onError: Color(0xff140c0d),
    errorContainer: Color(0xffb1384e),
    onErrorContainer: Color(0xfffbe8ec),
    background: Color(0xff181b1e),
    onBackground: Color(0xffeceded),
    surface: Color(0xff181b1e),
    onSurface: Color(0xffeceded),
    surfaceVariant: Color(0xff1f262c),
    onSurfaceVariant: Color(0xffdbdcdd),
    outline: Color(0xff9da3a3),
    shadow: Color(0xff000000),
    inverseSurface: Color(0xfff8fbfe),
    onInverseSurface: Color(0xff131313),
    inversePrimary: Color(0xff4d6678),
    surfaceTint: Color(0xff90caf9),
  );

  static const ColorScheme flexSchemeLight = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff1565c0),
    onPrimary: Color(0xffffffff),
    primaryContainer: Color(0xff90caf9),
    onPrimaryContainer: Color(0xff0c1114),
    secondary: Color(0xff0277bd),
    onSecondary: Color(0xffffffff),
    secondaryContainer: Color(0xffbedcff),
    onSecondaryContainer: Color(0xff101214),
    tertiary: Color(0xff039be5),
    onTertiary: Color(0xffffffff),
    tertiaryContainer: Color(0xffcbe6ff),
    onTertiaryContainer: Color(0xff111314),
    error: Color(0xffb00020),
    onError: Color(0xffffffff),
    errorContainer: Color(0xfffcd8df),
    onErrorContainer: Color(0xff141213),
    background: Color(0xfff6f9fc),
    onBackground: Color(0xff090909),
    surface: Color(0xfff6f9fc),
    onSurface: Color(0xff090909),
    surfaceVariant: Color(0xffeef4fa),
    onSurfaceVariant: Color(0xff121313),
    outline: Color(0xff565656),
    shadow: Color(0xff000000),
    inverseSurface: Color(0xff111317),
    onInverseSurface: Color(0xfff5f5f5),
    inversePrimary: Color(0xffaedfff),
    surfaceTint: Color(0xff1565c0),
  );

  static const customBlue = Color(0xff2583ff);
  static const customGreen = Color(0xff38d021);

  static ColorScheme get darkColors => flexSchemeDark;
  static ColorScheme get lightColors => flexSchemeLight;
}
