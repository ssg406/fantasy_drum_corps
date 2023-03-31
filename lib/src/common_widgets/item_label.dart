import 'package:flutter/material.dart';

class ItemLabel extends StatelessWidget {
  const ItemLabel({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(color: Theme.of(context).colorScheme.primary),
    );
  }
}
