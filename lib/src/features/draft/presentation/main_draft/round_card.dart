import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

import '../../../../constants/app_sizes.dart';

class RoundCard extends StatelessWidget {
  const RoundCard({
    super.key,
    required this.roundNumber,
  });

  final int roundNumber;

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
          'ROUND',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onTertiary),
        ),
        if (ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)) gapW8,
        Text(
          formatter.format(roundNumber),
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.blue[900]),
        ),
      ],
    );
  }
}
