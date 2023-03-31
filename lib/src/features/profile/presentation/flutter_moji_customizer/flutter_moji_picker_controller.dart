import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flutter_moji_picker_controller.g.dart';

@riverpod
class FlutterMojiPickerController extends _$FlutterMojiPickerController {
  @override
  FutureOr<void> build() {}

  Future<void> setPlayerAvatarString(String avatarString) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _setPlayerAvatarString(avatarString));
  }

  Future<void> _setPlayerAvatarString(String avatarString) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user != null) {
      ref
          .read(playersRepositoryProvider)
          .setAvatarString(playerId: user.uid, avatarString: avatarString);
    }
  }
}
