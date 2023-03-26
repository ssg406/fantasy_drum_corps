import 'dart:async';

import 'package:fantasy_drum_corps/src/features/authentication/data/auth_service.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/authentication_form_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticateScreenController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> submit({
    required String email,
    required String password,
    String? displayName,
    required AuthenticationFormType formType,
  }) async {
    state = const AsyncValue.loading();
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

  Future<void> authenticateWithGoogle() async {
    ref.read(authServiceProvider).registerWithGoogle();
  }
}

final authenticateScreenControllerProvider =
    AutoDisposeAsyncNotifierProvider(AuthenticateScreenController.new);
