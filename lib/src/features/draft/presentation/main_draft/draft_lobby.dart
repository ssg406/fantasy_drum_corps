import 'package:fantasy_drum_corps/src/features/draft/domain/draft_state.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/draft_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widgets/async_value_widget.dart';
import '../../../../common_widgets/not_found.dart';
import '../../../authentication/data/auth_repository.dart';
import '../../../tours/data/tour_repository.dart';
import '../../../tours/domain/tour_model.dart';
import '../auto_draft/auto_draft.dart';
import 'draft_cancelled.dart';
import 'draft_connection_waiting.dart';
import 'draft_server_error.dart';
import 'draft_waiting_room.dart';
import 'main_draft.dart';

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

class DraftLobbyContents extends ConsumerWidget {
  const DraftLobbyContents(
      {Key? key, required this.tour, required this.playerId})
      : super(key: key);

  final Tour tour;
  final String playerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(draftControllerProvider.notifier);
    final state = ref.watch(draftControllerProvider);

    ref.listen(
        draftControllerProvider,
        (_, draftState) =>
            draftState.handleDraftActions(context, tour.id!, playerId));

    if (state.draftCancelled) {
      return const DraftCancelled();
    }

    if (state.serverError) {
      return DraftServerError(
        message: state.errorMessage,
      );
    }

    if (state.draftStarted) {
      return MainDraft(
        remainingTime: state.remainingTime,
        roundNumber: state.roundNumber,
        currentPick: state.currentPlayerName,
        nextPick: state.nextPlayerName,
        lastPlayersPick: state.lastPick,
        canPick: state.currentPlayerId == playerId,
        availablePicks: state.availablePicks,
        fantasyCorps: state.playerLineup,
        onCaptionSelected: controller.onCaptionSelected,
        onCancelDraft:
            tour.owner == playerId ? controller.ownerCancelDraft : null,
      );
    }

    if (state.joinedRoom) {
      return DraftWaitingRoom(
        tourName: tour.name,
        players: state.joinedPlayers,
        isTourOwner: tour.owner == playerId,
        markPlayerReady: controller.clientReadyForDraft,
        playerIsReady: state.playerReady,
        onOwnerStartsDraft:
            tour.owner == playerId ? controller.ownerBeginDraft : null,
        canStartDraft: state.allPlayersReady,
        onBackPressed: () {
          ref.read(draftControllerProvider.notifier).leaveRoom();
          context.pop();
        },
      );
    }

    return DraftConnectionWaiting(onBackPressed: () {
      ref.watch(draftControllerProvider.notifier).leaveRoom();
      context.pop();
    });
  }
}
