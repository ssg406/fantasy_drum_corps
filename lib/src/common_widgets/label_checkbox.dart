import 'package:flutter/material.dart';

class LabelCheckbox extends StatefulWidget {
  const LabelCheckbox(
    this.label, {
    Key? key,
    required this.onChecked,
  }) : super(key: key);
  final String label;
  final void Function(bool) onChecked;

  @override
  State<LabelCheckbox> createState() => _LabelCheckboxState();
}

class _LabelCheckboxState extends State<LabelCheckbox> {
  bool? isChecked;

  void _onChecked() {
    setState(() {
      isChecked = !(isChecked ?? false);
    });
    widget.onChecked(isChecked ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onChecked,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IgnorePointer(
            child: Checkbox(
              value: isChecked ?? false,
              onChanged: (_) {},
            ),
          ),
          Text(
            widget.label,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
