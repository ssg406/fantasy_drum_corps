import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class GreetingCard extends StatelessWidget {
  const GreetingCard({Key? key, this.displayName}) : super(key: key);
  final String? displayName;

  @override
  Widget build(BuildContext context) {
    final greeting = displayName == null ? 'Hi!' : 'Hi, $displayName!';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DASHBOARD',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        gapH8,
        Text(
          '$greeting Welcome to Fantasy Corps.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
