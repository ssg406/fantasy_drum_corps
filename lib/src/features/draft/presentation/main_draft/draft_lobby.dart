import 'dart:async';

import 'package:fantasy_drum_corps/src/features/draft/domain/draft_state.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/draft_controller.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/main_draft/draft_connection_waiting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widgets/async_value_widget.dart';
import '../../../../common_widgets/not_found.dart';
import '../../../../routing/app_routes.dart';
import '../../../../utils/alert_dialogs.dart';
import '../../../authentication/data/auth_repository.dart';
import '../../../fantasy_corps/domain/fantasy_corps.dart';
import '../../../tours/data/tour_repository.dart';
import '../../../tours/domain/tour_model.dart';
import '../auto_draft/auto_draft.dart';
import 'draft_waiting_room.dart';
import 'main_draft.dart';

// TODO thought checks if room created and player exists, and if they do, then just takes that existing spot, so as long as draft is going they can go and come back from the page, unless they actually click something that says 'leave draft' or hit refresh

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

class DraftLobbyContents extends ConsumerStatefulWidget {
  const DraftLobbyContents(
      {Key? key, required this.tour, required this.playerId})
      : super(key: key);

  final Tour tour;
  final String playerId;

  @override
  ConsumerState<DraftLobbyContents> createState() => _DraftLobbyContentsState();
}

class _DraftLobbyContentsState extends ConsumerState<DraftLobbyContents> {
  Timer? turnTimer;

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(draftControllerProvider.notifier);
    final state = ref.watch(draftControllerProvider);

    ref.listen(draftControllerProvider, (_, newState) {
      newState.showAlertOnDraftError(context);
      newState.exitWhenLineupComplete(context, widget.tour.id!, widget.playerId);
    });

    if (state.draftStarted) {
      return MainDraft(
        remainingTime: state.remainingTime,
        roundNumber: state.roundNumber,
        currentPick: state.currentPlayerName,
        nextPick: state.nextPlayerName,
        lastPlayersPick: state.lastPick,
        canPick: state.currentPlayerId == widget.playerId,
        availablePicks: state.availablePicks,
        fantasyCorps: state.playerLineup,
        onCaptionSelected: controller.onCaptionSelected,
        onCancelDraft: widget.tour.owner == widget.playerId
            ? controller.ownerCancelDraft
            : null,
      );
    }

    if (state.joinedRoom) {
      return DraftWaitingRoom(
        tourName: widget.tour.name,
        players: state.joinedPlayers,
        isTourOwner: widget.tour.owner == widget.playerId,
        markPlayerReady: controller.clientReadyForDraft,
        playerIsReady: state.playerReady,
        onOwnerStartsDraft: widget.tour.owner == widget.playerId
            ? controller.ownerBeginDraft
            : null,
        canStartDraft: state.allPlayersReady,
        onBackPressed: _onBackPressed,
      );
    }

    return DraftConnectionWaiting(onBackPressed: _onBackPressed);
  }

  void _onBackPressed() {
    ref.read(draftControllerProvider.notifier).leaveRoom();
    if (Navigator.of(context).canPop()) {
      context.pop();
    } else {
      context.goNamed(AppRoutes.dashboard.name);
    }
  }

  @override
  void initState() {
    super.initState();
    final controller = ref.read(draftControllerProvider.notifier);

    controller.joinRoom(
        playerId: widget.playerId,
        tourId: widget.tour.id!,
        action: widget.tour.owner == widget.playerId ? 'create' : 'join');
  }
}
