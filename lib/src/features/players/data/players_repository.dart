import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Stores non authentication related player data in Firebase
class PlayersRepository {
  const PlayersRepository(this._db);

  final FirebaseFirestore _db;

  static const String playersPath = 'players';

  static String playerPath(String playerId) => 'players/$playerId';

  // Firestore query with converter for players collection
  Query<Player> queryPlayers() => _db.collection(playersPath).withConverter(
        fromFirestore: (snapshot, _) =>
            Player.fromJson(snapshot.data()!, snapshot.id),
        toFirestore: (player, _) => player.toJson(),
      );

  // Add a new player
  Future<void> addPlayer(Player player) {
    return _db
        .collection(playersPath)
        .doc(player.playerId)
        .set(player.toJson());
  }

  Stream<List<Player>> watchPlayers() {
    return queryPlayers()
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<void> updatePlayer({required Player player}) async {
    return _db.doc(playerPath(player.playerId)).update(player.toJson());
  }

  Future<void> setDisplayName(
      {required String playerId, required String displayName}) async {
    final playerRef = _db.doc(playerPath(playerId));
    playerRef.get().then((doc) async {
      final player = Player.fromJson(doc.data()!, doc.id);
      player.displayName = displayName;
      await updatePlayer(player: player);
    });
  }

  Future<void> setSelectedCorps(
      {required String playerId, required DrumCorps corps}) async {
    final playerRef = _db.doc(playerPath(playerId));
    playerRef.get().then((doc) async {
      final player = Player.fromJson(doc.data()!, doc.id);
      player.selectedCorps = corps;
      await updatePlayer(player: player);
    });
  }

  Future<void> setPhotoUrl(
      {required String playerId, required String url}) async {
    final playerRef = _db.doc(playerPath(playerId));
    playerRef.get().then((doc) async {
      final player = Player.fromJson(doc.data()!, doc.id);
      player.photoUrl = url;
      await updatePlayer(player: player);
    });
  }

  Future<void> clearPhotoUrl({required String playerId}) async {
    final playerRef = _db.doc(playerPath(playerId));
    playerRef.get().then((doc) async {
      final player = Player.fromJson(doc.data()!, doc.id);
      player.photoUrl = null;
      await updatePlayer(player: player);
    });
  }

  Future<Player?> fetchPlayer(String playerId) async {
    final ref = _db.collection(playersPath).doc(playerId).withConverter(
          fromFirestore: (snapshot, _) =>
              Player.fromJson(snapshot.data()!, snapshot.id),
          toFirestore: (player, _) => player.toJson(),
        );
    final snapshot = await ref.get();
    return snapshot.data();
  }

  Stream<Player> watchPlayer(String playerId) => _db
      .doc(playerPath(playerId))
      .withConverter(
          fromFirestore: (snapshot, _) =>
              Player.fromJson(snapshot.data()!, snapshot.id),
          toFirestore: (player, _) => player.toJson())
      .snapshots()
      .map((snapshot) => snapshot.data()!);
}

/// Riverpod providers
final playersRepositoryProvider = Provider<PlayersRepository>((ref) {
  final db = ref.watch(firebaseDatabaseProvider);
  return PlayersRepository(db);
});

// Watch all players with live updates and dispose when done
final playersStreamProvider = StreamProvider.autoDispose<List<Player>>((ref) {
  return ref.watch(playersRepositoryProvider).watchPlayers();
});

final playerStreamProvider = StreamProvider.autoDispose<Player>((ref) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot be null');
  }
  return ref.watch(playersRepositoryProvider).watchPlayer(user.uid);
});

final fetchPlayerProvider = FutureProvider<Player?>((ref) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot be null');
  }
  return ref.watch(playersRepositoryProvider).fetchPlayer(user.uid);
});

final setDisplayNameProvider =
    Provider.family<Future<void>, String>((ref, displayName) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot be null when setting display name');
  }
  return ref
      .watch(playersRepositoryProvider)
      .setDisplayName(playerId: user.uid, displayName: displayName);
});

final setSelectedCorpsProvider =
    Provider.family<Future<void>, DrumCorps>((ref, selectedCorps) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot be null when setting display name');
  }
  return ref
      .watch(playersRepositoryProvider)
      .setSelectedCorps(playerId: user.uid, corps: selectedCorps);
});

final setPhotoUrlProvider = Provider.family<Future<void>, String>((ref, url) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot be null when setting display name');
  }
  return ref
      .watch(playersRepositoryProvider)
      .setPhotoUrl(playerId: user.uid, url: url);
});

final clearPhotoUrlProvider = Provider<Future<void>>((ref) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot be null when setting display name');
  }
  return ref.watch(playersRepositoryProvider).clearPhotoUrl(playerId: user.uid);
});

final fetchCurrentPlayerProvider = FutureProvider<Player?>((ref) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot be null when setting display name');
  }
  return ref.watch(playersRepositoryProvider).fetchPlayer(user.uid);
});
