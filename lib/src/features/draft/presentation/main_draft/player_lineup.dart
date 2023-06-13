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
        padding: ResponsiveBreakpoints.of(context).largerThan(TABLET)
            ? cardPadding
            : mobileCardPadding,
        child: Column(
          children: [
            Text(
              'YOUR FANTASY CORPS',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            gapH24,
            SizedBox(
              height: ResponsiveBreakpoints.of(context).screenHeight * 0.5,
              child: ListView(
                children: [
                  for (final caption in lineup.keys)
                    LineupCaptionSlot(
                      caption: caption,
                      pick: lineup[caption],
                    ),
                ],
              ),
            )
            // SizedBox(
            //   height: ResponsiveBreakpoints.of(context).screenHeight * 0.4,
            //   child: GridView.count(
            //     //padding: const EdgeInsets.all(0),
            //     crossAxisCount:
            //         ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
            //             ? 1
            //             : 2,
            //     childAspectRatio: 12 / 4,
            //     children: [
            //       for (final caption in lineup.keys)
            //         LineupCaptionSlot(pick: lineup[caption], caption: caption)
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
