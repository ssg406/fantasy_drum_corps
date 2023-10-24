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
      return Colors.green.shade800;
    } else if (remainingTime < 30 && remainingTime >= 15) {
      return Colors.yellow.shade800;
    } else {
      return Colors.red.shade800;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('00');

    return RichText(
      text: TextSpan(
        text: 'TIME LEFT ',
        style: Theme.of(context).textTheme.titleLarge,
        children: [
          TextSpan(
              text: '${formatter.format(remainingTime)}s',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: _getTimerColor())),
        ],
      ),
    );
  }
}
