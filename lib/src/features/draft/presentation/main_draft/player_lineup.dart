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
    return Card(
      elevation: 0,
      child: Column(
        children: [
          Text(
            'Your Fantasy Corps',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          gapH24,
          Column(
            children: [
              for (final caption in lineup.keys)
                LineupCaptionSlot(
                  caption: caption,
                  pick: lineup[caption],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
