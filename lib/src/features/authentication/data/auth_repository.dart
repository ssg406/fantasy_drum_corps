import 'package:fantasy_drum_corps/src/features/authentication/oauth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

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

  Future<void> sendPasswordResetEmail(String email) =>
      _auth.sendPasswordResetEmail(email: email);

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> setEmail(String newEmail, String password) async {
    final user = _auth.currentUser;
    if (user != null) {
      await validatePassword(password);
      return user.updateEmail(newEmail);
    } else {
      throw AssertionError('User cannot be null when updating email');
    }
  }

  Future<bool> validatePassword(String password) async {
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
      await validatePassword(oldPassword);
      return user.updatePassword(newPassword);
    } else {
      throw AssertionError('User cannot be null when updating password.');
    }
  }

  Future<UserCredential> signInWithOAuthProvider(
      OAuthSignInProvider provider) async {
    switch (provider) {
      case OAuthSignInProvider.google:
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider.addScope('email');

        if (kIsWeb) {
          return await _auth.signInWithPopup(googleProvider);
        }
        return await _auth.signInWithProvider(googleProvider);

      case OAuthSignInProvider.facebook:
        FacebookAuthProvider facebookProvider = FacebookAuthProvider();
        facebookProvider.addScope('public_profile');
        facebookProvider.addScope('email');
        return await _auth.signInWithPopup(facebookProvider);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<bool> get currentUserIsAdmin async {
    final user = _auth.currentUser;
    if (user == null) {
      throw AssertionError('User cannot be null when getting claims');
    }
    final idTokenResult = await user.getIdTokenResult();
    return idTokenResult.claims == null
        ? false
        : idTokenResult.claims!['admin'] == true;
  }
}

@riverpod
FirebaseAuth firebaseAuth(FirebaseAuthRef ref) {
  final auth = FirebaseAuth.instance;
  auth.setPersistence(Persistence.LOCAL);
  return auth;
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) =>
    AuthRepository(ref.watch(firebaseAuthProvider));

@riverpod
Stream<User?> userChangesStream(UserChangesStreamRef ref) =>
    ref.watch(authRepositoryProvider).userChanges();

@riverpod
Future<bool> currentUserIsAdmin(CurrentUserIsAdminRef ref) async =>
    ref.watch(authRepositoryProvider).currentUserIsAdmin;
