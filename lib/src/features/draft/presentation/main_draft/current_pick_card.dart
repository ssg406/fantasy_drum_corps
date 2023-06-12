import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class CurrentPickCard extends StatelessWidget {
  const CurrentPickCard({super.key, this.currentPick, this.nextPick});

  final String? currentPick;
  final String? nextPick;

  @override
  Widget build(BuildContext context) {
    return currentPick != null && nextPick != null
        ? _getTurnInProgressDisplay(context)
        : Center(
            child: Text(
              'Loading Draft Data...',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
  }

  Widget _getTurnInProgressDisplay(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              '@$currentPick',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.green.shade900),
            ),
            gapW8,
            Text(
              'is making a pick',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onTertiary),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              '@$nextPick',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.orange.shade900),
            ),
            Text(
              ' is picking next',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onTertiary),
            ),
          ],
        ),
      ],
    );
  }
}
