import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'players_repository.g.dart';

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

  Future<void> updatePlayer({required Player player}) async {
    return _db.doc(playerPath(player.playerId!)).update(player.toJson());
  }

  Future<void> setDisplayName(
      {required String playerId, required String displayName}) async {
    final playerRef = _db.doc(playerPath(playerId));
    playerRef.get().then((doc) async {
      final player = Player.fromJson(doc.data()!, doc.id);
      await updatePlayer(player: player.copyWith(displayName: displayName));
    });
  }

  Future<void> setSelectedCorps(
      {required String playerId, required DrumCorps corps}) async {
    final playerRef = _db.doc(playerPath(playerId));
    playerRef.get().then((doc) async {
      final player = Player.fromJson(doc.data()!, doc.id);
      await updatePlayer(player: player.copyWith(selectedCorps: corps));
    });
  }

  Future<void> setPhotoUrl(
      {required String playerId, required String url}) async {
    final playerRef = _db.doc(playerPath(playerId));
    playerRef.get().then((doc) async {
      final player = Player.fromJson(doc.data()!, doc.id);
      await updatePlayer(player: player.copyWith(photoUrl: url));
    });
  }

  Future<void> clearPhotoUrl({required String playerId}) async {
    final playerRef = _db.doc(playerPath(playerId));
    playerRef.get().then((doc) async {
      final player = Player.fromJson(doc.data()!, doc.id);
      await updatePlayer(player: player.copyWith(photoUrl: null));
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

  Stream<Player?> watchPlayer(String playerId) => _db
      .doc(playerPath(playerId))
      .withConverter(
          fromFirestore: (snapshot, _) =>
              Player.fromJson(snapshot.data()!, snapshot.id),
          toFirestore: (player, _) => player.toJson())
      .snapshots()
      .map((snapshot) => snapshot.data()!);
}

@riverpod
FirebaseFirestore firebaseFirestore(FirebaseFirestoreRef ref) =>
    FirebaseFirestore.instance;

@riverpod
PlayersRepository playersRepository(PlayersRepositoryRef ref) =>
    PlayersRepository(ref.watch(firebaseFirestoreProvider));

@riverpod
Stream<Player?> playerStream(PlayerStreamRef ref) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('Player cannot be null');
  }
  return ref.watch(playersRepositoryProvider).watchPlayer(user.uid);
}

@riverpod
Stream<Player?> playerStreamById(PlayerStreamByIdRef ref, String id) {
  return ref.watch(playersRepositoryProvider).watchPlayer(id);
}

@riverpod
Future<void> setDisplayName(SetDisplayNameRef ref,
    {required String displayName}) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot be null when setting display name');
  }
  return ref
      .watch(playersRepositoryProvider)
      .setDisplayName(playerId: user.uid, displayName: displayName);
}

@riverpod
Future<void> setSelectedCorps(SetSelectedCorpsRef ref,
    {required DrumCorps selectedCorps}) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot be null when setting display name');
  }
  return ref
      .watch(playersRepositoryProvider)
      .setSelectedCorps(playerId: user.uid, corps: selectedCorps);
}

@riverpod
Future<void> setPhotoUrl(SetPhotoUrlRef ref, {required String url}) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot be null when setting display name');
  }
  return ref
      .watch(playersRepositoryProvider)
      .setPhotoUrl(playerId: user.uid, url: url);
}

@riverpod
Future<void> clearPhotoUrl(ClearPhotoUrlRef ref) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot be null when setting display name');
  }
  return ref.watch(playersRepositoryProvider).clearPhotoUrl(playerId: user.uid);
}
