import 'package:fantasy_drum_corps/src/common_widgets/lineup_caption_slot.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:flutter/material.dart';

/// Displays the lineup the player is building during the draft
class PlayerLineup extends StatelessWidget {
  const PlayerLineup({super.key, required this.lineup});

  final Lineup lineup;

  @override
  Widget build(BuildContext context) {
    final captionSlotList = lineup.keys
        .map((caption) =>
            LineupCaptionSlot(caption: caption, pick: lineup[caption]))
        .toList();
    return Column(
      children: [
        Text(
          'Your Fantasy Corps',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        gapH24,
        for (int i = 0; i < captionSlotList.length; i += 2)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              captionSlotList[i],
              if (i + 1 < captionSlotList.length) captionSlotList[i + 1]
            ],
          ),
      ],
    );
  }
}

/**
 * Get total count of items = 12
 * Determine how many rows for 2 columns = 6
 * For each 0..6 create one row
 * if iteration 0, row has items[0] and items[1] (items[index], items[index + 1]
 * if iteration 1, rows has items[2] and items[3]
 * if iteration 2, row has items[4] and items[5]
 *
 */
