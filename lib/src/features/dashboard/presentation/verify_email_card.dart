import 'package:fantasy_drum_corps/src/common_widgets/common_buttons.dart';
import 'package:fantasy_drum_corps/src/common_widgets/titled_icon_card.dart';
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
    return TitledIconCard(
      title: 'Verify Your Email',
      subtitle:
          'Verify your email to make sure you can fully participate this season! A verification email was sent to you when you registered.',
      iconData: FontAwesomeIcons.at,
      child: ButtonBar(
        children: [
          PrimaryActionButton(
            onPressed: () => ref
                .read(dashboardControllerProvider.notifier)
                .sendVerificationEmail(user),
            icon: Icons.email_rounded,
            labelText: 'Resend Verification Email',
            isLoading: state.isLoading,
          ),
        ],
      ),
    );
  }
}
