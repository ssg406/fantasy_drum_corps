import 'package:fantasy_drum_corps/src/common_widgets/item_label.dart';
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [ItemLabel(label: label), item],
    );
  }
}
