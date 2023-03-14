import 'dart:async';

import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordCardController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> updatePassword(
      {required String currentPassword, required String newPassword}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref
        .read(authRepositoryProvider)
        .setPassword(oldPassword: currentPassword, newPassword: newPassword));
  }
}

final passwordControllerCardProvider =
    AutoDisposeAsyncNotifierProvider<PasswordCardController, void>(
        PasswordCardController.new);
