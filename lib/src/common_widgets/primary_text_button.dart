import 'package:flutter/material.dart';

/// Implementation of [TextButton] used throughout app
/// @param onPressed void callback when pressed
/// @param label button label
class PrimaryTextButton extends StatelessWidget {
  const PrimaryTextButton({
    super.key,
    this.onPressed,
    required this.label,
    required this.isLoading,
  });
  final VoidCallback? onPressed;
  final String label;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
      ),
      child: isLoading
          ? const CircularProgressIndicator()
          : Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
    );
  }
}
