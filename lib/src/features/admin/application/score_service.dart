import 'package:fantasy_drum_corps/src/features/admin/data/score_repository.dart';
import 'package:fantasy_drum_corps/src/features/admin/domain/corps_score.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/data/fantasy_corps_repository.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
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
      final lineupScore = fantasyCorps.lineupScore ?? <Caption, double>{};

      // Iterate through each caption within the fantasy corps lineup
      for (final lineupSlot in lineup.keys) {
        // If the drum corps at the lineup slot == the corps of the score
        if (lineup[lineupSlot] == scores.corps) {
          // Write the score to the lineupScore
          lineupScore[lineupSlot] = scores.scores[lineupSlot]!;
        }
      }
      final updatedFantasyCorps =
      fantasyCorps.copyWith(lineupScore: lineupScore);
      await fantasyCorpsRepo.updateFantasyCorps(updatedFantasyCorps);
    }
  }

  Future<LineupScore> getCurrentScore(Lineup lineup) async {
    // Get all scores from server
    final allCorpsScores = await scoresRepo.fetchAllCorpsScores();

    // Create empty score lookup table and lineup score
    Map<DrumCorps, LineupScore> scoreLookup = {};
    LineupScore lineupScore = {};

    // Get current scores and add to lookup table
    for (final corpsScore in allCorpsScores) {
      scoreLookup.addAll({corpsScore.corps: corpsScore.scores});
    }

    // Iterate through all caption slots in the lineup
    for (final captionSlot in lineup.keys) {
      // Find the scores for the corps located in this slot
      final scores = scoreLookup[lineup[captionSlot]];

      // Add the score for the current caption to the lineup score
      final captionScore = scores?[captionSlot] ?? 0;
      lineupScore.addAll({captionSlot: captionScore});
    }
    return lineupScore;
  }
}

@riverpod
ScoreService scoreService(ScoreServiceRef ref) =>
    ScoreService(
        ref.watch(fantasyCorpsRepositoryProvider),
        ref.watch(scoresRepositoryProvider));
