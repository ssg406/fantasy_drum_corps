import 'dart:ui';

import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/app.dart';
import 'package:fantasy_drum_corps/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Create error handlers
  registerErrorHandlers();

  // Turn off # in URL for web
  usePathUrlStrategy();
  runApp(const ProviderScope(child: DrumCorpsFantasy()));
}

class DrumCorpsFantasy extends StatelessWidget {
  const DrumCorpsFantasy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const App();
  }
}

void registerErrorHandlers() {
  // Show error UI if uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };

  // Handle errors from the underlying platform/os
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint(error.toString());
    return true;
  };

  //Show error UI when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('An unknown error occurred'.hardcoded)),
      body: Center(
        child: Text(
          details.toString(),
        ),
      ),
    );
  };
}
