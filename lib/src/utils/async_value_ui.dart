import 'package:fantasy_drum_corps/src/localization/string_hardcoded.dart';
import 'package:fantasy_drum_corps/src/utils/alert_dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI on AsyncValue {
  void showAlertDialogOnError(BuildContext context) {
    debugPrint('isLoading: $isLoading    hasError: $hasError');
    if (!isLoading && hasError) {
      if (error is FirebaseAuthException) {
        final e = error as FirebaseAuthException;
        debugPrint('the message is ${e.message}\nThe code is ${e.code}');
      }

      /// signInWithEmailAndPassword:
      /// wrong-password
      /// invalid-email
      /// user-disabled
      /// user-not-found
      /// createUserWithEmailAndPassword
      /// email-already-in-use
      /// invalid-email
      /// operation-not-allowed
      /// weak-password
      final message = error.toString();
      debugPrintStack();
      showExceptionAlertDialog(
          context: context, title: 'Error'.hardcoded, exception: message);
    }
    if (hasValue && !hasError && !isLoading) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Success!')));
    }
  }
}
