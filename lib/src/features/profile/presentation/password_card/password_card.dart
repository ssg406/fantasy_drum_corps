import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/register_screen_validators.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/password_card/password_card_controller.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Allows user to alter password and verifies existing password before updating
class PasswordCard extends ConsumerStatefulWidget {
  const PasswordCard({Key? key}) : super(key: key);

  @override
  ConsumerState<PasswordCard> createState() => _PasswordCardState();
}

class _PasswordCardState extends ConsumerState<PasswordCard>
    with RegistrationValidators {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _currentPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              'Change Password',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            gapH16,
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _currentPasswordController,
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
                    controller: _newPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                    ),
                  ),
                  gapH16,
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FilledButton(
                      onPressed: _submitPassword,
                      child: state.isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Save Password'),
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

  // Submit updated password to controller
  Future<void> _submitPassword() async {
    final controller = ref.read(passwordCardControllerProvider.notifier);
    await controller.updatePassword(
        currentPassword: _currentPasswordController.text,
        newPassword: _newPasswordController.text);

    _currentPasswordController.clear();
    _newPasswordController.clear();
  }
}
