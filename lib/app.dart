import 'package:fantasy_drum_corps/src/utils/app_theme.dart';
import 'package:fantasy_drum_corps/src/localization/string_hardcoded.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      routerConfig: goRouter,
      onGenerateTitle: (context) => 'Fantasy Drum Corps'.hardcoded,
      theme: AppTheme.flexThemeLight,
      darkTheme: AppTheme.flexThemeDark,
      themeMode: ThemeMode.dark,
    );
  }
}
