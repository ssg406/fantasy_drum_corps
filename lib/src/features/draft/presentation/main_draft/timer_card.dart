import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimerCard extends StatelessWidget {
  const TimerCard({
    super.key,
    required this.remainingTime,
  });

  final int remainingTime;

  Color _getTimerColor() {
    if (remainingTime >= 30) {
      return Colors.green.shade900;
    } else if (remainingTime < 30 && remainingTime >= 15) {
      return Colors.yellow.shade900;
    } else {
      return Colors.red.shade900;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('00');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Time Left',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onTertiary),
        ),
        Text(
          ':${formatter.format(remainingTime)}',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: _getTimerColor(), fontSize: 28.0),
        ),
      ],
    );
  }
}
