import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/not_found.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/draft/domain/socket_events.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/draft_waiting_room.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/main_draft/main_draft.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_model.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

const turnLength = 45;

class DraftLobby extends ConsumerWidget {
  const DraftLobby({super.key, this.tourId});

  final String? tourId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerId = ref.watch(authRepositoryProvider).currentUser?.uid;
    return tourId == null
        ? const NotFound()
        : AsyncValueWidget(
            value: ref.watch(watchTourProvider(tourId!)),
            data: (Tour? tour) {
              if (tour == null) {
                return const NotFound();
              } else if (playerId == null) {
                return const NotFound();
              }
              return DraftLobbyContents(
                tour: tour,
                playerId: playerId,
              );
            });
  }
}

class DraftLobbyContents extends ConsumerStatefulWidget {
  const DraftLobbyContents({
    super.key,
    required this.tour,
    required this.playerId,
  });

  final Tour tour;
  final String playerId;

  @override
  ConsumerState<DraftLobbyContents> createState() => _DraftLobbyContentsState();
}

class _DraftLobbyContentsState extends ConsumerState<DraftLobbyContents> {
  List<Player> players = List.empty(growable: true);
  List<DrumCorpsCaption> availableCaptions = List.empty(growable: true);
  bool draftStarted = false;
  bool showCountdown = false;
  bool isPlayersTurn = false;
  late io.Socket socket;
  final Lineup fantasyCorps = {};
  int roundNumber = 0;
  String? currentPick;
  String? nextPick;
  int remainingTime = turnLength;

  @override
  Widget build(BuildContext context) {
    if (draftStarted) {
      return MainDraft(
        remainingTime: remainingTime,
        roundNumber: roundNumber,
        currentPick: currentPick,
        nextPick: nextPick,
        canPick: isPlayersTurn,
        availablePicks: availableCaptions,
        fantasyCorps: fantasyCorps,
        onCaptionSelected: _onCaptionSelected,
        onCancelDraft:
            widget.tour.owner == widget.playerId ? _onCancelDraft : null,
      );
    }
    if (showCountdown) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            gapH24,
            Text(
                'Tour owner has started the draft countdown. Waiting for server...',
                style: Theme.of(context).textTheme.titleLarge)
          ],
        ),
      );
    } else {
      return DraftWaitingRoom(
        tourName: widget.tour.name,
        players: players,
        isTourOwner: widget.tour.owner == widget.playerId,
        onOwnerStartsDraft:
            widget.tour.owner == widget.playerId ? _startDraft : null,
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _initSocket();

    // Register listeners on socket connection
    socket.onConnect((_) {
      debugPrint('socket is connected');

      _registerDraftSetupListeners();

      _registerActiveDraftListeners();
    });
  }

  /// Set up initial socket connection to tour namespace
  void _initSocket() {
    final tourId = widget.tour.id!;

    socket = io.io('http://localhost:3000/$tourId');
  }

  /// Set up socket listeners that process active draft events
  void _registerActiveDraftListeners() {
    socket.on(SERVER_BEGIN_DRAFT_COUNTDOWN, (_) {
      setState(() => showCountdown = true);
    });

    socket.on(SERVER_DRAFT_TURNS_BEGIN, (_) {
      setState(() => draftStarted = true);
    });

    // Server starts turn and emits available picks and currently picking player
    socket.on(SERVER_STARTS_TURN, (data) {
      _startTurn(data);
    });

    // Server sends remaining time during turn
    socket.on(SERVER_UPDATE_TURN_TIMER, (data) {
      final remainingSeconds = data['remainingTime'] as int;
      setState(() => remainingTime = remainingSeconds);
    });
  }

  /// Emit client identification, and listen for initial waiting room state updates
  void _registerDraftSetupListeners() {
    // Emit identification
    socket.emit(CLIENT_SENDS_IDENTIFICATION, {'playerId': widget.playerId});

    // Server sends if draft is started or in countdown to start
    socket.on(SERVER_SENDS_DRAFT_STATE, (data) => _updateDraftState(data));

    // Server sends update on players waiting to join draft
    socket.on(SERVER_UPDATE_JOINED_PLAYERS, (data) => _updatePlayers(data));
  }

  void _updateDraftState(Map<String, dynamic> data) {
    // Read draft state data from server
    final isCountingDown = data['draftCountingDown'] as bool;
    final isDraftStarted = data['draftStarted'] as bool;

    // Update widget state
    setState(() {
      showCountdown = isCountingDown;
      draftStarted = isDraftStarted;
    });
  }

  void _startDraft() {
    socket.emit(CLIENT_START_DRAFT);
  }

  void _startTurn(Map<String, dynamic> data) {
    // Read data from server
    final allPicks = data['availablePicks'] as List<dynamic>;
    final currentPickerId = data['currentPick'] as String;
    final currentPickName = data['currentPickName'] as String;
    final nextPickName = data['nextPickName'] as String;

    // Create list of [DrumCorpsCaption] from server message
    final List<DrumCorpsCaption> availablePicks = List.empty(growable: true);
    for (var pick in allPicks) {
      availablePicks.add(DrumCorpsCaption.fromJson(pick, pick['id']));
    }

    debugPrint('Turn started for player $currentPickerId');

    // Update widget state
    setState(() {
      availableCaptions = availablePicks;
      isPlayersTurn = currentPickerId == widget.playerId;
      currentPick = currentPickName;
      nextPick = nextPickName;
    });
  }

  void _updatePlayers(Map<String, dynamic> data) {
    // Generate list of players from server data
    final playersFromServer = data['joinedPlayers'] as List<dynamic>;
    final List<Player> newPlayers = [];
    for (var player in playersFromServer) {
      newPlayers.add(Player.fromJson(player, player['id']));
    }
    setState(() {
      players = newPlayers;
    });
  }

  void _onCaptionSelected(DrumCorpsCaption caption) {
    // Send selection back to server
    socket.emit(CLIENT_ENDS_TURN, {
      'playerId': widget.playerId,
      'drumCorpsCaptionId': caption.drumCorpsCaptionId
    });
  }

  void _onCancelDraft() {
    socket.emit(CLIENT_CANCEL_DRAFT);
    setState(() {
      draftStarted = false;
      showCountdown = false;
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }
}
