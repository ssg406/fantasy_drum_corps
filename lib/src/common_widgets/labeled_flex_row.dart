import 'package:fantasy_drum_corps/src/common_widgets/item_label.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class LabeledFlexRow extends StatelessWidget {
  const LabeledFlexRow({Key? key, required this.label, required this.item})
      : super(key: key);
  final String label;
  final Widget item;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: ResponsiveBreakpoints.of(context).largerOrEqualTo(TABLET)
          ? Axis.horizontal
          : Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ItemLabel(label: label),
        //if (ResponsiveBreakpoints.of(context).smallerOrEqualTo(TABLET)) gapW12,
        gapW12,
        item,
      ],
    );
  }
}
