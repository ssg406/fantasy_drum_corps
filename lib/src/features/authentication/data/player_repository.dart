import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasy_drum_corps/src/features/authentication/domain/player_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';

/// Provides CRUD functionality for players collection
class PlayersRepository {
  const PlayersRepository(this._database);
  final FirebaseFirestore _database;

  static String playersPath = 'players';
  static String playerPath(String playerId) => 'players/$playerId';
  static String tourPath(String tourId) => 'tours/$tourId';

  // Create Player
  Future<void> addPlayer(Player player) {
    return _database
        .collection(playersPath)
        .doc(player.playerId)
        .set(player.toJson());
  }

  // Update player
  Future<void> updatePlayer(Player player, String id) {
    return _database.doc(playerPath(id)).update(player.toJson());
  }

  Future<Player> fetchPlayer(String id) {
    return _database
        .doc(playerPath(id))
        .get()
        .then((doc) => Player.fromJson(doc.data()!, doc.id));
  }

  Future<List<Player>> fetchTourPlayers(String tourId) async {
    final tourRef = _database.collection('tours').doc(tourId).withConverter(
          fromFirestore: (doc, _) => Tour.fromJson(doc.data()!, doc.id),
          toFirestore: (tour, _) => tour.toJson(),
        );
    final snapshot = await tourRef.get();
    final tour = snapshot.data();
    List<Player> players = List.empty(growable: true);
    for (final playerId in tour!.members) {
      final player = await fetchPlayer(playerId);
      players.add(player);
    }
    return players;
  }
}
