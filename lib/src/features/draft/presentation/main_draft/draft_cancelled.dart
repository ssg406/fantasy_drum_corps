import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/app_routes.dart';

class DraftCancelled extends StatelessWidget {
  const DraftCancelled({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: pagePadding,
        child: Column(
          children: [
            FaIcon(
              FontAwesomeIcons.circleXmark,
              size: 50,
              color: Theme.of(context).colorScheme.error,
            ),
            gapH24,
            Text(
              'Draft Cancelled'.toUpperCase(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'The tour owner cancelled the draft, but they can restart it at any point. Check the tour message board or get in touch with them to get an updated time.',
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
