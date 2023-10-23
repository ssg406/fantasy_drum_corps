import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class DraftServerError extends StatelessWidget {
  const DraftServerError({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: pagePadding,
        child: Column(
          children: [
            FaIcon(
              FontAwesomeIcons.circleExclamation,
              size: 50,
              color: Theme.of(context).colorScheme.error,
            ),
            gapH24,
            Text(
              'Server Error'.toUpperCase(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              message ??
                  'The draft server experienced a fatal error. The tour owner can attempt to restart the draft when ready. If the problem persists, please contact us.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            gapH12,
            TextButton(
              onPressed: () => context.goNamed(AppRoutes.tours.name),
              child: const Text('Back to Tours'),
            ),
          ],
        ),
      ),
    );
  }
}
