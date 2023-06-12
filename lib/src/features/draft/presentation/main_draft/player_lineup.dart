import 'package:fantasy_drum_corps/src/common_widgets/lineup_caption_slot.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

/// Displays the lineup the player is building during the draft
class PlayerLineup extends StatelessWidget {
  const PlayerLineup({super.key, required this.lineup});

  final Lineup lineup;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: cardPadding,
        child: Column(
          children: [
            Text(
              'YOUR FANTASY CORPS',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            gapH24,
            SizedBox(
              height: 300,
              child: GridView.count(
                padding: const EdgeInsets.all(0),
                crossAxisCount:
                    ResponsiveBreakpoints.of(context).largerThan(TABLET)
                        ? 2
                        : 1,
                childAspectRatio: 10 / 4,
                children: [
                  for (final caption in lineup.keys)
                    LineupCaptionSlot(pick: lineup[caption], caption: caption)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
