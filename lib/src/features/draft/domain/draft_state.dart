import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_model.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';

import '../../fantasy_corps/domain/drum_corps_enum.dart';
import 'draft_data.dart';

class DraftState {
  const DraftState({
    required this.roundNumber,
    required this.availablePicks,
    this.joinedPlayers = const {},
    this.currentPlayerId,
    this.currentPlayerName,
    this.nextPlayerName,
    this.lastPick,
    required this.playerLineup,
    required this.alreadySelectedCorps,
    this.draftError = false,
    this.errorMessage,
    this.draftStarted = false,
    this.isLoading = false,
    this.joinedRoom = false,
    this.roomCreated = false,
    this.missedTurn = false,
    this.playerReady = false,
    this.allPlayersReady = false,
    this.draftCancelled = false,
    this.remainingTime = 45,
    this.lineupComplete = false,
  });

  final int roundNumber;
  final List<DrumCorpsCaption> availablePicks;
  final JoinedPlayers joinedPlayers;
  final String? currentPlayerId;
  final String? currentPlayerName;
  final String? nextPlayerName;
  final DrumCorpsCaption? lastPick;
  final Lineup playerLineup;
  final List<DrumCorps> alreadySelectedCorps;
  final bool draftError;
  final String? errorMessage;
  final bool draftStarted;
  final bool isLoading;
  final bool joinedRoom;
  final bool roomCreated;
  final bool missedTurn;
  final bool playerReady;
  final bool allPlayersReady;
  final bool draftCancelled;
  final int remainingTime;
  final bool lineupComplete;

  DraftState copyWith(
      {int? roundNumber,
      List<DrumCorpsCaption>? availablePicks,
      JoinedPlayers? joinedPlayers,
      String? currentPlayerId,
      String? currentPlayerName,
      String? nextPlayerName,
      DrumCorpsCaption? lastPick,
      Lineup? playerLineup,
      List<DrumCorps>? alreadySelectedCorps,
      bool? draftError,
      String? errorMessage,
      bool? draftStarted,
      bool? isLoading,
      bool? joinedRoom,
      bool? roomCreated,
      bool? missedTurn,
      bool? playerReady,
      bool? allPlayersReady,
      bool? draftCancelled,
      int? remainingTime,
      bool? lineupComplete}) {
    return DraftState(
      roundNumber: roundNumber ?? this.roundNumber,
      availablePicks: availablePicks ?? this.availablePicks,
      joinedPlayers: joinedPlayers ?? this.joinedPlayers,
      currentPlayerId: currentPlayerId ?? this.currentPlayerId,
      currentPlayerName: currentPlayerName ?? this.currentPlayerName,
      nextPlayerName: nextPlayerName ?? this.nextPlayerName,
      lastPick: lastPick ?? this.lastPick,
      playerLineup: playerLineup ?? this.playerLineup,
      alreadySelectedCorps: alreadySelectedCorps ?? this.alreadySelectedCorps,
      draftError: draftError ?? this.draftError,
      errorMessage: errorMessage ?? this.errorMessage,
      draftStarted: draftStarted ?? this.draftStarted,
      isLoading: isLoading ?? this.isLoading,
      joinedRoom: joinedRoom ?? this.joinedRoom,
      roomCreated: roomCreated ?? this.roomCreated,
      missedTurn: missedTurn ?? this.missedTurn,
      playerReady: playerReady ?? this.playerReady,
      allPlayersReady: allPlayersReady ?? this.allPlayersReady,
      draftCancelled: draftCancelled ?? this.draftCancelled,
      remainingTime: remainingTime ?? this.remainingTime,
      lineupComplete: lineupComplete ?? this.lineupComplete,
    );
  }

  @override
  String toString() {
    return 'DraftState {'
        'roundNumber: $roundNumber, '
        'availablePicks: $availablePicks, '
        'joinedPlayers: $joinedPlayers, '
        'currentPlayerId: $currentPlayerId, '
        'currentPlayerName: $currentPlayerName,'
        'nextPlayerName: $nextPlayerName, '
        'lastPick: $lastPick, '
        'playerLineup: $playerLineup, '
        'alreadySelectedCorps: $alreadySelectedCorps, '
        'draftError: $draftError, '
        'errorMessage: $errorMessage, '
        'draftStarted: $draftStarted, '
        'isLoading: $isLoading, '
        'joinedRoom: $joinedRoom, '
        'roomCreated: $roomCreated, '
        'missedTurn: $missedTurn, '
        'playerReady: $playerReady, '
        'allPlayersReady: $allPlayersReady, '
        'draftCancelled: $draftCancelled, '
        'remainingTime: $remainingTime, '
        'lineupComplete: $lineupComplete }';
  }
}
