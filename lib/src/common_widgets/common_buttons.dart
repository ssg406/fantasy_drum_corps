import 'package:flutter/material.dart';

class PrimaryActionButton extends StatelessWidget {
  const PrimaryActionButton(
      {super.key,
      required this.onPressed,
      required this.labelText,
      this.isLoading = false,
      this.icon,
      this.isDestructive = false});

  final VoidCallback onPressed;
  final String labelText;
  final bool isLoading;
  final IconData? icon;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return icon == null
        ? FilledButton(
            onPressed: isLoading ? null : onPressed,
            style: isDestructive
                ? FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error)
                : null,
            child: isLoading
                ? const CircularProgressIndicator()
                : Text(
                    labelText.toUpperCase(),
                    style: const TextStyle(
                        letterSpacing: 1.5, fontWeight: FontWeight.bold),
                  ),
          )
        : FilledButton.icon(
            onPressed: isLoading ? null : onPressed,
            style: isDestructive
                ? FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error)
                : null,
            icon: Icon(icon),
            label: isLoading
                ? const CircularProgressIndicator()
                : Text(
                    labelText.toUpperCase(),
                    style: const TextStyle(
                        letterSpacing: 1.5, fontWeight: FontWeight.bold),
                  ),
          );
  }
}

class PrimaryTextButton extends StatelessWidget {
  const PrimaryTextButton(
      {super.key,
      required this.onPressed,
      required this.labelText,
      this.isLoading = false,
      this.icon,
      this.isDestructive = false});

  final VoidCallback onPressed;
  final String labelText;
  final bool isLoading;
  final IconData? icon;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return icon == null
        ? TextButton(
            style: isDestructive
                ? TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error)
                : null,
            onPressed: isLoading ? null : onPressed,
            child: isLoading
                ? const CircularProgressIndicator()
                : Text(
                    labelText.toUpperCase(),
                    style: const TextStyle(
                        letterSpacing: 1.5, fontWeight: FontWeight.bold),
                  ),
          )
        : TextButton.icon(
            style: isDestructive
                ? TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error)
                : null,
            onPressed: isLoading ? null : onPressed,
            icon: Icon(icon),
            label: isLoading
                ? const CircularProgressIndicator()
                : Text(
                    labelText.toUpperCase(),
                    style: const TextStyle(
                        letterSpacing: 1.5, fontWeight: FontWeight.bold),
                  ),
          );
  }
}
