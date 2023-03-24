import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  // Create a new user
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final credential =
        await _authRepo.createUserWithEmailAndPassword(email, password);
    if (credential.user != null) {
      final player = Player(playerId: credential.user!.uid);
      _playersRepo.addPlayer(player);
    }
  }

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) {
    return _authRepo.signInWithEmailAndPassword(email, password);
  }

  // Sign in with Google
  Future<void> registerWithGoogle({required String displayName}) async {
    final credential = await _authRepo.signInWithGoogle();
    if (credential.user != null) {
      final player =
          Player(playerId: credential.user!.uid, displayName: displayName);
      _playersRepo.addPlayer(player);
    }
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  final playersRepo = ref.watch(playersRepositoryProvider);
  return AuthService(authRepo, playersRepo);
});
