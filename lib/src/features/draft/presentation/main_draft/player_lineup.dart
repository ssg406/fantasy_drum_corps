import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:fantasy_drum_corps/src/utils/app_color_schemes.dart';
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

class LineupCaptionSlot extends StatelessWidget {
  const LineupCaptionSlot({super.key, this.pick, required this.caption});

  final Caption caption;
  final DrumCorps? pick;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          caption.fullName,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        pick == null
            ? Text(
                'OPEN SLOT',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: AppColors.customBlue),
              )
            : Text(
                pick!.fullName,
                style: Theme.of(context).textTheme.titleSmall,
              )
      ],
    );
  }
}
