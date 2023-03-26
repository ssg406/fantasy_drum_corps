import 'dart:async';

import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_service.dart';
import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// [AsyncNotifier] controller for [PasswordCard] on profile page. Communicates
/// with [AuthRepository] to update password
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

  bool getIsGoogleProvider() {
    return ref.read(authServiceProvider).getUserProvider();
  }
}
/// Riverpod Providers
final passwordControllerCardProvider =
    AutoDisposeAsyncNotifierProvider<PasswordCardController, void>(
        PasswordCardController.new);
