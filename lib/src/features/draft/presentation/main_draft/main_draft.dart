import 'package:fantasy_drum_corps/src/common_widgets/common_buttons.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/main_draft/current_pick_card.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/main_draft/last_pick_card.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/main_draft/player_lineup.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/main_draft/round_card.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/main_draft/timer_card.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_model.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

import 'available_captions.dart';

class MainDraft extends StatelessWidget {
  const MainDraft({
    super.key,
    required this.remainingTime,
    required this.roundNumber,
    this.currentPick,
    this.nextPick,
    this.lastPlayersPick,
    required this.canPick,
    required this.availablePicks,
    required this.fantasyCorps,
    required this.onCaptionSelected,
    required this.onCancelDraft,
  });

  final int remainingTime;
  final int roundNumber;
  final String? currentPick;
  final String? nextPick;
  final DrumCorpsCaption? lastPlayersPick;
  final bool canPick;
  final List<DrumCorpsCaption> availablePicks;
  final Lineup fantasyCorps;
  final void Function(DrumCorpsCaption) onCaptionSelected;
  final VoidCallback? onCancelDraft;

  @override
  Widget build(BuildContext context) {
    final Lineup lineup = {
      Caption.brass: DrumCorps.bluecoats,
      Caption.percussion: DrumCorps.blueStars
    };
    return SingleChildScrollView(
      child: ResponsiveCenter(
        child: Padding(
          padding: ResponsiveBreakpoints.of(context).largerThan(TABLET)
              ? pagePadding
              : mobilePagePadding,
          child: Column(
            children: [
              Card(
                elevation: 0,
                child: Padding(
                  padding: mobileCardPadding,
                  child: Flex(
                    direction:
                        ResponsiveBreakpoints.of(context).largerThan(TABLET)
                            ? Axis.horizontal
                            : Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TimerCard(remainingTime: remainingTime),
                          gapW12,
                          RoundCard(roundNumber: roundNumber),
                        ],
                      ),
                      gapW12,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CurrentPickCard(
                            currentPick: currentPick,
                            nextPick: nextPick,
                          ),
                          gapW12,
                          LastPickCard(lastPlayersPick: lastPlayersPick),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              gapH12,
              IntrinsicHeight(
                child: Row(
                  children: [
                    Flexible(
                      child: AvailableCaptions(
                          availableCaptions: availablePicks,
                          onCaptionSelected: onCaptionSelected,
                          canPick: canPick),
                    ),
                    if (ResponsiveBreakpoints.of(context)
                        .largerThan(TABLET)) ...[
                      gapW24,
                      Flexible(
                        child: PlayerLineup(lineup: lineup),
                      ),
                    ]
                  ],
                ),
              ),
              if (ResponsiveBreakpoints.of(context).smallerOrEqualTo(TABLET))
                PlayerLineup(lineup: lineup),
              if (onCancelDraft != null)
                Align(
                  alignment: Alignment.bottomRight,
                  child: PrimaryActionButton(
                    icon: Icons.cancel_rounded,
                    isDestructive: true,
                    onPressed: onCancelDraft!,
                    labelText: 'Cancel Draft',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
