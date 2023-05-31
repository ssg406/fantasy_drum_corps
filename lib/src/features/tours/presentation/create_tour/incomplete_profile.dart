import 'package:fantasy_drum_corps/src/common_widgets/page_scaffold.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IncompleteProfileWarning extends StatelessWidget {
  const IncompleteProfileWarning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageScaffolding(
        pageTitle: 'Create Tour',
        child: Column(
          children: [
            Text(
              'Complete Your Profile',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            gapH16,
            Text(
              'Complete your profile by choosing a display name and verifying your email before creating a tour.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            gapH8,
            Text(
              'Check your email and spam folder for a verification email and go to your profile to choose a display name.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            gapH24,
            ButtonBar(
              children: [
                FilledButton(
                  onPressed: () => context.goNamed(AppRoutes.profile.name),
                  child: const Text('Go to Profile'),
                ),
              ],
            )
          ],
        ));
  }
}
