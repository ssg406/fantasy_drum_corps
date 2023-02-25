import 'package:fantasy_drum_corps/src/common_widgets/alert_dialogs.dart';
import 'package:fantasy_drum_corps/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI on AsyncValue {
  void showAlertDialogOnError(BuildContext context) {
    debugPrint('isLoading: $isLoading    hasError: $hasError');
    if (!isLoading && hasError) {
      final message = error.toString();
      showExceptionAlertDialog(
          context: context, title: 'Error'.hardcoded, exception: message);
    }
  }
}
