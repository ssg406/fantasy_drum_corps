import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

import '../../../../constants/app_sizes.dart';

class LastPickCard extends StatelessWidget {
  const LastPickCard({Key? key, this.lastPlayersPick}) : super(key: key);
  final DrumCorpsCaption? lastPlayersPick;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: ResponsiveBreakpoints.of(context).largerThan(TABLET)
          ? Axis.vertical
          : Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'LAST PICK',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onTertiary),
        ),
        if (ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)) gapW8,
        Text(
          lastPlayersPick?.displayString ?? 'No Pick',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.blue.shade900),
        ),
      ],
    );
  }
}
