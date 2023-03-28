import 'package:fantasy_drum_corps/src/features/authentication/application/auth_service.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/authentication_screen_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}

void main() {
  // Create container to override providers
  ProviderContainer makeProviderContainer(MockAuthService authService) {
    final container = ProviderContainer(
      overrides: [
        authServiceProvider.overrideWithValue(authService),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  setUpAll(() {
    registerFallbackValue(const AsyncLoading<void>());
  });

  test('initial state is AsyncData', () {
    final authService = MockAuthService();

    // Create container with mock
    final container = makeProviderContainer(authService);

    // Create listener
    final listener = Listener<AsyncValue<void>>();

    // Listen to provider and call [listener] when its value changes
    container.listen(
      authenticateScreenControllerProvider,
      listener,
      fireImmediately: true,
    );
    verify(
      () => listener(null, const AsyncData<void>(null)),
    );

    // Listener is no longer being called
    verifyNoMoreInteractions(listener);
    verifyNever(authService.registerWithGoogle);
  });

  test('submit authentication success', () async {
    final authService = MockAuthService();

    // stub method returns success
    when(authService.registerWithGoogle).thenAnswer((_) => Future.value());

    final container = makeProviderContainer(authService);
    final listener = Listener<AsyncValue<void>>();
    container.listen(
      authenticateScreenControllerProvider,
      listener,
      fireImmediately: true,
    );
    const data = AsyncData<void>(null);

    verify(() => listener(null, data));

    final controller =
        container.read(authenticateScreenControllerProvider.notifier);

    await controller.authenticateWithGoogle();

    verifyInOrder([
      // set loading state
      // * use matcher since AsyncLoading != AsyncLoading with data
      () => listener(data, any(that: isA<AsyncLoading>())),
      // data when complete
      () => listener(any(that: isA<AsyncLoading>()), data),
    ]);

    verifyNoMoreInteractions(listener);
    verify(authService.registerWithGoogle).called(1);
  });

  test('sign in failure', () async {
    // set up
    final authService = MockAuthService();
    final exception = Exception('connection failed');
    when(authService.registerWithGoogle).thenThrow(exception);
    final container = makeProviderContainer(authService);
    final listener = Listener<AsyncValue<void>>();
    container.listen(
      authenticateScreenControllerProvider,
      listener,
      fireImmediately: true,
    );
    const data = AsyncData<void>(null);

    // verify initial value at build
    verify(() => listener(null, data));

    // run test
    verifyInOrder([
      // set loading state
      // * use matchers
      () => listener(data, any(that: isA<AsyncLoading>())),
      // get error when complete
      () => listener(
          any(that: isA<AsyncLoading>()), any(that: isA<AsyncError>())),
    ]);

    verifyNoMoreInteractions(listener);
    verify(authService.registerWithGoogle).called(1);
  });
}
