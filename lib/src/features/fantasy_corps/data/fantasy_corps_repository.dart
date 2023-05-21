import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fantasy_corps_repository.g.dart';

class FantasyCorpsRepository {
  const FantasyCorpsRepository(this._database);

  final FirebaseFirestore _database;

  static String userFantasyCorpsPath(String fantasyCorpsId) =>
      'fantasyCorps/$fantasyCorpsId';

  static String fantasyCorpsPath = 'fantasyCorps';

  Query<FantasyCorps> queryFantasyCorps() =>
      _database.collection(fantasyCorpsPath).withConverter(
            fromFirestore: (snapshot, _) =>
                FantasyCorps.fromJson(snapshot.data()!, snapshot.id),
            toFirestore: (fantasyCorps, _) => fantasyCorps.toJson(),
          );

  Future<void> addFantasyCorps(FantasyCorps fantasyCorps) =>
      _database.collection(fantasyCorpsPath).add(fantasyCorps.toJson());

  Future<void> updateFantasyCorps(FantasyCorps fantasyCorps) => _database
      .doc(userFantasyCorpsPath(fantasyCorps.fantasyCorpsId!))
      .update(fantasyCorps.toJson());

  Stream<List<FantasyCorps>> watchAllFantasyCorps({String? tourId}) {
    Query<FantasyCorps> query = queryFantasyCorps();
    if (tourId != null) {
      query = query.where('tourId', isEqualTo: tourId);
    }

    return query
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Stream<List<FantasyCorps>> watchUserFantasyCorps(String userId) =>
      queryFantasyCorps()
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  Stream<FantasyCorps?> watchFantasyCorps(String fantasyCorpsId) => _database
      .doc(userFantasyCorpsPath(fantasyCorpsId))
      .withConverter(
          fromFirestore: (snapshot, _) =>
              FantasyCorps.fromJson(snapshot.data()!, snapshot.id),
          toFirestore: (fantasyCorps, _) => fantasyCorps.toJson())
      .snapshots()
      .map((snapshot) => snapshot.data());
}

@riverpod
FantasyCorpsRepository fantasyCorpsRepository(FantasyCorpsRepositoryRef ref) =>
    FantasyCorpsRepository(ref.watch(firebaseFirestoreProvider));

@riverpod
Stream<List<FantasyCorps>> watchAllFantasyCorps(WatchAllFantasyCorpsRef ref) {
  return ref.watch(fantasyCorpsRepositoryProvider).watchAllFantasyCorps();
}

@riverpod
Stream<List<FantasyCorps>> watchTourFantasyCorps(
    WatchTourFantasyCorpsRef ref, String tourId) {
  return ref
      .watch(fantasyCorpsRepositoryProvider)
      .watchAllFantasyCorps(tourId: tourId);
}

@riverpod
Stream<List<FantasyCorps>> watchUserFantasyCorps(WatchUserFantasyCorpsRef ref) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot be null when accessing Fantasy Corps');
  }
  return ref
      .watch(fantasyCorpsRepositoryProvider)
      .watchUserFantasyCorps(user.uid);
}
