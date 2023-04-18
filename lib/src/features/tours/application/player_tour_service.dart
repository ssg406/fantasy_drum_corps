import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player_tour_service.g.dart';

class PlayerTourService {
  const PlayerTourService(this._playerRepo, this._tourRepo);

  final PlayersRepository _playerRepo;
  final ToursRepository _tourRepo;

  Future<List<Player>> fetchTourPlayers(List<String> members) async {
    final tourPlayers = <Player>[];

    for (final member in members) {
      final player = await _playerRepo.fetchPlayer(member);
      if (player == null) {
        throw StateError('The player ID found in the tour does not exist');
      }
      tourPlayers.add(player);
    }
    return tourPlayers;
  }

  Stream<List<Player>> watchTourPlayers(List<String> members) {
    return _playerRepo.queryPlayers().snapshots().map((snapshot) => snapshot
        .docs
        .map((doc) => doc.data())
        .where((player) => members.contains(player.playerId))
        .toList());
  }
}

@riverpod
PlayerTourService playerTourService(PlayerTourServiceRef ref) {
  return PlayerTourService(
    ref.watch(playersRepositoryProvider),
    ref.watch(toursRepositoryProvider),
  );
}

@riverpod
Stream<List<Player>> watchTourPlayers(
    WatchTourPlayersRef ref, List<String> members) {
  final service = ref.watch(playerTourServiceProvider);
  return service.watchTourPlayers(members);
}

@riverpod
Future<List<Player>> fetchTourPlayers(
    FetchTourPlayersRef ref, List<String> members) {
  final service = ref.watch(playerTourServiceProvider);
  return service.fetchTourPlayers(members);
}
