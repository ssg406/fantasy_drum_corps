import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasy_drum_corps/src/features/admin/domain/corps_score.dart';
import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'score_repository.g.dart';

class ScoresRepository {
  const ScoresRepository(this.db);

  final FirebaseFirestore db;

  static String corpsScoresPath = 'corpsScores';

  static String corpsScorePath(String id) => 'corpsScores/$id';

  Future<void> addScore(CorpsScore corpsScore) {
    return db.collection(corpsScoresPath).add(corpsScore.toJson());
  }

  Future<void> updateScore(CorpsScore corpsScore) =>
      db.doc(corpsScorePath(corpsScore.id!)).update(corpsScore.toJson());

  Stream<List<CorpsScore>> watchAllCorpsScores() => db
      .collection(corpsScoresPath)
      .withConverter(
        fromFirestore: (snapshot, _) =>
            CorpsScore.fromJson(snapshot.data()!, snapshot.id),
        toFirestore: (corpsScore, _) => corpsScore.toJson(),
      )
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  Stream<CorpsScore> watchCorpsScore(String id) => db
      .doc(corpsScorePath(id))
      .withConverter(
        fromFirestore: (snapshot, _) =>
            CorpsScore.fromJson(snapshot.data()!, snapshot.id),
        toFirestore: (corpsScore, _) => corpsScore.toJson(),
      )
      .snapshots()
      .map((snapshot) => snapshot.data()!);
}

@riverpod
ScoresRepository scoresRepository(ScoresRepositoryRef ref) =>
    ScoresRepository(ref.watch(firebaseFirestoreProvider));

@riverpod
Stream<List<CorpsScore>> watchAllCorpsScore(WatchAllCorpsScoreRef ref) =>
    ref.watch(scoresRepositoryProvider).watchAllCorpsScores();

@riverpod
Stream<CorpsScore> watchCorpsScore(WatchCorpsScoreRef ref, String id) =>
    ref.watch(scoresRepositoryProvider).watchCorpsScore(id);
