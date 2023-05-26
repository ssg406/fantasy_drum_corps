import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tour_repository.g.dart';

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
  Future<void> deleteTour(
      {required TourID tourId, required String userId}) async {
    //Check user is deleting their own tour
    final tourRef = _database.doc(tourPath(tourId));
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
      tour.addPlayer(playerId);
      await updateTour(tour);
    });
  }

  Future<void> removePlayerFromTour(
      {required String tourId, required String playerId}) async {
    final tourRef = _database.doc(tourPath(tourId));
    tourRef.get().then((doc) async {
      final tour = Tour.fromJson(doc.data()!, doc.id);
      tour.removePlayerFromTour(playerId);
      await updateTour(tour);
    });
  }

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

  Stream<Tour?> watchTour(String tourId) => _database
      .doc(tourPath(tourId))
      .withConverter(
        fromFirestore: (snapshot, _) =>
            Tour.fromJson(snapshot.data()!, snapshot.id),
        toFirestore: (tour, _) => tour.toJson(),
      )
      .snapshots()
      .map((snapshot) => snapshot.data()!);

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

/// Generated Riverpod providers

@riverpod
FirebaseFirestore firebaseFirestore(FirebaseFirestoreRef ref) =>
    FirebaseFirestore.instance;

@riverpod
ToursRepository toursRepository(ToursRepositoryRef ref) =>
    ToursRepository(ref.watch(firebaseFirestoreProvider));

@riverpod
Stream<Tour?> watchTour(WatchTourRef ref, String tourId) =>
    ref.watch(toursRepositoryProvider).watchTour(tourId);

@riverpod
Future<Tour?> fetchTour(FetchTourRef ref, String tourId) =>
    ref.watch(toursRepositoryProvider).fetchTour(tourId: tourId);

@riverpod
Future<void> deleteTour(DeleteTourRef ref, String tourId) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot be null when deleting a tour');
  }
  return ref
      .read(toursRepositoryProvider)
      .deleteTour(userId: user.uid, tourId: tourId);
}

@riverpod
Stream<List<Tour>> watchJoinedTours(WatchJoinedToursRef ref) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot be null when accessing tours');
  }
  return ref.watch(toursRepositoryProvider).watchJoinedTours(user.uid);
}

@riverpod
Stream<List<Tour>> watchOwnedTours(WatchOwnedToursRef ref) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot be null when accessing tours');
  }
  return ref.watch(toursRepositoryProvider).watchOwnTours(user.uid);
}

@riverpod
Future<void> addSelfToTour(AddSelfToTourRef ref, String tourId) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot be null when modifying tours');
  }
  return ref
      .read(toursRepositoryProvider)
      .addPlayerToTour(tourId: tourId, playerId: user.uid);
}

@riverpod
Future<void> removeSelfFromTour(RemoveSelfFromTourRef ref, String tourId) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot be null when removing from tours');
  }
  return ref
      .read(toursRepositoryProvider)
      .removePlayerFromTour(tourId: tourId, playerId: user.uid);
}

@riverpod
Stream<List<Tour>> watchAllTours(WatchAllToursRef ref, bool watchPublicOnly) =>
    ref.watch(toursRepositoryProvider).watchTours(watchPublicOnly);
