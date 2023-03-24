import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DraftDateTime extends StatelessWidget {
  const DraftDateTime({Key? key, required this.draftDateTime})
      : super(key: key);
  final DateTime draftDateTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Draft Date + Time',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        gapH8,
        Text(
          DateFormat.yMMMMd('en_US').add_jm().format(draftDateTime),
          style: Theme.of(context).textTheme.bodyMedium,
        )
      ],
    );
  }
}
