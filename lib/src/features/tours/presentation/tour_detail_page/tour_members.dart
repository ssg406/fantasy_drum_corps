import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/player_widget.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/application/player_tour_service.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/tour_detail_page/tour_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/alert_dialogs.dart';

class TourMembers extends ConsumerWidget {
  const TourMembers(
      {super.key,
      required this.members,
      this.isOwner = false,
      required this.owner,
      required this.tourId});

  final List<String> members;
  final bool isOwner;
  final String owner;
  final String tourId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(watchTourPlayersProvider(members)),
      data: (List<Player> players) {
        return Wrap(
          children: [
            for (final player in players) ...[
              Column(
                children: [
                  PlayerWidget(
                      size: 60,
                      name: player.displayName,
                      avatarString: player.avatarString),
                  if (isOwner)
                    if (player.playerId != owner)
                      Consumer(
                        builder: (context, ref, child) {
                          return Tooltip(
                            message: 'Remove Player',
                            child: IconButton(
                              onPressed: () {
                                _showConfirmationDialog(context).then(
                                  (result) {
                                    final confirmed = result ?? false;
                                    if (confirmed) {
                                      ref
                                          .read(tourDetailControllerProvider
                                              .notifier)
                                          .removeMember(
                                              playerId: player.playerId!,
                                              tourId: tourId);
                                    }
                                  },
                                );
                              },
                              icon: const Icon(
                                  Icons.remove_circle_outline_rounded),
                            ),
                          );
                        },
                      )
                ],
              ),
              gapW8,
            ]
          ],
        );
      },
    );
  }

  Future<bool?> _showConfirmationDialog(BuildContext context) async {
    final result = await showAlertDialog(
        context: context,
        title: 'Remove Player',
        content: 'Are you sure you want to remove the player?',
        defaultActionText: 'Remove Player',
        cancelActionText: 'Cancel');
    return result;
  }
}
