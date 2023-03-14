import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/profile/domain/user_corps_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserCorpsRepository {
  const UserCorpsRepository(this._database);
  final FirebaseFirestore _database;

  static const String userCorpsPath = 'userCorps';
  String userCorpsDocPath(String userId) => 'userCorps/$userId';

  Query<UserCorps> queryUserCorps() =>
      _database.collection(userCorpsPath).withConverter(
          fromFirestore: (snapshot, _) => UserCorps.fromMap(snapshot.data()!),
          toFirestore: (userCorps, _) => userCorps.toMap());

  Future<void> addUserCorps(
      {required String userId, required String selectedCorps}) {
    // Set document with Id userId with value of selected corps
    return _database.collection(userCorpsPath).doc(userId).set({
      'userId': userId,
      'selectedCorps': selectedCorps,
    });
  }

  Future<String?> getSelectedCorps(String userId) {
    return _database
        .collection(userCorpsPath)
        .doc(userId)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        return UserCorps.fromMap(snapshot.data()!).selectedCorps;
      }
      return null;
    });
  }

  // Possibly unneeded based on business logic
  Future<void> deleteSelectedCorps({required String userId}) {
    return _database.doc(userCorpsDocPath(userId)).delete();
  }
}

/// Provides access to full CRUD operations of repository
final userCorpsRepositoryProvider = Provider<UserCorpsRepository>((ref) {
  final database = ref.watch(firebaseDatabaseProvider);
  return UserCorpsRepository(database);
});

final setUserSelectedCorpsProvider = Provider.family((ref, String selection) {
  final repository = ref.watch(userCorpsRepositoryProvider);
  final user = ref.watch(authDatabaseProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot be null when selecting sponsored league');
  }
  return repository.addUserCorps(userId: user.uid, selectedCorps: selection);
});

/// Returns a future of the currently selected corps if it exists
final selectedCorpsProvider = FutureProvider<String?>((ref) {
  final user = ref.watch(authDatabaseProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot be null when querying selected corps');
  }
  final repository = ref.watch(userCorpsRepositoryProvider);
  final selectedCorps = repository.getSelectedCorps(user.uid);
  return selectedCorps;
});
