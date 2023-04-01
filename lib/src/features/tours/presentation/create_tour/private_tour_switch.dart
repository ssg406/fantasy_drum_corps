import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class PrivateTourSwitch extends StatelessWidget {
  const PrivateTourSwitch(
      {Key? key, required this.publicSelected, required this.onChanged})
      : super(key: key);
  final bool publicSelected;
  final ValueSetter<bool> onChanged;

  MaterialStateProperty<Icon?> get thumbIcon =>
      MaterialStateProperty.resolveWith<Icon?>(
        (Set<MaterialState> states) {
          // Thumb icon when the switch is selected.
          if (states.contains(MaterialState.selected)) {
            return const Icon(Icons.lock_open);
          }
          return const Icon(Icons.lock);
        },
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(publicSelected ? 'Make Tour Private' : 'Make Tour Public',
            style: Theme.of(context).textTheme.labelLarge),
        gapH8,
        Row(
          children: [
            Switch(
              value: publicSelected,
              thumbIcon: thumbIcon,
              onChanged: onChanged,
            ),
            gapW8,
            Text(publicSelected ? 'Tour is Public' : 'Tour is Private',
                style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        gapH32,
      ],
    );
  }
}
