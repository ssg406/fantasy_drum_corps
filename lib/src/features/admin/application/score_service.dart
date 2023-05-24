import 'package:fantasy_drum_corps/src/features/admin/data/score_repository.dart';
import 'package:fantasy_drum_corps/src/features/admin/domain/corps_score.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/data/fantasy_corps_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'score_service.g.dart';

class ScoreService {
  const ScoreService(this.fantasyCorpsRepo, this.scoresRepo);

  final FantasyCorpsRepository fantasyCorpsRepo;
  final ScoresRepository scoresRepo;

  Future<void> updateScores(CorpsScore scores) async {
    await scoresRepo.updateScore(scores);
    final allCorps = await fantasyCorpsRepo.fetchAllFantasyCorps();

    // Iterate over all fantasy corps on the server
    for (final fantasyCorps in allCorps) {
      final lineup = fantasyCorps.lineup!;
      final lineupScore = fantasyCorps.lineupScore!;

      // Iterate through each caption within the fantasy corps lineup
      for (final lineupCaption in lineup.keys) {
        // If the lineup caption slot contains the drum corps
        if (lineup[lineupCaption] == scores.corps) {
          // Write the score to the lineupScore
          lineupScore[lineupCaption] = scores.scores[lineupCaption]!;
        }
      }
      final updatedFantasyCorps =
          fantasyCorps.copyWith(lineupScore: lineupScore);
      await fantasyCorpsRepo.updateFantasyCorps(updatedFantasyCorps);
    }
  }
}

@riverpod
ScoreService scoreService(ScoreServiceRef ref) => ScoreService(
    ref.watch(fantasyCorpsRepositoryProvider),
    ref.watch(scoresRepositoryProvider));
