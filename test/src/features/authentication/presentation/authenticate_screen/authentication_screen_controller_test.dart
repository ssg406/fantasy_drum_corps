import 'package:fantasy_drum_corps/src/features/authentication/application/auth_service.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/authentication/oauth_provider.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/authentication_form_type.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/authentication_screen_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';

import '../../../util/test_util.dart';
@GenerateNiceMocks([MockSpec<AuthService>(), MockSpec<AuthRepository>()])
import 'authentication_screen_controller_test.mocks.dart';

void main() {
  late MockAuthService mockAuthService;
  late MockAuthRepository mockAuthRepository;
  late ProviderContainer container;
  late Listener listener;

  setUp(() {
    listener = Listener<AsyncValue<void>>();
    mockAuthService = MockAuthService();
    mockAuthRepository = MockAuthRepository();
    container = makeProviderContainer([
      authServiceProvider.overrideWithValue(mockAuthService),
      authRepositoryProvider.overrideWithValue(mockAuthRepository)
    ]);
    container.listen(
      authenticateScreenControllerProvider,
      listener,
      fireImmediately: true,
    );
  });

  tearDown(() => reset(listener));

  group('Auth screen controller tests', () {
    test('Initial state is AsyncData', () {
      verify(
        listener(null, const AsyncData<void>(null)),
      );

      verifyNoMoreInteractions(listener);
    });

    test('Register/sign-in with email/password', () async {
      when(mockAuthService.registerWithEmailAndPassword(
              email: 'test@gmail.com', password: 'passW0rd!'))
          .thenAnswer((_) => Future.value());

      when(mockAuthService.signInWithEmailAndPassword(
              email: 'test@gmail.com', password: 'passW0rd!'))
          .thenAnswer((_) => Future.value());

      const data = AsyncData<void>(null);

      verify(listener(null, data));

      final controller =
          container.read(authenticateScreenControllerProvider.notifier);

      // Registration with email/password
      await controller.submit(
          email: 'test@gmail.com',
          password: 'passW0rd!',
          formType: AuthenticationFormType.register);

      verifyInOrder([
        listener(data, argThat(isA<AsyncLoading<void>>())),
        listener(argThat(isA<AsyncLoading<void>>()), data),
      ]);

      verify(mockAuthService.registerWithEmailAndPassword(
              email: anyNamed('email'), password: anyNamed('password')))
          .called(1);

      verifyNoMoreInteractions(listener);

      // Sign in with email/password
      await controller.submit(
          email: 'test@gmail.com',
          password: 'passW0rd!',
          formType: AuthenticationFormType.signIn);

      verifyInOrder([
        listener(data, argThat(isA<AsyncLoading<void>>())),
        listener(argThat(isA<AsyncLoading<void>>()), data),
      ]);

      verify(mockAuthService.signInWithEmailAndPassword(
              email: anyNamed('email'), password: anyNamed('password')))
          .called(1);

      verifyNoMoreInteractions(listener);
    });

    test('Sign-in with OAuth provider', () async {
      when(mockAuthService
              .registerWithOAuthProvider(OAuthSignInProvider.google))
          .thenAnswer((_) => Future.value());

      final controller =
          container.read(authenticateScreenControllerProvider.notifier);

      verify(listener(null, const AsyncData<void>(null)));

      await controller
          .authenticateWithOAuthProvider(OAuthSignInProvider.google);

      verifyInOrder([
        listener(
            const AsyncData<void>(null), argThat(isA<AsyncLoading<void>>())),
        listener(
            argThat(isA<AsyncLoading<void>>()), const AsyncData<void>(null)),
      ]);

      verify(mockAuthService
              .registerWithOAuthProvider(OAuthSignInProvider.google))
          .called(1);

      verifyNoMoreInteractions(listener);
    });

    test('Send password reset email', () async {
      when(mockAuthRepository.sendPasswordResetEmail('test@gmail.com'))
          .thenAnswer((_) => Future.value());

      final controller =
          container.read(authenticateScreenControllerProvider.notifier);

      verify(listener(null, const AsyncData<void>(null)));

      await controller.sendPasswordResetMail(email: 'test@gmail.com');

      verifyInOrder([
        listener(
            const AsyncData<void>(null), argThat(isA<AsyncLoading<void>>())),
        listener(
            argThat(isA<AsyncLoading<void>>()), const AsyncData<void>(null)),
      ]);

      verify(mockAuthRepository.sendPasswordResetEmail('test@gmail.com'))
          .called(1);

      verifyNoMoreInteractions(listener);
    });
  });
}
