import 'package:fantasy_drum_corps/src/utils/app_theme.dart';
import 'package:fantasy_drum_corps/src/localization/string_hardcoded.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
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
