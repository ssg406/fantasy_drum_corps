import 'package:fantasy_drum_corps/src/localization/string_hardcoded.dart';
import 'package:fantasy_drum_corps/src/utils/alert_dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI on AsyncValue {
  void showAlertDialogOnError(BuildContext context) {
    if (!isLoading && hasError) {
      String? message;
      if (error is FirebaseAuthException) {
        final e = (error as FirebaseAuthException).toString();
        if (e.contains('wrong-password') ||
            e.contains('user-not-found') ||
            e.contains('user-disabled')) {
          message = 'Authentication details are not valid';
        } else if (e.contains('invalid-email')) {
          message = 'Invalid email address';
        } else if (e.contains('email-already-in-use')) {
          message = 'An account with that email already exists. Try signing '
              'in instead';
        } else if (e.contains('weak-password')) {
          message = 'Make sure your password is at least 6 characters and '
              'contains at least numbers in addition to letters';
        } else if (e.contains('too-many-requests')) {
          message = 'Too many failed attempts to access or change this '
              'account have been made. Try again later or reset your password '
              'to regain access immediately.';
        }
      }
      showExceptionAlertDialog(
          context: context,
          title: 'Error'.hardcoded,
          exception: message ?? 'An unknown error occurred');
    }
  }
}
