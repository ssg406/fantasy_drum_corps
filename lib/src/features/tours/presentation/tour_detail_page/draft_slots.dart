import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class DraftSlots extends StatelessWidget {
  const DraftSlots({Key? key, required this.slots}) : super(key: key);
  final int slots;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Slots Available',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        gapH8,
        Text(
          _getSlotsText(slots),
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: _getSlotsColor(slots)),
        ),
      ],
    );
  }

  String _getSlotsText(int openSlots) {
    if (openSlots == 0) {
      return 'Tour Full';
    }
    return '$openSlots ${openSlots == 1 ? 'slot' : 'slots'}';
  }

  Color _getSlotsColor(int openSlots) {
    if (openSlots > 0) {
      return Colors.red[300]!;
    }
    return Colors.green[300]!;
  }
}
