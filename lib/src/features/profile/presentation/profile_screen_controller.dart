import 'package:fantasy_drum_corps/src/features/authentication/application/auth_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_screen_controller.g.dart';

@riverpod
class ProfileScreenController extends _$ProfileScreenController {

  @override
  FutureOr<void> build() {}

  bool getIsGoogleAuth() {
    return ref.read(authServiceProvider).getUserProvider();
  }
}