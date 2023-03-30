import 'dart:async';

import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ui_shell_controller.g.dart';

@riverpod
class UiShellController extends _$UiShellController {
  @override
  FutureOr<void> build() {}

  Future<void> signOut() async {
    return ref.read(authRepositoryProvider).signOut();
  }
}
