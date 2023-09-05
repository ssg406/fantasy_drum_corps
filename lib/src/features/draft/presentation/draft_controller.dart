import 'package:fantasy_drum_corps/src/features/draft/application/socket_service.dart';
import 'package:fantasy_drum_corps/src/features/draft/domain/draft_state.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_model.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/draft_data.dart';

part 'draft_controller.g.dart';

@riverpod
class DraftController extends _$DraftController {
  @override
  DraftState build() {
    final socketService = ref.watch(socketServiceProvider);
    socketService.onDraftCancelled();
    socketService.onDraftOver();
    socketService.onDraftStarted();
    socketService.onRoomCreated();
    socketService.onRoomJoined();
    socketService.onPlayerMissedTurn();
    socketService.onServerEndTurn();
    socketService.onServerError();
    socketService.onUpdateJoinedPlayers();
    socketService.onTurnStarted();
    ref.listen(socketServiceStreamProvider, (_, data) {
      final draftData = data.value;
      final tempState = state.copyWith(isLoading: true);
      if (draftData is StartOfTurn) {
        state = tempState.copyWith(
          roundNumber: draftData.roundNumber,
          availablePicks: draftData.availablePicks,
          currentPlayerName: draftData.currentPlayerName,
          nextPlayerName: draftData.nextPlayerName,
          currentPlayerId: draftData.currentPlayerId,
          remainingTime: 45,
        );
      }
      if (draftData is RoomCreated) {
        state = tempState.copyWith(
          roomCreated: draftData.roomCreated,
        );
      }
      if (draftData is AllPlayersReady) {
        state = tempState.copyWith(
          allPlayersReady: draftData.allPlayersReady,
        );
      }
      if (draftData is DraftStarted) {
        state = tempState.copyWith(draftStarted: draftData.draftStarted);
      }
      if (draftData is JoinedRoom) {
        state = tempState.copyWith(
          joinedRoom: draftData.joinedRoom,
        );
      }
      if (draftData is MissedTurn) {
        _playerMissedTurn();
      }
      if (draftData is EndOfTurn) {
        state = tempState.copyWith(
          lastPick: draftData.captionPick,
        );
      }
      if (draftData is DraftError) {
        state = tempState.copyWith(
          draftError: true,
          errorMessage: draftData.errorMessage,
        );
      }
      if (draftData is UpdateJoinedPlayers) {
        state = tempState.copyWith(joinedPlayers: draftData.joinedPlayers);
      }
      state = state.copyWith(isLoading: false);
    });

    final Lineup playerLineup = {};
    // Set empty lineup
    for (final caption in Caption.values) {
      playerLineup.addAll({caption: null});
    }

    return DraftState(
      roundNumber: 0,
      availablePicks: [],
      playerLineup: playerLineup,
      alreadySelectedCorps: [],
    );
  }

  void dispose() {
    ref.watch(socketServiceProvider).disposeSocket();
  }

  void joinRoom(
      {required String playerId,
      required String tourId,
      required String action}) {
    ref.watch(socketServiceProvider).clientJoinRoom(playerId, tourId, action);
  }

  void leaveRoom() {
    ref.watch(socketServiceProvider).playerLeavesRoom();
  }

  void clientReadyForDraft() =>
      ref.watch(socketServiceProvider).clientReadyForDraft();

  void playerEndTurn(DrumCorpsCaption pick) =>
      ref.watch(socketServiceProvider).playerEndTurn(pick);

  void playerLineupComplete() =>
      ref.watch(socketServiceProvider).playerLineupComplete();

  void ownerBeginDraft() => ref.watch(socketServiceProvider).ownerBeginDraft();

  void ownerCancelDraft() =>
      ref.watch(socketServiceProvider).ownerCancelDraft();

  void playerSendsAutoPick(DrumCorpsCaption pick) =>
      ref.watch(socketServiceProvider).playerSendsAutoPick(pick);

  void onCaptionSelected(DrumCorpsCaption pick) {
    if (state.playerLineup[pick.caption] != null) {
      state = state.copyWith(
          draftError: true,
          errorMessage: 'No ${pick.caption.fullName} slot available');
    }
    if (state.alreadySelectedCorps.contains(pick.corps)) {
      state = state.copyWith(
          draftError: true,
          errorMessage:
              'You already have ${pick.corps.fullName} in your lineup.');
    }

    final alreadySelectedCorps = state.alreadySelectedCorps;
    final playerLineup = state.playerLineup;
    alreadySelectedCorps.add(pick.corps);
    playerLineup.addAll({pick.caption: pick.corps});

    state = state.copyWith(
        alreadySelectedCorps: alreadySelectedCorps, playerLineup: playerLineup);

    ref.watch(socketServiceProvider).playerEndTurn(pick);

    _checkLineupComplete();
  }

  int _getOpenLineupSlots() => state.playerLineup.values.fold(
      0, (previousValue, element) => previousValue + (element == null ? 1 : 0));

  void _playerMissedTurn() {
    // Create a list of indexes representing positions in availableCaptions
    final availableCaptionsIndices =
        List.generate(state.availablePicks.length, (index) => index);

    // Shuffle the list
    availableCaptionsIndices.shuffle();

    for (final pickIndex in availableCaptionsIndices) {
      // Get the DrumCorpsCaption pick from the available captions
      final pick = state.availablePicks[pickIndex];

      // Check if pick corps already exists in lineup
      if (state.alreadySelectedCorps.contains(pick.corps)) continue;

      // Determine if the slot at this caption is available, continue if not
      if (state.playerLineup[pick.caption] != null) continue;

      final lineup = state.playerLineup;

      // Execute the logic for adding a pick to the lineup
      lineup.addAll({pick.caption: pick.corps});
      state = state.copyWith(playerLineup: lineup);

      // Add the selection to list of already picked corps
      state.alreadySelectedCorps.add(pick.corps);

      // Emit the auto selected pick
      ref.watch(socketServiceProvider).playerSendsAutoPick(pick);

      // Exit the loop if a selection was made.
      break;
    }
    _checkLineupComplete();
  }

  void _checkLineupComplete() {
    if (_getOpenLineupSlots() != 0) return;
    ref.watch(socketServiceProvider).playerLineupComplete();

    state = state.copyWith(lineupComplete: true);
  }
}
