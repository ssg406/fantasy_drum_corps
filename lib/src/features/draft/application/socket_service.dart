import 'dart:async';
import 'dart:developer' as dev;

import 'package:fantasy_drum_corps/src/features/draft/data/socket_client.dart';
import 'package:fantasy_drum_corps/src/features/draft/domain/draft_data.dart';
import 'package:fantasy_drum_corps/src/features/draft/domain/socket_events.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_model.dart';
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'socket_service.g.dart';

class SocketService {
  final SocketClient client;
  final socketResponseStream = StreamController<DraftData>();

  Stream<DraftData> get draftStream => socketResponseStream.stream;

  SocketService({
    required this.client,
  });

  // EMITTERS
  void disposeSocket() {
    dev.log('Disposing socket', name: 'Socket Service');
    client.socket.dispose();
  }

  void clientJoinRoom(String playerId, String tourId, String action) {
    client.socket.emit(CLIENT_REQUESTS_ROOM, {
      'playerId': playerId,
      'tourId': tourId,
      'action': action,
    });
  }

  void clientReadyForDraft() {
    dev.log('Emitting client ready for draft', name: 'Socket Service');
    client.socket.emit(CLIENT_READY_FOR_DRAFT);
  }

  void playerEndTurn(DrumCorpsCaption pick) {
    dev.log('Emitting client pick', name: 'Socket Service');
    client.socket.emit(CLIENT_PLAYER_ENDS_TURN, {'pick': pick.toJson()});
  }

  void playerLineupComplete() {
    dev.log('Emitting client lineup complete', name: 'Socket Service');
    client.socket.emit(CLIENT_LINEUP_COMPLETE);
  }

  void ownerBeginDraft() {
    dev.log('Emitting owner begin draft', name: 'Socket Service');
    client.socket.emit(CLIENT_OWNER_BEGIN_DRAFT);
  }

  void ownerCancelDraft() {
    dev.log('Emitting owner cancel draft', name: 'Socket Service');
    client.socket.emit(CLIENT_OWNER_CANCEL_DRAFT);
  }

  void playerSendsAutoPick(DrumCorpsCaption pick) {
    dev.log('Emitting player missed turn pick', name: 'Socket Service');
    client.socket.emit(CLIENT_SENDS_AUTO_PICK, {'pick': pick.toJson()});
  }

  void playerLeavesRoom() {
    dev.log('Emitting player leaving room', name: 'Socket Service');
    client.socket.emit(CLIENT_LEAVE_ROOM);
  }

  // LISTENERS
  void setListeners() {
    dev.log('Setting socket listeners', name: 'SocketService');
    onDraftCancelled();
    onDraftOver();
    onDraftStarted();
    onRoomCreated();
    onRoomJoined();
    onPlayerMissedTurn();
    onServerEndTurn();
    onServerError();
    onUpdateJoinedPlayers();
    onTurnStarted();
  }

  void onServerError() {
    client.socket.on(SERVER_ERROR, (data) {
      dev.log('Server error received', name: 'Socket Service');
      socketResponseStream
          .add(ServerError(errorMessage: data['errorMessage'] as String));
    });
  }

  void onRoomCreated() {
    client.socket.on(SERVER_ROOM_CREATED, (_) {
      dev.log('Received room created', name: 'Socket Service');
      socketResponseStream.add(RoomCreated(roomCreated: true));
    });
  }

  void onRoomJoined() {
    client.socket.on(SERVER_ROOM_JOINED, (_) {
      dev.log('Received room joined', name: 'Socket Service');
      socketResponseStream.add(JoinedRoom(joinedRoom: true));
    });
  }

  void onDraftStarted() {
    client.socket.on(SERVER_DRAFT_BEGIN, (_) {
      dev.log('Received draft begin', name: 'Socket Service');
      socketResponseStream.add(DraftStarted(draftStarted: true));
    });
  }

  void onDraftCancelled() {
    client.socket.on(SERVER_DRAFT_CANCELLED_BY_OWNER, (_) {
      dev.log('Received draft cancelled', name: 'Socket Service');
      socketResponseStream.add(DraftCancelled(draftCancelled: true));
    });
  }

  void onDraftOver() {
    client.socket.on(SERVER_DRAFT_OVER, (_) {
      dev.log('Received draft over', name: 'Socket Service');
      socketResponseStream.add(DraftStarted(draftStarted: false));
    });
  }

  void onUpdateJoinedPlayers() {
    client.socket.on(SERVER_UPDATE_JOINED_PLAYERS, (data) {
      dev.log('Received updated joined players', name: 'Socket Service');
      final playersFromServer = data['joinedPlayers'] as List<dynamic>;
      final Map<Player, bool> joinedPlayers = {};

      for (var playerEntry in playersFromServer) {
        final playerData = playerEntry['player'] as Map<String, dynamic>;
        final player = Player.fromJson(playerData, playerData['id']);
        final isReady = playerEntry['isReady'] as bool;
        joinedPlayers.addAll({player: isReady});
      }
      socketResponseStream
          .add(UpdateJoinedPlayers(joinedPlayers: joinedPlayers));
      final allPlayersReady =
          joinedPlayers.values.every((playerReady) => playerReady);
      if (allPlayersReady) {
        socketResponseStream.add(AllPlayersReady(allPlayersReady: true));
      } else {
        socketResponseStream.add(AllPlayersReady(allPlayersReady: false));
      }
    });
  }

  void onTurnStarted() {
    client.socket.on(SERVER_START_TURN, (data) {
      dev.log('Received turn start', name: 'Socket Service');
      final allPicks = data['availablePicks'] as List<dynamic>;
      final currentPlayerId = data['currentPlayerId'] as String;
      final currentPlayerName = data['currentPlayerName'] as String;
      final nextPlayerName = data['nextPlayerName'] as String;
      final round = data['roundNumber'] as int;

      // Create list of [DrumCorpsCaption] from server message
      final List<DrumCorpsCaption> availablePicks = List.empty(growable: true);
      for (var pick in allPicks) {
        availablePicks.add(DrumCorpsCaption.fromJson(pick, pick['id']));
      }

      // Start turn
      socketResponseStream.add(StartOfTurn(
          roundNumber: round,
          availablePicks: availablePicks,
          currentPlayerName: currentPlayerName,
          nextPlayerName: nextPlayerName,
          currentPlayerId: currentPlayerId));
    });
  }

  void onPlayerMissedTurn() {
    client.socket.on(SERVER_CLIENT_MISSED_TURN, (_) {
      dev.log('Received missed turn', name: 'Socket Service');
      socketResponseStream.add(MissedTurn(missedTurn: true));
    });
  }

  void onServerEndTurn() {
    client.socket.on(SERVER_END_TURN, (data) {
      dev.log('Received server ended turn', name: 'Socket Service');
      final pickJson = data['lastPlayerPick'];
      final pick = DrumCorpsCaption.fromJson(pickJson, pickJson['id']);
      socketResponseStream.add(EndOfTurn(captionPick: pick));
    });
  }
}

@Riverpod(keepAlive: true)
SocketService socketService(SocketServiceRef ref) {
  final socketService = SocketService(client: ref.watch(socketClientProvider));
  ref.onDispose(() {
    // TODO: Remove listeners when socket service is disposed?
    socketService.playerLeavesRoom();
  });
  return socketService;
}

@Riverpod(keepAlive: true)
Stream<DraftData> socketServiceStream(SocketServiceStreamRef ref) {
  return ref.watch(socketServiceProvider).draftStream;
}
