import 'dart:async';

import 'package:fantasy_drum_corps/src/features/authentication/application/auth_service.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'password_card_controller.g.dart';

/// [AsyncNotifier] controller for [PasswordCard] on profile page. Communicates
/// with [AuthRepository] to update password
@riverpod
class PasswordCardController extends _$PasswordCardController {
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
