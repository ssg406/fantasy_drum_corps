import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/main_draft/available_captions.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/main_draft/current_pick_card.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/main_draft/player_lineup.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/main_draft/round_card.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/main_draft/timer_card.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_model.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

import 'caption_filter_card.dart';

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
    required this.onFilterSelected,
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
  final void Function(bool, Caption) onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: pagePadding,
      child: SingleChildScrollView(
        child: ResponsiveCenter(
          maxContentWidth: 1000,
          child: Column(
            children: [
              IntrinsicHeight(
                child: Flex(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  direction: MediaQuery.of(context).size.width < 800
                      ? Axis.vertical
                      : Axis.horizontal,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: TimerCard(remainingTime: remainingTime),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: RoundCard(roundNumber: roundNumber),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: MediaQuery.of(context).size.width < 800 ? 1 : 2,
                      child: CaptionFilterCard(
                        onFilterSelected: onFilterSelected,
                      ),
                    ),
                  ],
                ),
              ),
              IntrinsicHeight(
                child: Flex(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  direction:
                      ResponsiveBreakpoints.of(context).smallerThan(TABLET)
                          ? Axis.vertical
                          : Axis.horizontal,
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: CurrentPickCard(
                        currentPick: currentPick,
                        nextPick: nextPick,
                        currentPickResult: lastPlayersPick,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: AvailableCaptions(
                        canPick: canPick,
                        availableCaptions: availablePicks,
                        onCaptionSelected: onCaptionSelected,
                      ),
                    ),
                  ],
                ),
              ),
              PlayerLineup(
                lineup: fantasyCorps,
              ),
              gapH16,
              if (onCancelDraft != null)
                Align(
                  alignment: Alignment.bottomRight,
                  child: FilledButton.icon(
                    icon: const Icon(Icons.cancel_rounded),
                    onPressed: onCancelDraft,
                    style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.error),
                    label: const Text('Cancel Draft'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
