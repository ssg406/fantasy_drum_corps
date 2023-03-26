import 'dart:async';

import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Riverpod [AsyncNotifier] controller for [SelectedCorpsCard]. Communicates
/// with [PlayerRepository]
class SponsoredCorpsCardController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> selectSponsoredCorps({required DrumCorps selectedCorps}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => ref.read(setSelectedCorpsProvider(selectedCorps)));
  }
}

/// Riverpod Providers
final sponsoredCorpsCardControllerProvider =
    AutoDisposeAsyncNotifierProvider<SponsoredCorpsCardController, void>(
        SponsoredCorpsCardController.new);
