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
    return RichText(
      text: TextSpan(
        text: 'ROUND ',
        style: Theme.of(context).textTheme.bodyLarge,
        children: [
          TextSpan(
              text: formatter.format(roundNumber),
              style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
