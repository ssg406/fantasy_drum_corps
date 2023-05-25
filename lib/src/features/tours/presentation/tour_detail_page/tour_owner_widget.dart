import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/labeled_flex_row.dart';
import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TourOwner extends ConsumerWidget {
  const TourOwner({Key? key, required this.ownerId}) : super(key: key);
  final String ownerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(playerStreamByIdProvider(ownerId)),
      data: (Player? player) {
        return LabeledFlexRow(
          label: 'Tour Owner',
          item: Text(
            player?.displayName ?? 'Unknown Owner',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        );
      },
    );
  }
}
