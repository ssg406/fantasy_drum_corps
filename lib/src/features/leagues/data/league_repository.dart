import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasy_drum_corps/src/features/authentication/domain/user_model.dart';
import 'package:fantasy_drum_corps/src/features/leagues/domain/league_model.dart';
import 'package:fantasy_drum_corps/src/features/leagues/domain/league_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';

/// Provides CRUD functionality for player leagues
class LeaguesRepository {
  const LeaguesRepository(this._database);
  final FirebaseFirestore _database;

  static String leaguePath(String leagueId) => 'leagues/$leagueId';
  static String leaguesPath() => 'leagues';
  static String leagueUsersPath() => 'leagueUsers';

  // Return Firestore query for LeagueUser collection
  Query<LeagueUser> queryLeagueUsers() =>
      _database.collection(leagueUsersPath()).withConverter(
            fromFirestore: (snapshot, _) =>
                LeagueUser.fromMap(snapshot.data()!),
            toFirestore: (leagueUser, _) => leagueUser.toMap(),
          );

  // Return Firestore query with converter for league collection
  Query<League> queryLeagues() =>
      _database.collection(leaguesPath()).withConverter(
            fromFirestore: (snapshot, _) =>
                League.fromMap(snapshot.data()!, snapshot.id),
            toFirestore: (league, _) => league.toMap(),
          );

  // Create league
  Future<void> addLeague({required String leagueName, required bool isPublic}) {
    return _database.collection(leaguesPath()).add({
      'leagueName': leagueName,
      'isPublic': isPublic,
    });
  }

  // Update a league
  Future<void> updateLeague({required LeagueID id, required League league}) {
    return _database.doc(leaguePath(id)).update(league.toMap());
  }

  // Add player to league
  Future<void> addPlayerToLeague(
      {required LeagueID leagueId, required UserID userId}) {
    return _database.collection(leagueUsersPath()).add({
      'leagueId': leagueId,
      'userId': userId,
    });
  }

  // Remove player from league
  Future<void> removePlayerFromLeague(
      {required LeagueID leagueId, required UserID userId}) async {
    final leagueUsersRef = _database.collection(leagueUsersPath());
    final leaguePlayers = await leagueUsersRef.get();
    for (final snapshot in leaguePlayers.docs) {
      final leagueUser = LeagueUser.fromMap(snapshot.data());
      if (leagueUser.leagueId == leagueId && leagueUser.userId == userId) {
        await snapshot.reference.delete();
      }
    }
  }

  // Delete league
  Future<void> deleteLeague(
      {required LeagueID id, required UserID userId}) async {
    // Iterate through LeagueUser collection to remove entries associated
    // with leagueId
    final leagueUsersRef = _database.collection(leagueUsersPath());
    final leaguePlayers = await leagueUsersRef.get();
    for (final snapshot in leaguePlayers.docs) {
      final leagueUser = LeagueUser.fromMap(snapshot.data());
      if (leagueUser.leagueId == id) {
        await snapshot.reference.delete();
      }
    }

    //Check user is deleting their own league
    final leagueRef = _database.doc(leaguePath(id));
    leagueRef.get().then((doc) {
      final league = League.fromMap(doc.data()!, doc.get('leagueId'));
      if (league.owner != userId) {
        throw AssertionError('User can only delete their own leagues');
      }
    });
    await leagueRef.delete();
  }

  // Get single league document as stream
  Stream<League> watchLeague({required LeagueID leagueId}) => _database
      .doc(leaguePath(leagueId))
      .withConverter<League>(
        fromFirestore: (snapshot, _) =>
            League.fromMap(snapshot.data()!, snapshot.id),
        toFirestore: (league, _) => league.toMap(),
      )
      .snapshots()
      .map((snapshot) => snapshot.data()!);

  // Query either all leagues or only public leagues
  Stream<List<League>> watchLeagues(bool watchPublicOnly) {
    Query<League> query = queryLeagues();
    if (watchPublicOnly) {
      query = query.where('isPublic', isEqualTo: true);
    }
    return query
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  // Stream leagues associated with user
  Stream<List<League>> watchOwnLeagues(UserID userId) {
    // Retrieve list of leagueIds associated with user
    List<LeagueID> leagueIds = [];
    _database
        .collection(leagueUsersPath())
        .where('userId', isEqualTo: userId)
        .get()
        .then((querySnapshot) {
      for (final snapshot in querySnapshot.docs) {
        final leagueUser = LeagueUser.fromMap(snapshot.data());
        leagueIds.add(leagueUser.leagueId);
      }
    });
    return queryLeagues().snapshots().map((snapshot) => snapshot.docs
        .map((doc) => doc.data())
        .where((league) => leagueIds.contains(league.id))
        .toList());
  }

  // Get list of all leagues
  Future<List<League>> fetchLeagues() async {
    final leagues = await queryLeagues().get();
    return leagues.docs.map((doc) => doc.data()).toList();
  }
}

/// Providers

final firebaseDatabaseProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final leaguesRepositoryProvider = Provider<LeaguesRepository>(
    (ref) => LeaguesRepository(ref.watch(firebaseDatabaseProvider)));

final leaguesQueryProvider = Provider<Query<League>>((ref) {
  final user = ref.watch(authDatabaseProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot be null when querying leagues');
  }
  return ref.watch(leaguesRepositoryProvider).queryLeagues();
});

final leagueStreamProvider =
    StreamProvider.autoDispose.family<League, LeagueID>((ref, leagueId) {
  final user = ref.watch(authDatabaseProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot be null when streaming league data');
  }
  final repository = ref.watch(leaguesRepositoryProvider);
  return repository.watchLeague(leagueId: leagueId);
});
