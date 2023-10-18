import '../../fantasy_corps/domain/caption_model.dart';
import '../../players/domain/player_model.dart';

typedef JoinedPlayers = Map<Player, bool>;

sealed class DraftData {
  String? currentPlayerId;
  String? currentPlayerName;
  String? nextPlayerName;
  int? roundNumber;
  List<DrumCorpsCaption> availablePicks;
  JoinedPlayers joinedPlayers;
  DrumCorpsCaption? captionPick;
  String errorMessage;
  bool allPlayersReady;
  bool draftStarted;
  bool joinedRoom;
  bool roomCreated;
  bool missedTurn;
  bool draftCancelled;

  DraftData({
    this.currentPlayerId,
    this.currentPlayerName,
    this.nextPlayerName,
    this.roundNumber,
    this.availablePicks = const [],
    this.joinedPlayers = const {},
    this.captionPick,
    this.errorMessage = '',
    this.allPlayersReady = false,
    this.draftStarted = false,
    this.joinedRoom = false,
    this.roomCreated = false,
    this.missedTurn = false,
    this.draftCancelled = false,
  });
}

class AllPlayersReady extends DraftData {
  AllPlayersReady({super.allPlayersReady});
}

class DraftStarted extends DraftData {
  DraftStarted({super.draftStarted});
}

class JoinedRoom extends DraftData {
  JoinedRoom({super.joinedRoom});
}

class RoomCreated extends DraftData {
  RoomCreated({super.roomCreated});
}

class MissedTurn extends DraftData {
  MissedTurn({super.missedTurn});
}

class DraftCancelled extends DraftData {
  DraftCancelled({super.draftCancelled});
}

class UpdateJoinedPlayers extends DraftData {
  UpdateJoinedPlayers({super.joinedPlayers});
}

class StartOfTurn extends DraftData {
  StartOfTurn({
    super.roundNumber,
    super.availablePicks,
    super.currentPlayerId,
    super.currentPlayerName,
    super.nextPlayerName,
  });
}

class EndOfTurn extends DraftData {
  EndOfTurn({
    super.captionPick,
  });
}

class DraftError extends DraftData {
  DraftError({super.errorMessage});
}

class ServerError extends DraftData {
  ServerError({super.errorMessage});
}
