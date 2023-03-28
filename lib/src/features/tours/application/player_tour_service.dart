import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player_tour_service.g.dart';

class PlayerTourService {
  const PlayerTourService(this._playerRepo, this._tourRepo);

  final PlayersRepository _playerRepo;
  final ToursRepository _tourRepo;

  Future<List<Player>> fetchTourPlayers(String tourId) async {
    final tour = await _tourRepo.fetchTour(tourId: tourId);
    if (tour == null) {
      throw AssertionError('Tour cannot be null when fetching members');
    }
    final List<Player> tourPlayers = [];
    for (final member in tour.members) {
      final player = await _playerRepo.fetchPlayer(member);
      if (player == null) {
        throw StateError('The player ID found in the tour does not exist');
      }
      tourPlayers.add(player);
    }
    return tourPlayers;
  }
}

@riverpod
PlayerTourService playerTourService(PlayerTourServiceRef ref) {
  return PlayerTourService(
    ref.watch(playersRepositoryProvider),
    ref.watch(toursRepositoryProvider),
  );
}
