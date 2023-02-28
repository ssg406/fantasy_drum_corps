import 'dart:async';

import 'package:fantasy_drum_corps/src/features/leagues/data/league_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Controller for [CreateLeague]
class CreateLeagueController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> submit(
      {required String leagueName, required bool isPublic}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _submitLeague(leagueName, isPublic));
  }

  Future<void> _submitLeague(String leagueName, bool isPublic) {
    final leagueRepository = ref.read(leaguesRepositoryProvider);
    return leagueRepository.addLeague(
        leagueName: leagueName, isPublic: isPublic);
  }
}

final createLeagueControllerProvider =
    AutoDisposeAsyncNotifierProvider(CreateLeagueController.new);
