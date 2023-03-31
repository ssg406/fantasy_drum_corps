// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBRLa1wZbjA-zHHlCB_z6QGFL9fkBYtWvA',
    appId: '1:865655864882:web:b77edfcb08e5a47628862b',
    messagingSenderId: '865655864882',
    projectId: 'fantasy-drum-corps-54ddc',
    authDomain: 'fantasy-drum-corps-54ddc.firebaseapp.com',
    storageBucket: 'fantasy-drum-corps-54ddc.appspot.com',
    measurementId: 'G-HN77CYGXZS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBkDV6TMwXTNsI3HG19_mXidDzP2KqJRZg',
    appId: '1:865655864882:android:ec7bb81d2d6fc18028862b',
    messagingSenderId: '865655864882',
    projectId: 'fantasy-drum-corps-54ddc',
    storageBucket: 'fantasy-drum-corps-54ddc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBpovDM6V_rMyaf51WlChq3LD43gT5AhiA',
    appId: '1:865655864882:ios:5987580b4f78cc5428862b',
    messagingSenderId: '865655864882',
    projectId: 'fantasy-drum-corps-54ddc',
    storageBucket: 'fantasy-drum-corps-54ddc.appspot.com',
    iosClientId:
        '865655864882-3c4pqfapdioutpgmn0aecfg2t6mmlkq2.apps.googleusercontent.com',
    iosBundleId: 'com.fantasydrumcorps.fantasyDrumCorps',
  );
}
