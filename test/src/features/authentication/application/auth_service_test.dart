import 'package:fantasy_drum_corps/src/features/authentication/application/auth_service.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import '../../util/test_util.dart';
import 'auth_service_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthRepository>(),
  MockSpec<PlayersRepository>(),
  MockSpec<UserCredential>(),
  MockSpec<User>()
])
void main() {
  late MockAuthRepository mockAuthRepository;
  late MockPlayersRepository mockPlayersRepository;
  late AuthService authService;
  late ProviderContainer container;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockPlayersRepository = MockPlayersRepository();

    // Override with mocked repositories
    container = makeProviderContainer([
      authRepositoryProvider.overrideWithValue(mockAuthRepository),
      playersRepositoryProvider.overrideWithValue(mockPlayersRepository),
    ]);

    // Read real AuthService from container
    authService = container.read(authServiceProvider);
  });

  tearDown(() {
    // Reset mocks and container
    reset(mockPlayersRepository);
    reset(mockAuthRepository);
    container.dispose();
  });

  test('Delete current user', () async {
    final user = MockUser();
    when(user.uid).thenReturn('000');
    when(mockAuthRepository.currentUser).thenReturn(user);
    when(mockAuthRepository.validatePassword(argThat(isNotNull)))
        .thenAnswer((_) => Future.value(true));
    when(mockPlayersRepository.deletePlayer(argThat(isNotNull)))
        .thenAnswer((_) => Future.value());

    final result = await authService.deleteCurrentUser('password');

    verifyInOrder([
      mockAuthRepository.validatePassword('password'),
      mockPlayersRepository.deletePlayer('000'),
      user.delete(),
    ]);

    expect(result, true);
  });

  test('Register with email/password', () async {
    final user = MockUser();
    final credential = MockUserCredential();

    // Mock credential/user attributes
    when(user.uid).thenReturn('000');
    when(credential.user).thenReturn(user);

    // Mock repository methods
    when(mockAuthRepository.createUserWithEmailAndPassword(
            argThat(isNotNull), argThat(isNotNull)))
        .thenAnswer((_) => Future.value(credential));

    when(mockPlayersRepository.addPlayer(argThat(isNotNull)))
        .thenAnswer((_) => Future.value());

    await authService.registerWithEmailAndPassword(
        email: 'test@gmail.com', password: 'passWord!1');

    verifyInOrder([
      mockAuthRepository.createUserWithEmailAndPassword(
          'test@gmail.com', 'passWord!1'),
      mockPlayersRepository.addPlayer(argThat(isA<Player>())),
      credential.user?.sendEmailVerification(),
    ]);
  });
}
