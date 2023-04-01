import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/item_label.dart';
import 'package:fantasy_drum_corps/src/common_widgets/player_widget.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/application/player_tour_service.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/manage_tour/manage_tour_controller.dart';
import 'package:fantasy_drum_corps/src/utils/alert_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageMembers extends ConsumerWidget {
  const ManageMembers({
    Key? key,
    required this.members,
    required this.owner,
    required this.tourId,
  }) : super(key: key);

  final String tourId;
  final List<String> members;
  final String owner;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(fetchTourPlayersProvider(members)),
      data: (List<Player> players) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ItemLabel(label: 'Member Management'),
            gapH8,
            Text(
              'Remove members from your tour or invite new members',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            gapH8,
            Wrap(
              children: [
                for (final player in players) ...[
                  Column(
                    children: [
                      PlayerWidget(
                        name: player.displayName,
                        avatarString: player.avatarString,
                      ),
                      if (player.playerId != owner)
                        Tooltip(
                          message: 'Remove Player',
                          child: IconButton(
                            onPressed: () {
                              _showConfirmationDialog(context).then(
                                (result) {
                                  final confirmed = result ?? false;
                                  if (confirmed) {
                                    ref
                                        .read(manageTourControllerProvider
                                            .notifier)
                                        .removeMember(
                                            playerId: player.playerId!,
                                            tourId: tourId);
                                  }
                                },
                              );
                            },
                            icon:
                                const Icon(Icons.remove_circle_outline_rounded),
                          ),
                        ),
                    ],
                  ),
                  // Gap before next player widget
                  gapW8,
                ],
              ],
            ),
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
    );
    return result;
  }
}
