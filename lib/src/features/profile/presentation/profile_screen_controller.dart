import 'dart:async';

import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreenController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> updateDisplayName({required String newDisplayName}) async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => authRepository.setDisplayName(newDisplayName));
  }
}

final profileScreenControllerProvider =
    AutoDisposeAsyncNotifierProvider<ProfileScreenController, void>(
        ProfileScreenController.new);
