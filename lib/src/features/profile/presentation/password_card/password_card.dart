import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/common_buttons.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/register_screen_validators.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/password_card/password_card_controller.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Allows user to alter password and verifies existing password before updating
class PasswordCard extends ConsumerWidget with RegistrationValidators {
  const PasswordCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();

    ref.listen<AsyncValue>(passwordCardControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(passwordCardControllerProvider);

    return AsyncValueWidget(
      value: ref.watch(userChangesStreamProvider),
      data: (User? user) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            gapH16,
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: currentPasswordController,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please enter your password';
                      } else {
                        return null;
                      }
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Current Password',
                      hintText: 'Verify current password to change password',
                    ),
                  ),
                  gapH16,
                  TextFormField(
                    validator: (input) => getPasswordErrors(input ?? ''),
                    obscureText: true,
                    controller: newPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                    ),
                  ),
                  gapH16,
                  Align(
                    alignment: Alignment.bottomRight,
                    child: PrimaryTextButton(
                      onPressed: () async {
                        await ref
                            .read(passwordCardControllerProvider.notifier)
                            .updatePassword(
                                currentPassword: currentPasswordController.text,
                                newPassword: newPasswordController.text);
                        currentPasswordController.clear();
                        newPasswordController.clear();
                      },
                      labelText: 'Save Password',
                      icon: Icons.check,
                      isLoading: state.isLoading,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
