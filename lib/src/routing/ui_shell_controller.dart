import 'dart:async';

import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Dashboard controller
/// TODO refactor into UI shell controller only
class UiShellController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> signOut() async {
    return ref.read(authRepositoryProvider).signOut();
  }
}

final uiShellControllerProvider =
    AutoDisposeAsyncNotifierProvider<UiShellController, void>(
        UiShellController.new);
