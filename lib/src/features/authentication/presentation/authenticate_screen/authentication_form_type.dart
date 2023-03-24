import 'package:fantasy_drum_corps/src/localization/string_hardcoded.dart';

/// Form type of authentication page: Register / Sign In
enum AuthenticationFormType {
  register,
  signIn,
}

/// Extension on enum returns text labels and toggles form type
extension AuthenticationFormTypeExt on AuthenticationFormType {
  String get submitButtonText {
    if (this == AuthenticationFormType.register) {
      return 'Register'.hardcoded;
    } else {
      return 'Sign In'.hardcoded;
    }
  }

  String get toggleFormButtonText {
    if (this == AuthenticationFormType.register) {
      return 'Sign In'.hardcoded;
    } else {
      return 'Register';
    }
  }

  bool get isRegistrationForm => this == AuthenticationFormType.register;

  AuthenticationFormType get toggledFormAction {
    if (this == AuthenticationFormType.register) {
      return AuthenticationFormType.signIn;
    } else {
      return AuthenticationFormType.register;
    }
  }

  String get errorTitle {
    if (this == AuthenticationFormType.register) {
      return 'Registration Error'.hardcoded;
    } else {
      return 'Sign In Error'.hardcoded;
    }
  }

  String get title {
    if (this == AuthenticationFormType.register) {
      return 'Create Account'.hardcoded;
    } else {
      return 'Sign In'.hardcoded;
    }
  }

  String get secondaryFormText {
    if (this == AuthenticationFormType.register) {
      return 'Already registered?';
    } else {
      return 'Need to register?';
    }
  }
}
