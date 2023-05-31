import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/not_found.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/draft/domain/socket_events.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/auto_draft.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/draft_waiting_room.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/main_draft/main_draft.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_model.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/routing/app_routes.dart';
import 'package:fantasy_drum_corps/src/utils/alert_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../fantasy_corps/domain/drum_corps_enum.dart';

const turnLength = 45;

const rootServerUrl = 'https://fantasy-drum-corps-server.herokuapp.com';

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
              return tour.draftComplete
                  ? AutoDraft(tour: tour)
                  : DraftLobbyContents(
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
  List<DrumCorpsCaption> filteredCaptions = List.empty(growable: true);
  List<Caption> selectedFilters = List.empty(growable: true);
  List<DrumCorps> alreadySelectedCorps = List.empty(growable: true);

  bool draftStarted = false;
  bool showCountdown = false;
  bool isPlayersTurn = false;
  late io.Socket socket;
  final Lineup fantasyCorps = {};
  int roundNumber = 0;
  String? currentPick;
  String? nextPick;
  int remainingTime = turnLength;
  DrumCorpsCaption? lastPlayersPick;

  @override
  Widget build(BuildContext context) {
    if (draftStarted) {
      return MainDraft(
        remainingTime: remainingTime,
        roundNumber: roundNumber,
        currentPick: currentPick,
        nextPick: nextPick,
        lastPlayersPick: lastPlayersPick,
        canPick: isPlayersTurn,
        availablePicks: filteredCaptions,
        fantasyCorps: fantasyCorps,
        onCaptionSelected: _onCaptionSelected,
        onFilterSelected: _onCaptionFilterSelected,
        onCancelDraft:
            widget.tour.owner == widget.playerId ? _onCancelDraft : null,
      );
    }
    if (showCountdown) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
                width: 300,
                child: LinearProgressIndicator(
                  semanticsLabel: 'Waiting for players indicator',
                )),
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

    // Set empty lineup
    for (final caption in Caption.values) {
      fantasyCorps.addAll({caption: null});
    }

    // Register listeners on socket connection
    socket.onConnect((_) {
      debugPrint('Connected to server');
      _registerDraftSetupListeners();

      _registerActiveDraftListeners();
    });

    socket.onError((data) {
      debugPrint('There was a socket error: $data}');
    });
  }

  /// Set up initial socket connection to tour namespace
  void _initSocket() {
    final tourId = widget.tour.id!;
    socket = io.io('$rootServerUrl/$tourId',
        io.OptionBuilder().setTransports(['websocket']).build());
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

    // Server sends the last players pick
    socket.on(SERVER_SENDS_PLAYER_PICK, (data) {
      final lastPick = data['lastPick'];
      debugPrint(data.toString());
      final pick =
          DrumCorpsCaption.fromJson(lastPick, lastPick['drumCorpsCaptionId']);
      setState(() => lastPlayersPick = pick);
    });

    socket.on(SERVER_NO_PICK_RECEIVED, (_) => _autoSelectPick());

    socket.on(SERVER_DRAFT_CANCELLED_BY_OWNER, (_) => _onOwnerCancelledDraft());
  }

  /// Iterates through the available picks and adds the first compatible pick
  /// to the fantasyCorps map.
  void _autoSelectPick() {
    // Create a list of indexes representing positions in availableCaptions
    final availableCaptionsIndices =
        List.generate(availableCaptions.length, (index) => index);

    // Shuffle the list
    availableCaptionsIndices.shuffle();

    for (final pickIndex in availableCaptionsIndices) {
      // Get the DrumCorpsCaption pick from the available captions
      final pick = availableCaptions[pickIndex];

      // Check if pick corps already exists in lineup
      if (alreadySelectedCorps.contains(pick.corps)) continue;

      // Determine if the slot at this caption is available, continue if not
      if (fantasyCorps[pick.caption] != null) continue;

      // Execute the logic for adding a pick to the lineup
      fantasyCorps.addAll({pick.caption: pick.corps});

      // Add the selection to list of already picked corps
      alreadySelectedCorps.add(pick.corps);

      socket.emit(CLIENT_SENDS_AUTO_PICK, {
        'playerId': widget.playerId,
        'drumCorpsCaption': pick.toJson(),
      });
      // Exit the loop is a selection was made.
      break;
    }
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
    final round = data['roundNumber'] as int;

    // Create list of [DrumCorpsCaption] from server message
    final List<DrumCorpsCaption> availablePicks = List.empty(growable: true);
    for (var pick in allPicks) {
      availablePicks
          .add(DrumCorpsCaption.fromJson(pick, pick['drumCorpsCaptionId']));
    }

    // Update widget state
    setState(() {
      // Re run caption filters
      if (selectedFilters.isEmpty) {
        filteredCaptions = availablePicks;
      } else {
        filteredCaptions = availablePicks
            .where((item) => selectedFilters.contains(item.caption))
            .toList();
      }
      availableCaptions = availablePicks;
      isPlayersTurn = currentPickerId == widget.playerId;
      currentPick = currentPickName;
      nextPick = nextPickName;
      roundNumber = round;
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

  void _onCaptionSelected(DrumCorpsCaption drumCorpsCaption) {
    // Check for an existing pick
    if (fantasyCorps[drumCorpsCaption.caption] != null) {
      showAlertDialog(
          context: context,
          title: 'No ${drumCorpsCaption.caption.fullName} slot available');
      return;
    }

    // Check if corps already exists in lineup
    if (alreadySelectedCorps.contains(drumCorpsCaption.corps)) {
      showAlertDialog(
          context: context,
          title:
              'You already have ${drumCorpsCaption.corps.fullName} in your lineup.');
      return;
    }

    // Send selection back to server
    socket.emit(CLIENT_ENDS_TURN, {
      'playerId': widget.playerId,
      'drumCorpsCaption': drumCorpsCaption.toJson()
    });

    // Add to list of picked captions
    alreadySelectedCorps.add(drumCorpsCaption.corps);

    // Update the lineup locally
    setState(() {
      fantasyCorps.addAll({drumCorpsCaption.caption: drumCorpsCaption.corps});
    });

    if (_getOpenLineupSlots() == 0) {
      _onLineupComplete();
    }
  }

  int _getOpenLineupSlots() => fantasyCorps.values.fold(
      0, (previousValue, element) => previousValue + (element == null ? 1 : 0));

  void _onLineupComplete() {
    socket.emit(CLIENT_LINEUP_COMPLETE);

    // Create a new fantasy corps object and write it to the server
    FantasyCorps corps = FantasyCorps(
        tourId: widget.tour.id!,
        userId: widget.playerId,
        lineup: fantasyCorps,
        name: 'Unnamed Corps');

    // Exit draft room and send user to Fantasy Corps main page to enter details
    context.pushNamed(AppRoutes.createCorps.name,
        params: {'tid': widget.tour.id!}, extra: corps);
  }

  void _onOwnerCancelledDraft() {
    setState(() {
      draftStarted = false;
    });
    showAlertDialog(
        context: context,
        title: 'Draft Cancelled',
        content: 'The draft was cancelled by the tour owner.');

    context
        .pushNamed(AppRoutes.tourDetail.name, params: {'tid': widget.tour.id!});
  }

  void _onCancelDraft() {
    socket.emit(CLIENT_CANCEL_DRAFT);
    setState(() {
      draftStarted = false;
      showCountdown = false;
    });
    context.pop();
  }

  void _onCaptionFilterSelected(bool selected, Caption caption) {
    // Add or remove from list of filtered captions
    if (selected) {
      selectedFilters.add(caption);
    } else {
      selectedFilters.remove(caption);
    }

    // Filter the caption list and set state
    setState(() {
      if (selectedFilters.isEmpty) {
        filteredCaptions = availableCaptions;
      } else {
        filteredCaptions = availableCaptions
            .where((item) => selectedFilters.contains(item.caption))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }
}
