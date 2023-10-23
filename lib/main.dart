import 'dart:io';
import 'dart:ui';

import 'package:fantasy_drum_corps/app.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/shared_preferences_repository.dart';
import 'package:fantasy_drum_corps/src/localization/string_hardcoded.dart';
import 'package:fantasy_drum_corps/src/utils/my_http_overrides.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Enable/Disable Firebase emulators
  // FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  // await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);

  // Create error handlers
  registerErrorHandlers();
  // Turn off # in URL for web
  usePathUrlStrategy();

  // ensure URL changes in the address bar when using push / pushNamed
  // more info here: https://docs.google.com/document/d/1VCuB85D5kYxPR3qYOjVmw8boAGKb7k62heFyfFHTOvw/edit
  GoRouter.optionURLReflectsImperativeAPIs = true;

  final sharedPreferences = await SharedPreferences.getInstance();
  final container = ProviderContainer(
    overrides: [
      sharedPreferencesRepositoryProvider.overrideWithValue(
        SharedPreferencesRepository(sharedPreferences),
      ),
    ],
  );

  /// HTTP Overrides to fix Android Socket.io connection
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const App(),
    ),
  );
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text('An unknown error occurred'.hardcoded)),
        body: Center(
          child: Text(
            details.toString(),
          ),
        ),
      ),
    );
  };
}
