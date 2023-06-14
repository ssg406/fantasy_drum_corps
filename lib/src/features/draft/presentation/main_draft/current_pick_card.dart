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
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current Turn: ',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onTertiary),
            ),
            Text(
              '@$currentPick',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.green.shade900),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Next Turn: ',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onTertiary),
            ),
            Text(
              '@$nextPick',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.orange.shade900),
            ),
          ],
        ),
      ],
    );
  }
}
