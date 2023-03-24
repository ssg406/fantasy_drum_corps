import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  const AuthRepository(this._auth);

  final FirebaseAuth _auth;

  User? get currentUser => _auth.currentUser;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Stream<User?> userChanges() => _auth.userChanges();

  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> setEmail(String newEmail, String password) async {
    final user = _auth.currentUser;
    if (user != null) {
      final validated = await _validatePassword(password);
      return user.updateEmail(newEmail);
    } else {
      throw AssertionError('User cannot be null when updating email');
    }
  }

  Future<bool> _validatePassword(String password) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw AssertionError('User cannot be null when updating password');
    }
    final authCredential =
        EmailAuthProvider.credential(email: user.email!, password: password);
    final authResult = await user.reauthenticateWithCredential(authCredential);
    return authResult.user != null;
  }

  Future<void> setPassword(
      {required String oldPassword, required String newPassword}) async {
    final user = _auth.currentUser;
    if (user != null) {
      final validated = await _validatePassword(oldPassword);
      return user.updatePassword(newPassword);
    } else {
      throw AssertionError('User cannot be null when updating password.');
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    if (kIsWeb) {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      googleProvider.addScope('email');
      return await _auth.signInWithPopup(googleProvider);
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
      return await _auth.signInWithCredential(credential);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

/// Provider for Firebase Auth Instance
final authDatabaseProvider = Provider<FirebaseAuth>((ref) {
  final auth = FirebaseAuth.instance;
  auth.setPersistence(Persistence.LOCAL);
  return auth;
});

/// Provider for [AuthRepository]
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(authDatabaseProvider));
});

/// Provider for Stream of [User?] that changes when authorization state
/// changes
final authStateChangesProvider = StreamProvider.autoDispose<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});

/// Provider for Stream of [User?] that updates on ID token changes as
/// well as auth state changes.
final authDetailsChangesProvider = StreamProvider.autoDispose<User?>((ref) {
  return ref.watch(authRepositoryProvider).userChanges();
});

/// Provider for Stream of [User?] that updates on all auth state changes, ID
/// token changes, and user profile changes
final userChangesProvider = StreamProvider.autoDispose<User?>((ref) {
  return ref.watch(authDatabaseProvider).userChanges();
});
