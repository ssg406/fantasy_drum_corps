import 'dart:async';

import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'email_card_controller.g.dart';

@riverpod
class EmailCardController extends _$EmailCardController {
  @override
  FutureOr<void> build() {}

  Future<void> changeEmail(String newEmail, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(authRepositoryProvider).setEmail(newEmail, password));
  }
}
