import 'dart:async';
import 'dart:developer' as dev;

import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../../common_widgets/async_value_widget.dart';
import '../../../../common_widgets/not_found.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../routing/app_routes.dart';
import '../../../../utils/alert_dialogs.dart';
import '../../../authentication/data/auth_repository.dart';
import '../../../fantasy_corps/domain/caption_model.dart';
import '../../../fantasy_corps/domain/drum_corps_enum.dart';
import '../../../fantasy_corps/domain/fantasy_corps.dart';
import '../../../players/domain/player_model.dart';
import '../../../tours/data/tour_repository.dart';
import '../../../tours/domain/tour_model.dart';
import '../../domain/socket_events.dart';
import '../auto_draft/auto_draft.dart';
import 'draft_waiting_room.dart';
import 'main_draft.dart';

const turnLength = Duration(seconds: 45);

const rootServerUrl = 'localhost:3000';

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
            },
          );
  }
}

class DraftLobbyContents extends StatefulWidget {
  const DraftLobbyContents(
      {Key? key, required this.tour, required this.playerId})
      : super(key: key);

  final Tour tour;
  final String playerId;

  @override
  State<DraftLobbyContents> createState() => _DraftLobbyContentsState();
}

class _DraftLobbyContentsState extends State<DraftLobbyContents> {
  List<Player> players = List.empty(growable: true);
  List<DrumCorpsCaption> availableCaptions = List.empty(growable: true);
  List<DrumCorps> alreadySelectedCorps = List.empty(growable: true);
  bool draftStarted = false;
  bool showCountdown = false;
  bool isPlayersTurn = false;
  late io.Socket socket;
  final Lineup fantasyCorps = {};
  int roundNumber = 0;
  String? currentPick;
  String? nextPick;
  int remainingTime = turnLength.inSeconds;
  DrumCorpsCaption? lastPlayersPick;
  Timer? turnTimer;
  Timer? intervalTimer;

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
  }

  void _initSocket() {
    final tourId = widget.tour.id!;
    dev.log('Attempting to connect to: $rootServerUrl/tourId', name: 'DRAFT');
    socket = io.io('http://$rootServerUrl/$tourId',
        io.OptionBuilder().setTransports(['websocket']).build());
    socket.onConnect((_) {
      dev.log('Connected. Sending ID to server', name: 'DRAFT');
      socket.emit(CLIENT_SENDS_IDENTIFICATION,
          {'playerId': widget.playerId, 'tourId': widget.tour.id!});
      _registerDraftListeners();
    });
  }

  void _registerDraftListeners() {
    // Server sends if draft is started or in countdown to start
    socket.on(SERVER_SENDS_DRAFT_STATE, (data) => _updateDraftState(data));

    // Server sends update on players waiting to join draft
    socket.on(SERVER_UPDATE_JOINED_PLAYERS, (data) => _updatePlayers(data));

    // Server starts turn and emits available picks and currently picking player
    socket.on(SERVER_STARTS_TURN, (data) {
      _startTurn(data);
    });

    socket.on(SERVER_DRAFT_CANCELLED_BY_OWNER, (_) => _onOwnerCancelledDraft());
  }

  void _updateDraftState(Map<String, dynamic> data) {
    // Read draft state data from server
    final isCountingDown = data['draftCountingDown'] as bool;
    final isDraftStarted = data['draftStarted'] as bool;

    dev.log(
        'Got draft status update from server: isCountingDown = $isCountingDown isDraftStarted = $isDraftStarted');

    // Update widget state
    setState(() {
      showCountdown = isCountingDown;
      draftStarted = isDraftStarted;
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
    dev.log(
        'Got updated players list from server. ${newPlayers.length} are in the draft',
        name: 'DRAFT');
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

    dev.log(
        'Caption selected, sending pick to server: ${drumCorpsCaption.caption} ${drumCorpsCaption.corps}',
        name: 'DRAFT');

    // Send selection back to server
    socket.emit(CLIENT_ENDS_TURN, {
      'playerId': widget.playerId,
      'drumCorpsCaption': drumCorpsCaption.toJson()
    });

    // Cancel turn timer
    intervalTimer?.cancel();

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

  void _onOwnerCancelledDraft() {
    dev.log('Tour owner cancelled draft', name: 'DRAFT');

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

    // Show alert if it is the players turn
    if (currentPickerId == widget.playerId) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You\'re up! Make a selection in the next 45 seconds.'),
          showCloseIcon: true,
          duration: Duration(seconds: 3),
        ),
      );

      // Update widget state
      setState(() {
        availableCaptions = availablePicks;
        isPlayersTurn = currentPickerId == widget.playerId;
        currentPick = currentPickName;
        nextPick = nextPickName;
        roundNumber = round;
      });

      intervalTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (remainingTime == 0) {
          timer.cancel();
          _autoSelectPick();
        }
        setState(() {
          remainingTime--;
        });
      });
    }
  }

  int _getOpenLineupSlots() => fantasyCorps.values.fold(
      0, (previousValue, element) => previousValue + (element == null ? 1 : 0));

  void _onLineupComplete() {
    dev.log('Player lineup complete, leaving draft...', name: 'DRAFT');

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

  void _autoSelectPick() {
    dev.log('Auto-selecting a pick', name: 'DRAFT');
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
      // Exit the loop if a selection was made.
      break;
    }
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }
}
