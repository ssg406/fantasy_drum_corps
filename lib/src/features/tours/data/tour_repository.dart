import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides CRUD functionality for player tours. Data saved to and served from
/// Firebase Firestore database
class ToursRepository {
  const ToursRepository(this._database);

  final FirebaseFirestore _database;

  static String tourPath(String tourId) => 'tours/$tourId';

  static String toursPath = 'tours';

  // Return Firestore query with converter for league collection
  Query<Tour> queryTours() => _database.collection(toursPath).withConverter(
        fromFirestore: (snapshot, _) =>
            Tour.fromJson(snapshot.data()!, snapshot.id),
        toFirestore: (league, _) => league.toJson(),
      );

  // Create league
  Future<void> addTour(Tour tour) {
    return _database.collection(toursPath).add(tour.toJson());
  }

  // Update a league
  Future<void> updateTour(Tour tour) {
    return _database.doc(tourPath(tour.id!)).update(tour.toJson());
  }

  // Delete league
  Future<void> deleteTour({required TourID id, required String userId}) async {
    //Check user is deleting their own tour
    final tourRef = _database.doc(tourPath(id));
    tourRef.get().then((doc) {
      final tour = Tour.fromJson(doc.data()!, doc.id);
      if (tour.owner != userId) {
        throw AssertionError('User can only delete their own tours');
      }
    });
    await tourRef.delete();
  }

  // Add user to tour
  Future<void> addPlayerToTour(
      {required TourID tourId, required String playerId}) async {
    final tourRef = _database.doc(tourPath(tourId));
    tourRef.get().then((doc) async {
      final tour = Tour.fromJson(doc.data()!, doc.id);
      // TODO validate tour size
      tour.addPlayer(playerId);
      await updateTour(tour);
    });
  }

  // Get single league document as stream
  Stream<Tour> watchTour({required TourID tourId}) => _database
      .doc(tourPath(tourId))
      .withConverter<Tour>(
        fromFirestore: (snapshot, _) =>
            Tour.fromJson(snapshot.data()!, snapshot.id),
        toFirestore: (tour, _) => tour.toJson(),
      )
      .snapshots()
      .map((snapshot) => snapshot.data()!);

  // Query either all leagues or only public leagues
  Stream<List<Tour>> watchTours(bool watchPublicOnly) {
    Query<Tour> query = queryTours();
    if (watchPublicOnly) {
      query = query.where('isPublic', isEqualTo: true);
    }
    return query
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  // Stream tours associated with user
  Stream<List<Tour>> watchJoinedTours(String userId) {
    return queryTours().snapshots().map((snapshot) => snapshot.docs
        .map((doc) => doc.data())
        .where((tour) => tour.members.contains(userId))
        .toList());
  }

  Stream<List<Tour>> watchOwnTours(String userId) {
    return queryTours().snapshots().map((snapshot) => snapshot.docs
        .map((doc) => doc.data())
        .where((tour) => tour.owner == userId)
        .toList());
  }

  // Get list of all leagues
  Future<List<Tour>> fetchTours() async {
    final tours = await queryTours().get();
    return tours.docs.map((doc) => doc.data()).toList();
  }

  // Fetch single tour
  Future<Tour?> fetchTour({required String tourId}) async {
    final ref = _database.collection(toursPath).doc(tourId).withConverter(
      fromFirestore: (snapshot, _) =>
          Tour.fromJson(snapshot.data()!, snapshot.id),
      toFirestore: (tour, _) => tour.toJson(),
    );
    final snapshot = await ref.get();
    return snapshot.data();
}
}

/// Providers
final firebaseDatabaseProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final toursRepositoryProvider = Provider<ToursRepository>(
    (ref) => ToursRepository(ref.watch(firebaseDatabaseProvider)));

final addPlayerToTourProvider =
    Provider.family.autoDispose<Future<void>, String>((ref, tourId) {
  final user = ref.watch(authDatabaseProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot  be null when joining tours');
  }
  return ref
      .watch(toursRepositoryProvider)
      .addPlayerToTour(tourId: tourId, playerId: user.uid);
});

final joinedToursStreamProvider = StreamProvider.autoDispose<List<Tour>>((ref) {
  final user = ref.watch(authDatabaseProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot  be null when finding tours');
  }
  return ref.watch(toursRepositoryProvider).watchJoinedTours(user.uid);
});

final ownedToursStreamProvider = StreamProvider.autoDispose<List<Tour>>((ref) {
  final user = ref.watch(authDatabaseProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot be null when querying tours');
  }
  return ref.watch(toursRepositoryProvider).watchOwnTours(user.uid);
});

final tourStreamProvider =
    StreamProvider.autoDispose.family<Tour, TourID>((ref, tourId) {
  final user = ref.watch(authDatabaseProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot be null when streaming league data');
  }
  final repository = ref.watch(toursRepositoryProvider);
  return repository.watchTour(tourId: tourId);
});

final allToursStreamProvider =
    StreamProvider.autoDispose.family<List<Tour>, bool>((ref, watchPublicOnly) {
  return ref.watch(toursRepositoryProvider).watchTours(watchPublicOnly);
});

final fetchTourProvider = FutureProvider.autoDispose.family<Tour?, String>((ref, tourId) {
  return ref.read(toursRepositoryProvider).fetchTour(tourId: tourId);
});
