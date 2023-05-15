import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_model.dart';
import 'package:flutter/material.dart';

class CurrentPickCard extends StatelessWidget {
  const CurrentPickCard(
      {super.key, this.currentPick, this.nextPick, this.currentPickResult});

  final String? currentPick;
  final String? nextPick;
  final DrumCorpsCaption? currentPickResult;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: cardPadding,
        child: currentPick != null && nextPick != null
            ? _getTurnInProgressDisplay(context)
            : Center(
                child: Text(
                  'Loading Draft Data...',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
      ),
    );
  }

  Widget _getTurnInProgressDisplay(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '@$currentPick',
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: Colors.green.shade600),
        ),
        Text(
          'is making a pick...',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        gapH32,
        Text(
          '@$nextPick',
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: Colors.yellow.shade600),
        ),
        Text(
          'is picking next',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        gapH32,
        if (currentPickResult != null)
          Text(
            '$currentPick drafted: ${currentPickResult!.displayString}',
            style: Theme.of(context).textTheme.labelLarge,
          )
      ],
    );
  }
}
