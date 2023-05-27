import 'package:flutter/material.dart';

/// General button for use throughout the app
/// @param onPressed void Callback
/// @param text button label
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.isLoading,
    this.onSurface = false,
    this.isDisabled = false,
  });

  final VoidCallback onPressed;
  final String label;
  final bool isLoading;
  final bool onSurface;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isLoading || isDisabled ? null : onPressed,
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 20.0,
        ),
      ),
      child: isLoading
          ? const CircularProgressIndicator()
          : Text(
              label.toUpperCase(),
              style: const TextStyle(
                  letterSpacing: 1.5, fontWeight: FontWeight.bold),
            ),
    );
  }
}
