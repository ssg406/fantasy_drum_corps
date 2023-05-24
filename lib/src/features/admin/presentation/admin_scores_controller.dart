import 'package:fantasy_drum_corps/src/features/admin/data/score_repository.dart';
import 'package:fantasy_drum_corps/src/features/admin/domain/corps_score.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_scores_controller.g.dart';

@riverpod
class AdminScoresController extends _$AdminScoresController {
  @override
  FutureOr<void> build() {}

  Future<void> submitScore(CorpsScore score) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(scoresRepositoryProvider).addScore(score));
  }
}
