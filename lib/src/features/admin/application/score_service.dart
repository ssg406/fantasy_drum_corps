import 'package:fantasy_drum_corps/src/features/admin/domain/corps_score.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/data/fantasy_corps_repository.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'score_service.g.dart';

class ScoreService {
  const ScoreService(this.fantasyCorpsRepo);

  final FantasyCorpsRepository fantasyCorpsRepo;

  Future<void> updateScores(CorpsScore scores) async {
    final allCorps = await fantasyCorpsRepo.fetchAllFantasyCorps();
    final drumCorps = scores.corps;

    // Iterate over all fantasy corps on the server
  }
}

@riverpod
ScoreService scoreService(ScoreServiceRef ref) =>
    ScoreService(ref.watch(fantasyCorpsRepositoryProvider));
