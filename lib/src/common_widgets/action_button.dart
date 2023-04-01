import 'package:fantasy_drum_corps/src/utils/app_color_schemes.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.customGreen,
          textStyle: TextStyle(fontWeight: FontWeight.bold)),
      // style: ButtonStyle(
      //   backgroundColor: MaterialStateProperty.resolveWith((states) {
      //     if (states.contains(MaterialState.hovered)) {
      //       return AppColors.customGreen;
      //     }
      //     return theme.colorScheme.surface;
      //   }),
      // ),
      child: isLoading
          ? const CircularProgressIndicator()
          : Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
    );
  }
}
