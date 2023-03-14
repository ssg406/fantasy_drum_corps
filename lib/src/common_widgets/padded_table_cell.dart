import 'package:flutter/material.dart';

class TableCellPadded extends StatelessWidget {
  const TableCellPadded({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
    this.verticalAlignment = TableCellVerticalAlignment.middle,
  }) : super(key: key);
  final Widget child;
  final EdgeInsets padding;
  final TableCellVerticalAlignment verticalAlignment;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: verticalAlignment,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
