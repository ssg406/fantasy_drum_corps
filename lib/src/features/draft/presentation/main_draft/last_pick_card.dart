import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_model.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_sizes.dart';

class LastPickCard extends StatelessWidget {
  const LastPickCard({Key? key, this.lastPlayersPick}) : super(key: key);
  final DrumCorpsCaption? lastPlayersPick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Last Pick',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onTertiary),
        ),
        gapH8,
        Text(
          lastPlayersPick?.displayString ?? 'No Pick',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.blue.shade900),
        ),
      ],
    );
  }
}
