import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class CurrentPickCard extends StatelessWidget {
  const CurrentPickCard({
    super.key,
    this.currentPick,
    this.nextPick,
  });

  final String? currentPick;
  final String? nextPick;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Picking...',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              currentPick == null ? 'PENDING' : '@$currentPick',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.green[400],
                  ),
            ),
            gapH32,
            Text(
              'Up Next...',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              nextPick == null ? 'PENDING' : '@$nextPick',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.amber,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
