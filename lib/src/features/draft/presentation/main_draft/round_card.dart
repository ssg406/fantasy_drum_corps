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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Round',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onTertiary),
        ),
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
