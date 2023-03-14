import 'dart:async';

import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Controller for [RegisterScreen]
class RegisterScreenController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> addAppUser({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _register(email, password));
  }

  Future<void> _register(String email, String password) async {
    final authRepository = ref.read(authRepositoryProvider);
    await authRepository.createUserWithEmailAndPassword(email, password);
  }

  Future<void> registerWithGoogle() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _singleSignOn());
  }

  Future<void> _singleSignOn() {
    final authRepository = ref.read(authRepositoryProvider);
    return authRepository.signInWithGoogle();
  }
}

final registerScreenControllerProvider =
    AutoDisposeAsyncNotifierProvider<RegisterScreenController, void>(
        RegisterScreenController.new);
