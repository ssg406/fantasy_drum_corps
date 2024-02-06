import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

import '../../util/test_util.dart';

void main() {
  late MockFirebaseAuth mockAuth;
  late AuthRepository authRepository;
  late ProviderContainer container;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    container = makeProviderContainer([
      firebaseAuthProvider.overrideWithValue(mockAuth),
    ]);
    authRepository = container.read(authRepositoryProvider);
  });

  group('Auth Repository Tests', () {
    test('Create user with email and password', () async {
      final credential = await authRepository.createUserWithEmailAndPassword(
          'test@gmail.com', 'Passw0rd1!');
      expect(credential, isNotNull);
    });
  });
}
