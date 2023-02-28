import 'dart:async';

import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Controller for [RegisterScreen]
class RegisterScreenController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> registerUser({
    required String email,
    required String password,
    required String displayName,
    required String sponsoredCorps,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => _register(email, password, displayName, sponsoredCorps));
  }

  Future<void> _register(String email, String password, String displayName,
      String sponsoredCorps) async {
    final usersRepository = ref.read(usersRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);
    final userCredential =
        await authRepository.createUserWithEmailAndPassword(email, password);
    return usersRepository.addUser(
        id: userCredential.user!.uid,
        email: email,
        displayName: displayName,
        sponsoredCorps: sponsoredCorps);
  }
}

final registerScreenControllerProvider =
    AutoDisposeAsyncNotifierProvider<RegisterScreenController, void>(
        RegisterScreenController.new);
