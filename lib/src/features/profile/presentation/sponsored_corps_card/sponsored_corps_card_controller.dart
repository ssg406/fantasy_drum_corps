import 'dart:async';

import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:fantasy_drum_corps/src/features/players/application/player_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sponsored_corps_card_controller.g.dart';

/// Riverpod [AsyncNotifier] controller for [SelectedCorpsCard]. Communicates
/// with [PlayerRepository]
@riverpod
class SponsoredCorpsCardController extends _$SponsoredCorpsCardController {
  @override
  FutureOr<void> build() {}

  Future<void> selectSponsoredCorps({required DrumCorps selectedCorps}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => ref.read(playerServiceProvider).setSelectedCorps(selectedCorps));
  }
}
