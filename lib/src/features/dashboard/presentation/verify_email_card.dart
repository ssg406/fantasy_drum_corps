import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/dashboard/presentation/dashboard_controller.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VerifyEmailCard extends ConsumerWidget {
  const VerifyEmailCard({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(dashboardControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(dashboardControllerProvider);
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.primaryContainer.withOpacity(0.5),
      child: Padding(
        padding: cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const FaIcon(FontAwesomeIcons.at),
                gapW16,
                Text('Verify your email',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            gapH8,
            Text(
              'Verify your email to make sure you can fully participate this season!',
              style: theme.textTheme.bodyLarge,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton.icon(
                style: TextButton.styleFrom(foregroundColor: Colors.white),
                onPressed: () => ref
                    .read(dashboardControllerProvider.notifier)
                    .sendVerificationEmail(user),
                icon: const FaIcon(FontAwesomeIcons.envelopeOpenText),
                label: state.isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Verify Email'),
              ),
            )
          ],
        ),
      ),
    );
  }
}