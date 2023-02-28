mixin AuthenticationValidators {
  String? getEmailErrors(String email) {
    return email.isEmpty ? 'Please enter an email' : null;
  }

  String? getPasswordErrors(String password) {
    return password.isEmpty ? 'Please enter a password' : null;
  }
}
