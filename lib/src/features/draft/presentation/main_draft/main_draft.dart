import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/main_draft/available_captions.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/main_draft/current_pick_card.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/main_draft/player_lineup.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/main_draft/round_card.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/main_draft/timer_card.dart';
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
  final bool canPick;
  final List<DrumCorpsCaption> availablePicks;
  final Lineup fantasyCorps;
  final void Function(DrumCorpsCaption) onCaptionSelected;
  final VoidCallback? onCancelDraft;

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
                      flex: 2,
                      child: CurrentPickCard(
                        currentPick: currentPick,
                        nextPick: nextPick,
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
                      flex: 2,
                      fit: FlexFit.tight,
                      child: CaptionFilterCard(
                        onFilterSelected: (_, __) =>
                            debugPrint('filter selected'),
                      ),
                    ),
                    Flexible(
                      flex: 3,
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
                  child: ElevatedButton(
                    onPressed: onCancelDraft,
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.error),
                    child: const Text('Cancel Draft'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
