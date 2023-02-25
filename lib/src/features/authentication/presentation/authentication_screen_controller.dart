import 'dart:async';

import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authentication_form_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticateScreenController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> submit({
    required String email,
    required String password,
    required AuthenticationFormType formType,
  }) async {
    state = const AsyncValue.loading();
    state =
        await AsyncValue.guard(() => _authenticate(email, password, formType));
  }

  Future<void> _authenticate(
      String email, String password, AuthenticationFormType formType) {
    final authRepository = ref.read(authRepositoryProvider);
    switch (formType) {
      case AuthenticationFormType.register:
        return authRepository.createUserWithEmailAndPassword(email, password);
      case AuthenticationFormType.signIn:
        return authRepository.signInWithEmailAndPassword(email, password);
    }
  }

  Future<void> singleSignOn() {
    final authRepository = ref.read(authRepositoryProvider);
    return authRepository.signInWithGoogle();
  }
}

final authenticateScreenControllerProvider =
    AutoDisposeAsyncNotifierProvider(AuthenticateScreenController.new);
