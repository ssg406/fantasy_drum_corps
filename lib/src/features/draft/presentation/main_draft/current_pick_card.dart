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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'PICKING ',
                  style: Theme.of(context).textTheme.titleLarge,
                  children: [
                    TextSpan(
                        text: currentPick,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary)),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'NEXT ',
                  style: Theme.of(context).textTheme.titleLarge,
                  children: [
                    TextSpan(
                        text: nextPick,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary)),
                  ],
                ),
              )
            ],
          );
  }
}
