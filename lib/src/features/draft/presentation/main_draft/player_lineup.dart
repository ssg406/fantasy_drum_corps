import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
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
                        ? 4
                        : 2,
                childAspectRatio: 2,
                children: [
                  for (final caption in lineup.keys)
                    LineupCaptionSlot(picks: lineup[caption]!, caption: caption)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LineupCaptionSlot extends StatelessWidget {
  const LineupCaptionSlot(
      {super.key, required this.picks, required this.caption});

  final Caption caption;
  final List<DrumCorps> picks;

  @override
  Widget build(BuildContext context) {
    final slotsAvailable = 2 - picks.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          caption.fullName,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        for (final pick in picks)
          Text(
            pick.fullName,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        Text(
          '$slotsAvailable slots available',
          style: Theme.of(context).textTheme.bodyLarge,
        )
      ],
    );
  }
}
