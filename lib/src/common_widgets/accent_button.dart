import 'package:fantasy_drum_corps/src/utils/app_color_schemes.dart';
import 'package:flutter/material.dart';

class AccentButton extends StatelessWidget {
  const AccentButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.isLoading = false,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final String label;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.customGreen,
          foregroundColor: Colors.white,
          textStyle: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontSize: 18.0, letterSpacing: 1.5)),
      child: isLoading
          ? const CircularProgressIndicator()
          : Text(label.toUpperCase()),
    );
  }
}
