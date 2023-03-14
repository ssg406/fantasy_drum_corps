import 'dart:async';

import 'package:fantasy_drum_corps/src/features/profile/data/user_corps_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SponsoredCorpsCardController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> selectSponsoredCorps({required String selectedCorps}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => ref.read(setUserSelectedCorpsProvider(selectedCorps)));
  }
}

final sponsoredCorpsCardControllerProvider =
    AutoDisposeAsyncNotifierProvider<SponsoredCorpsCardController, void>(
        SponsoredCorpsCardController.new);
