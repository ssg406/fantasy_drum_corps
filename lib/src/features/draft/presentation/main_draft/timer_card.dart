import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimerCard extends StatelessWidget {
  const TimerCard({
    super.key,
    required this.remainingTime,
  });

  final int remainingTime;

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
              'Time Left',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              ':${formatter.format(remainingTime)}',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: Colors.green[600], fontSize: 80.0),
            ),
          ],
        ),
      ),
    );
  }
}
