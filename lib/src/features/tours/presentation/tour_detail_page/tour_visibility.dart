import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class TourVisibility extends StatelessWidget {
  const TourVisibility({Key? key, required this.isPublic}) : super(key: key);
  final bool isPublic;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Visibility',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        gapH8,
        Row(
          children: [
            Icon(
              isPublic ? Icons.lock_open : Icons.lock,
              color: isPublic ? Colors.green[300] : Colors.red[300],
            ),
            gapW8,
            Text(
              isPublic ? 'Public' : 'Private',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: isPublic ? Colors.green[300] : Colors.red[300]),
            )
          ],
        ),
      ],
    );
  }
}
