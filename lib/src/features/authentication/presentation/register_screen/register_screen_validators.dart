import 'package:email_validator/email_validator.dart';
import 'package:fantasy_drum_corps/src/localization/string_hardcoded.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:flutter/material.dart';

/// Mixin class provides validation features to registration page
mixin RegistrationValidators {
  bool canSubmitEmail(String email) {
    return EmailValidator.validate(email);
  }

  // Password matching expression. Password must be at least 8 characters,
  // no more than 15 characters, and must include at least one upper case
  // letter, one lower case letter, and one numeric digit.
  bool canSubmitPassword(String password) {
    final RegExp passwordExp =
        RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}$');
    RegExpMatch? matchedPassword = passwordExp.firstMatch(password);
    return matchedPassword?[0] != null;
  }

  bool canSubmitDisplayName(String displayName) {
    final filter = ProfanityFilter();
    return filter.hasProfanity(displayName) || displayName.isNotEmpty;
  }

  String? getPasswordErrors(String password) {
    final bool showPasswordError = !canSubmitPassword(password);
    final String passwordError = password.isEmpty
        ? 'Please enter a password'
        : 'Password must contain a mix of numbers and upper- and lowercase letters.';
    return showPasswordError ? passwordError : null;
  }

  String? getEmailErrors(String email) {
    final bool showEmailError = !canSubmitEmail(email);
    final String emailError = email.isEmpty
        ? 'Please enter an email'.hardcoded
        : 'Invalid Email'.hardcoded;
    return showEmailError ? emailError : null;
  }

  String? getDisplayNameErrors(String displayName) {
    final bool showDisplayNameError = !canSubmitDisplayName(displayName);
    debugPrint('showDisplayNameError: $showDisplayNameError');
    final String displayNameError = displayName.isEmpty
        ? 'Please enter a display name'.hardcoded
        : 'Please enter a different display name'.hardcoded;
    return showDisplayNameError ? displayNameError : null;
  }
}
