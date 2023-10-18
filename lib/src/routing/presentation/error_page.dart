import 'package:fantasy_drum_corps/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_sizes.dart';

class RouterErrorPage extends StatelessWidget {
  const RouterErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: pagePadding,
        child: Column(
          children: [
            FaIcon(
              FontAwesomeIcons.triangleExclamation,
              size: 50,
              color: Theme.of(context).colorScheme.error,
            ),
            gapH12,
            Text(
              'Page Not Found'.toUpperCase(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'That page doesn\'t seem to exist.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            gapH24,
            TextButton(
              onPressed: () => context.goNamed(AppRoutes.dashboard.name),
              child: const Text('Back to Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}
