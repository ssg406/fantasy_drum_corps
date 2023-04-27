import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RoundCard extends StatelessWidget {
  const RoundCard({
    super.key,
    required this.roundNumber,
  });

  final int roundNumber;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('00');
    return Card(
      child: Padding(
        padding: cardPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Round',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              formatter.format(roundNumber),
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: Colors.blue[300], fontSize: 80.0),
            ),
          ],
        ),
      ),
    );
  }
}
