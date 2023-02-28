import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fantasy_drum_corps/src/features/authentication/domain/user_model.dart';
import 'package:fantasy_drum_corps/src/features/leagues/data/league_repository.dart';

/// Repository accesses users collection in Firestore to store
/// information in addition to what Firebase Auth captures
class UsersRepository {
  const UsersRepository(this._database);
  final FirebaseFirestore _database;

  static String userPath(UserID userId) => 'users/$userId';
  static String usersPath() => 'users';

  Query<FdcUser> queryUsers() =>
      _database.collection(usersPath()).withConverter(
            fromFirestore: (snapshot, _) =>
                FdcUser.fromMap(snapshot.data()!, snapshot.id),
            toFirestore: (fdcUser, _) => fdcUser.toMap(),
          );

  // Create new user
  Future<void> addUser(
      {required UserID id,
      required String email,
      required String displayName,
      required String sponsoredCorps,
      String? userAvatar}) {
    return _database.collection(usersPath()).doc(id).set({
      'email': email,
      'displayName': displayName,
      'sponsoredCorps': sponsoredCorps,
      'userAvatar': userAvatar,
    });
  }

  // Watch user
  Stream<FdcUser> watchUser({required UserID userId}) =>
    _database
      .doc(userPath(userId))
      .withConverter(
        fromFirestore: (snapshot, _) => FdcUser.fromMap(snapshot.data()!, snapshot.id),
        toFirestore: (fdcUser, _) => fdcUser.toMap()
    )
      .snapshots()
      .map((snapshot) => snapshot.data()!);

  // Watch users collection
  Stream<List<FdcUser>> watchUsers() {
    return queryUsers()
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  // Fetch list of users
  Future<List<FdcUser>> fetchUsers() async {
    final users = await queryUsers().get();
    return users.docs.map((doc) => doc.data()).toList();
  }
}

final usersRepositoryProvider = Provider<UsersRepository>(
    (ref) => UsersRepository(ref.watch(firebaseDatabaseProvider)));

final usersStreamProvider = StreamProvider.autoDispose<List<FdcUser>>((ref) {
  final user = ref.watch(authDatabaseProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot be null when querying user data');
  }
  final repository = ref.watch(usersRepositoryProvider);
  return repository.watchUsers();
});

final userStreamProvider = StreamProvider.autoDispose.family<FdcUser, UserID>((ref, userId) {
  final user = ref.watch(authDatabaseProvider).currentUser;
  if (user == null) {
    throw AssertionError('User cannot be null when querying user data');
  }
  final repository = ref.watch(usersRepositoryProvider);
  return repository.watchUser(userId: userId);
});
