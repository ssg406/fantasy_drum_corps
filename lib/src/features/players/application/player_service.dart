import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player_service.g.dart';

class PlayerService {
  const PlayerService(this._authRepo, this._playerRepo);

  final AuthRepository _authRepo;
  final PlayersRepository _playerRepo;

  Future<void> setDisplayName(String displayName) {
    final user = _authRepo.currentUser;
    if (user == null) {
      throw AssertionError(
          'Current user cannot be null when setting display name');
    }
    return _playerRepo.setDisplayName(
        playerId: user.uid, displayName: displayName);
  }

  Future<void> setAvatarString(String avatarString) {
    final user = _authRepo.currentUser;
    if (user == null) {
      throw AssertionError('Current user cannot be null when setting avatar');
    }
    return _playerRepo.setAvatarString(
        playerId: user.uid, avatarString: avatarString);
  }

  Future<void> setSelectedCorps(DrumCorps selectedCorps) {
    final user = _authRepo.currentUser;
    if (user == null) {
      throw AssertionError(
          'Current user cannot be null when setting photo URL');
    }
    return _playerRepo.setSelectedCorps(
        playerId: user.uid, corps: selectedCorps);
  }

  Future<String?> fetchDisplayName(String userId) async {
    final player = await _playerRepo.fetchPlayer(userId);
    return player?.displayName;
  }

  Future<bool> playerHasCompletedSignup() async {
    final currentUser = _authRepo.currentUser;
    if (currentUser == null) return false;
    final currentPlayer = await _playerRepo.fetchPlayer(currentUser.uid);
    if (currentPlayer == null) return false;

    final hasVerifiedEmail = currentUser.emailVerified;
    final hasDisplayName = currentPlayer.hasDisplayName;

    return hasVerifiedEmail && hasDisplayName;
  }
}

@riverpod
PlayerService playerService(PlayerServiceRef ref) {
  return PlayerService(
    ref.watch(authRepositoryProvider),
    ref.watch(playersRepositoryProvider),
  );
}

@Riverpod(keepAlive: false)
Future<bool> playerHasCompletedSignup(PlayerHasCompletedSignupRef ref) =>
    ref.watch(playerServiceProvider).playerHasCompletedSignup();
