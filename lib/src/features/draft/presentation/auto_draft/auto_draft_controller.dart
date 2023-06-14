import 'package:fantasy_drum_corps/src/features/draft/data/remaining_picks_repository.dart';
import 'package:fantasy_drum_corps/src/features/draft/domain/remaining_picks.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auto_draft_controller.g.dart';

@riverpod
class AutoDraftController extends _$AutoDraftController {
  @override
  FutureOr<void> build() {}

  Future<void> updateRemainingPicks(RemainingPicks remainingPicks) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() =>
        ref.read(remainingPicksRepositoryProvider).updateRemainingPicks(
            remainingPicks));
  }
}
