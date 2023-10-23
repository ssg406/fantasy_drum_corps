import 'dart:async';

import 'package:fantasy_drum_corps/src/features/authentication/application/auth_service.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/authentication/oauth_provider.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/authentication_form_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication_screen_controller.g.dart';

@riverpod
class AuthenticateScreenController extends _$AuthenticateScreenController {
  @override
  FutureOr<void> build() {}

  Future<void> submit({
    required String email,
    required String password,
    String? displayName,
    required AuthenticationFormType formType,
  }) async {
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() => _authenticate(email, password, formType));
  }

  Future<void> _authenticate(
      String email, String password, AuthenticationFormType formType) {
    final authService = ref.read(authServiceProvider);

    switch (formType) {
      case AuthenticationFormType.register:
        return authService.registerWithEmailAndPassword(
            email: email, password: password);
      case AuthenticationFormType.signIn:
        return authService.signInWithEmailAndPassword(
            email: email, password: password);
    }
  }

  Future<void> authenticateWithOAuthProvider(
      OAuthSignInProvider provider) async {
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() => _authenticateWithOAuthProvider(provider));
  }

  Future<void> _authenticateWithOAuthProvider(OAuthSignInProvider provider) {
    return ref.read(authServiceProvider).registerWithOAuthProvider(provider);
  }

  Future<void> sendPasswordResetMail({required String email}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(authRepositoryProvider).sendPasswordResetEmail(email));
  }
}
