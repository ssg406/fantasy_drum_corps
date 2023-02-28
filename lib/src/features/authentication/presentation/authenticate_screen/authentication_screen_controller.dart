import 'dart:async';

import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/authentication_form_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticateScreenController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> submit({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _authenticate(email, password));
  }

  Future<void> _authenticate(String email, String password) {
    final authRepository = ref.read(authRepositoryProvider);
    return authRepository.signInWithEmailAndPassword(email, password);
  }

  Future<void> singleSignOn() {
    final authRepository = ref.read(authRepositoryProvider);
    return authRepository.signInWithGoogle();
  }
}

final authenticateScreenControllerProvider =
    AutoDisposeAsyncNotifierProvider(AuthenticateScreenController.new);
