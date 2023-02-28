import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasy_drum_corps/src/features/leagues/data/league_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  const AuthRepository(this._auth);
  final FirebaseAuth _auth;

  User? get currentUser => _auth.currentUser;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signInWithGoogle() async {
    if (kIsWeb) {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      googleProvider.addScope('email');
      await _auth.signInWithPopup(googleProvider);
    } else {
      // Trigger authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain auth details from request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Complete authentication with firebase
      await _auth.signInWithCredential(credential);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

final authDatabaseProvider = Provider<FirebaseAuth>((ref) {
  final auth = FirebaseAuth.instance;
  auth.setPersistence(Persistence.LOCAL);
  return auth;
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(authDatabaseProvider));
});

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});
