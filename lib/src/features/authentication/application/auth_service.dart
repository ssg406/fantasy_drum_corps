import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/authentication/oauth_provider.dart';
import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

/// Auth service interacts with both auth repository and players repository
/// to create player data that is not related to authentication in a
/// separate repository
class AuthService {
  const AuthService(
    this._authRepo,
    this._playersRepo,
  );

  final AuthRepository _authRepo;
  final PlayersRepository _playersRepo;

  // Remove user and associated data
  Future<void> deleteCurrentUser() async {
    final user = _authRepo.currentUser;
    if (user != null) {
      await _playersRepo.deletePlayer(user.uid);
      user.delete();
    }
  }

  // Create a new user and save to Firebase auth and player repository
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final credential =
        await _authRepo.createUserWithEmailAndPassword(email, password);
    if (credential.user != null) {
      final player = Player(playerId: credential.user!.uid);
      _playersRepo.addPlayer(player);
      credential.user?.sendEmailVerification();
    }
  }

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) {
    return _authRepo.signInWithEmailAndPassword(email, password);
  }

  // Sign in with Google
  Future<void> registerWithOAuthProvider(OAuthSignInProvider provider) async {
    _authRepo.signInWithOAuthProvider(provider).then((credential) {
      if (credential.user == null) {
        throw StateError('User cannot be null');
      }
      _playersRepo.fetchPlayer(credential.user!.uid).then((player) {
        if (player == null) {
          final player = Player(
            playerId: credential.user!.uid,
            displayName: credential.user?.displayName,
          );
          _playersRepo.addPlayer(player);
        }
      });
    });
  }

  // Return if Google is auth provider or not
  bool getUserProvider() {
    final user = _authRepo.currentUser;
    if (user == null) {
      throw AssertionError('User cannot be null when checking auth provider');
    }
    for (final userInfo in user.providerData) {
      if (userInfo.providerId == GoogleAuthProvider.PROVIDER_ID ||
          userInfo.providerId == FacebookAuthProvider.PROVIDER_ID) {
        return true;
      }
    }
    return false;
  }
}

@riverpod
AuthService authService(AuthServiceRef ref) => AuthService(
    ref.watch(authRepositoryProvider), ref.watch(playersRepositoryProvider));
