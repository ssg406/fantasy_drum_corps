import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/register_screen_validators.dart';
import 'package:flutter_test/flutter_test.dart';

// Class to hold mixin for testing
class RegistrationValidatorsTest with RegistrationValidators {}

/// Tests validators used on registration and authentication page. Validator
/// packages that are external to the application are not tested thoroughly
/// as they are at the boundary of the program and we assume the developers'
/// testing is adequate already.
void main() {
  late RegistrationValidatorsTest sut;

  setUp(() => sut = RegistrationValidatorsTest());

  group('Registration validators test', () {
    test(
        'canSubmitEmail returns true for valid email and false for invalid email',
        () {
      final validResult = sut.canSubmitEmail('email@example.com');
      expect(validResult, true);

      final invalidResult = sut.canSubmitEmail('email');
      expect(invalidResult, false);
    });

    test(
        'canSubmitPassword returns true for valid passwords and false '
        'for invalid passwords', () {
      final validResult = sut.canSubmitPassword('passWord1');
      expect(validResult, true);

      final invalidResult = sut.canSubmitPassword('notsecure');
      expect(invalidResult, false);
    });

    test(
        'canSubmitDisplayName returns true for valid display names and false'
        'for invalid display names', () {
      final validResult = sut.canSubmitDisplayName('Sam Jones');
      expect(validResult, true);

      final invalidResult = sut.canSubmitDisplayName('');
      expect(invalidResult, false);

      final invalidResult2 = sut.canSubmitDisplayName('fuck');
      expect(invalidResult2, false);
    });

    test(
        'getPasswordErrors returns string of erros on invalid passwords and '
        'null on no errors', () {
      final validResult = sut.getPasswordErrors('passWord1');
      expect(validResult, null);

      final emptyResult = sut.getPasswordErrors('');
      expect(emptyResult, 'Please enter a password');

      final invalidResult = sut.getPasswordErrors('password');
      expect(invalidResult,
          'Password must contain a mix of numbers and upper- and lowercase letters.');
    });

    test(
        'getEmailErrors shows messages for empty and invalid emails and '
        'returns null on valid emails', () {
      final validResult = sut.getEmailErrors('email@example.com');
      expect(validResult, null);

      final emptyResult = sut.getEmailErrors('');
      expect(emptyResult, 'Please enter an email');

      final invalidResult = sut.getEmailErrors('email');
      expect(invalidResult, 'Invalid Email');
    });

    test(
        'getDisplayNameErrors shows messages for empty or profane display '
        'names and returns null on valid values', () {
      final validResult = sut.getDisplayNameErrors('sam jones');
      expect(validResult, null);

      final emptyResult = sut.getDisplayNameErrors('');
      expect(emptyResult, 'Please enter a display name');

      final invalidResult = sut.getDisplayNameErrors('ass face');
      expect(invalidResult, 'Please enter a different display name');
    });
  });
}
