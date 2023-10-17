import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/register_screen_validators.dart';
import 'package:flutter_test/flutter_test.dart';

class RegistrationValidatorsHolder with RegistrationValidators {}

void main() {
  final validators = RegistrationValidatorsHolder();

  group('Password validator tests', () {
    test('Short passwords < 8 chars fail',
        () => expect(validators.canSubmitPassword('a'), false));

    test('Short passwords with digits and uppercase chars fail',
        () => expect(validators.canSubmitPassword('aBc1d'), false));

    test('Long passwords missing uppercase letter fail',
        () => expect(validators.canSubmitPassword('abcdefgh1'), false));

    test('> 8 char password missing digit fail',
        () => expect(validators.canSubmitPassword('abcdEfGhiJkl'), false));

    test('> 8 char passwords with digit and uppercase char pass',
        () => expect(validators.canSubmitPassword('abcDEF1234'), true));

    test('> 8 char password with added symbol passes',
        () => expect(validators.canSubmitPassword('abc123ABC##'), true));
  });

  group('Get error function tests', () {
    test(
        'getPasswordErrors returns string for invalid password',
        () => expect(
            validators.getPasswordErrors('abc'), const TypeMatcher<String>()));

    test('getPasswordErrors returns null for valid password',
        () => expect(validators.getPasswordErrors('abc123ABC123'), null));

    test(
        'getEmailErros returns string for invalid email',
        () => expect(
            validators.getEmailErrors('email'), const TypeMatcher<String>()));

    test('getEmailErrors returns null for valid email',
        () => expect(validators.getEmailErrors('valid@gmail.com'), null));

    test(
        'getDisplayNameErrors returns string for invalid display name',
        () => expect(validators.getDisplayNameErrors('fuck'),
            const TypeMatcher<String>()));

    test('getDisplayNameErrors returns null for valid display name',
        () => expect(validators.getDisplayNameErrors('display name'), null));
  });
}
