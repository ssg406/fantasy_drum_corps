import 'package:fantasy_drum_corps/src/common_widgets/item_label.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class TourDescription extends StatelessWidget {
  const TourDescription({Key? key, required this.description})
      : super(key: key);
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ItemLabel(label: 'Description'),
        gapW32,
        Text(
          description,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
