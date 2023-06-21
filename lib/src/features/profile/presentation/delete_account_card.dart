import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/profile_screen_controller.dart';
import 'package:fantasy_drum_corps/src/utils/alert_dialogs.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteAccountCard extends ConsumerStatefulWidget {
  const DeleteAccountCard({Key? key}) : super(key: key);

  @override
  ConsumerState<DeleteAccountCard> createState() => _DeleteAccountCardState();
}

class _DeleteAccountCardState extends ConsumerState<DeleteAccountCard> {
  bool _showPasswordField = false;
  String? _errorText;
  final _textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(profileScreenControllerProvider,
            (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(profileScreenControllerProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delete Account',
          style: Theme
              .of(context)
              .textTheme
              .titleMedium,
        ),
        gapH16,
        Text(
          'Deleting your account removes all personal information '
              'that you have stored in Fantasy Drum Corps and cannot be '
              'undone. Lineups you have created will remain on the site to '
              'allow other members to continue in your absence.',
          style: Theme
              .of(context)
              .textTheme
              .bodyLarge,
        ),
        gapH16,
        Row(
          children: [
            if (_showPasswordField)
              Expanded(
                child: TextField(
                  controller: _textController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Current Password',
                    errorText: _errorText,
                  ),
                ),
              ),
            ButtonBar(
              children: [
                if (_showPasswordField)
                  FilledButton(
                    onPressed: () => setState(() => _showPasswordField = false),
                    child: const Text('Cancel'),
                  ),
                FilledButton(
                  onPressed: _deleteAccount,
                  style: FilledButton.styleFrom(
                      backgroundColor: Theme
                          .of(context)
                          .colorScheme
                          .error),
                  child: state.isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Delete Account'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Future<bool> _confirmDelete() async {
    final result = await showAlertDialog(
      context: context,
      title: 'Delete Account',
      content:
      'Are you sure you want to delete your account? This option cannot be undone.',
      defaultActionText: 'Delete',
      cancelActionText: 'Cancel',
    );
    return result ?? false;
  }

  void _deleteAccount() async {
    // Show password field if currently hidden
    if (!_showPasswordField) {
      setState(() => _showPasswordField = true);
      return;
    }
    // Show confirm delete dialog
    final confirmed = await _confirmDelete();
    if (!confirmed) {
      _textController.clear();
      return;
    }

    // Execute the delete method in the controller
    await ref
        .read(profileScreenControllerProvider.notifier)
        .deleteAccount(_textController.text);

    _textController.clear();
  }
}
