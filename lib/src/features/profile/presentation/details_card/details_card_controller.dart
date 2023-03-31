import 'dart:async';

import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/players/application/player_service.dart';
import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'details_card_controller.g.dart';

@riverpod
class DetailsCardController extends _$DetailsCardController {
  @override
  FutureOr<void> build() {}

  Future<void> clearUserAvatar() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _clearUserAvatar());
  }

  Future<void> _clearUserAvatar() async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user != null) {
      return ref
          .read(playersRepositoryProvider)
          .setAvatarString(playerId: user.uid);
    }
  }

  Future<void> setDisplayName(String displayName) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(playerServiceProvider).setDisplayName(displayName));
  }
}
