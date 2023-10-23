import 'package:fantasy_drum_corps/src/utils/app_color_schemes.dart';
import 'package:flutter/material.dart';

class CurrentPickCard extends StatelessWidget {
  const CurrentPickCard({super.key, this.currentPick, this.nextPick});

  final String? currentPick;
  final String? nextPick;

  @override
  Widget build(BuildContext context) {
    return currentPick == null || nextPick == null
        ? Container()
        : Column(
            children: [
              RichText(
                text: TextSpan(
                  text: 'PICKING ',
                  style: Theme.of(context).textTheme.bodyLarge,
                  children: [
                    TextSpan(
                        text: currentPick,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: AppColors.customGreen)),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'NEXT ',
                  style: Theme.of(context).textTheme.bodyLarge,
                  children: [
                    TextSpan(
                        text: nextPick,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: AppColors.customBlue)),
                  ],
                ),
              )
            ],
          );
  }

  Widget _getTurnInProgressDisplay(BuildContext context) {
    return Column(
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
