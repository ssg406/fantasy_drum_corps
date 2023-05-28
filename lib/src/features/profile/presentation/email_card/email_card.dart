import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/register_screen_validators.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/email_card/email_card_controller.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EmailCard extends ConsumerStatefulWidget {
  const EmailCard({Key? key}) : super(key: key);

  @override
  ConsumerState<EmailCard> createState() => _EmailCardState();
}

class _EmailCardState extends ConsumerState<EmailCard>
    with RegistrationValidators {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? currentEmail;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(emailCardControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(emailCardControllerProvider);

    return AsyncValueWidget(
      value: ref.watch(userChangesStreamProvider),
      //ref.watch(userChangesStreamProvider),
      data: (User? user) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email Address',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            gapH16,
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _emailController..text = user?.email ?? '',
                validator: (input) => canSubmitEmail(input ?? '')
                    ? null
                    : getEmailErrors(input ?? ''),
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                onEditingComplete: _submitEmail,
              ),
            ),
            gapH16,
            Align(
              alignment: Alignment.bottomRight,
              child: FilledButton(
                onPressed: _submitEmail,
                child: state.isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Save'),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Validates email and presents dialog for reauthentication
  Future<void> _submitEmail() {
    final controller = ref.read(emailCardControllerProvider.notifier);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        final passwordController = TextEditingController();
        return AlertDialog(
          title: const Text('Confirm Password'),
          content: TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Current Password',
              hintText: 'Enter current password',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                controller.changeEmail(
                    _emailController.text, passwordController.text);
                context.pop();
              },
              child: const Text('Verify'),
            ),
          ],
        );
      },
    );
  }
}
