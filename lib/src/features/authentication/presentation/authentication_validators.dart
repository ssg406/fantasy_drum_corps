import 'package:email_validator/email_validator.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authentication_form_type.dart';
import 'package:fantasy_drum_corps/src/localization/string_hardcoded.dart';

/// Mixin class is used for email and password validation
mixin AuthenticationValidators {
  bool canSubmitEmail(String email) {
    return EmailValidator.validate(email);
  }

  // Password matching expression. Password must be at least 8 characters,
  // no more than 15 characters, and must include at least one upper case
  // letter, one lower case letter, and one numeric digit.
  bool canSubmitPassword(String password, AuthenticationFormType formType) {
    final RegExp passwordExp =
        RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}$');
    if (formType == AuthenticationFormType.register) {
      RegExpMatch? matchedPassword = passwordExp.firstMatch(password);
      return matchedPassword?[0] != null;
    } else {
      return password.isNotEmpty;
    }
  }

  String? getEmailErrors(String email) {
    final bool showEmailError = !canSubmitEmail(email);
    final String emailError = email.isEmpty
        ? 'Please enter an email'.hardcoded
        : 'Invalid Email'.hardcoded;
    return showEmailError ? emailError : null;
  }

  String? getPasswordErrors(String password, AuthenticationFormType formType) {
    final bool showPasswordError = !canSubmitPassword(password, formType);
    final String passwordError = password.isEmpty
        ? 'Please enter a password'
        : 'Password must contain a mix of numbers and upper- and lowercase letters.';
    return showPasswordError ? passwordError : null;
  }
}
