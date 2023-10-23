import 'package:fantasy_drum_corps/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton(
      {Key? key, this.customOnPressed, this.alignment = Alignment.center})
      : super(key: key);
  final VoidCallback? customOnPressed;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: TextButton.icon(
        icon: const Icon(Icons.arrow_circle_left_outlined),
        label: const Text('Back'),
        onPressed: customOnPressed ??
            () {
              if (Navigator.of(context).canPop()) {
                context.pop();
              } else {
                context.goNamed(AppRoutes.dashboard.name);
              }
            },
      ),
    );
  }
}
