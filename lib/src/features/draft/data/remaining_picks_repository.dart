import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasy_drum_corps/src/features/draft/domain/remaining_picks.dart';
import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remaining_picks_repository.g.dart';

class RemainingPicksRepository {
  const RemainingPicksRepository(this.db);

  final FirebaseFirestore db;

  static const remainingPicksPath = 'remainingPicks';

  static String remainingPickPath(String id) => 'remainingPicks/$id';

  Future<void> updateRemainingPicks(RemainingPicks remainingPicks) => db
      .doc(remainingPickPath(remainingPicks.id!))
      .update(remainingPicks.toJson());

  Future<RemainingPicks?> fetchTourRemainingPicks(String tourId) async {
    final remainingPicks = await db
        .collection(remainingPicksPath)
        .withConverter(
          fromFirestore: (snapshot, _) =>
              RemainingPicks.fromJson(snapshot.data()!, snapshot.id),
          toFirestore: (remainingPick, _) => remainingPick.toJson(),
        )
        .where('tourId', isEqualTo: tourId)
        .get();
    return remainingPicks.docs.map((doc) => doc.data()).first;
  }

  Future<void> deleteTourRemainingPicks(String tourId) async {
    db
        .collection(remainingPicksPath)
        .where('tourId', isEqualTo: tourId)
        .get()
        .then((querySnapshot) {
      for (final doc in querySnapshot.docs) {
        doc.reference.delete();
      }
    });
  }
}

@riverpod
RemainingPicksRepository remainingPicksRepository(
        RemainingPicksRepositoryRef ref) =>
    RemainingPicksRepository(ref.watch(firebaseFirestoreProvider));

@riverpod
Future<RemainingPicks?> fetchTourRemainingPicks(
    FetchTourRemainingPicksRef ref, String tourId) async {
  return ref
      .read(remainingPicksRepositoryProvider)
      .fetchTourRemainingPicks(tourId);
}
