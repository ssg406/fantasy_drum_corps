import 'package:fantasy_drum_corps/src/common_widgets/titled_icon_card.dart';
import 'package:fantasy_drum_corps/src/features/dashboard/presentation/dashboard_controller.dart';
import 'package:fantasy_drum_corps/src/utils/app_color_schemes.dart';
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
    return TitledIconCard(
      title: 'Verify Your Email',
      subtitle:
          'Verify your email to make sure you can fully participate this season! A verification email was sent to you when you registered.',
      icon: const FaIcon(
        FontAwesomeIcons.at,
        color: AppColors.customBlue,
      ),
      child: ButtonBar(
        children: [
          TextButton.icon(
            onPressed: () => ref
                .read(dashboardControllerProvider.notifier)
                .sendVerificationEmail(user),
            icon: const FaIcon(FontAwesomeIcons.envelopeOpenText),
            label: state.isLoading
                ? const CircularProgressIndicator()
                : const Text('Resend Verification Email'),
          ),
        ],
      ),
    );
  }
}
