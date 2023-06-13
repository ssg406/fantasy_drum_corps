import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

import '../../../../constants/app_sizes.dart';

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
    return Flex(
      direction: ResponsiveBreakpoints.of(context).largerThan(TABLET)
          ? Axis.vertical
          : Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'TIME LEFT',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onTertiary),
        ),
        if (ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)) gapW8,
        Text(
          ':${formatter.format(remainingTime)}',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: _getTimerColor()),
        ),
      ],
    );
  }
}
