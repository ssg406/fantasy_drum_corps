import 'package:fantasy_drum_corps/src/common_widgets/label_checkbox.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:flutter/material.dart';

class CaptionFilterCard extends StatelessWidget {
  const CaptionFilterCard({
    super.key,
    required this.onFilterSelected,
  });

  final void Function(bool, Caption) onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: cardPadding,
        child: Column(
          children: [
            Text(
              'Filter Captions by Type',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Wrap(
              spacing: 5.0,
              direction: Axis.horizontal,
              children: [
                for (final caption in Caption.values)
                  LabelCheckbox(
                    caption.abbreviation,
                    onChecked: (checked) => onFilterSelected(checked, caption),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
