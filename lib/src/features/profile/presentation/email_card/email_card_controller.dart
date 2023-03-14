import 'dart:async';

import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailCardController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> changeEmail(String newEmail, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(authRepositoryProvider).setEmail(newEmail, password));
  }
}

final emailCardControllerProvider =
    AutoDisposeAsyncNotifierProvider<EmailCardController, void>(
        EmailCardController.new);
