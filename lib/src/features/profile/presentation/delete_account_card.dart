import 'package:fantasy_drum_corps/src/common_widgets/titled_section_card.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/profile_screen_controller.dart';
import 'package:fantasy_drum_corps/src/utils/alert_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteAccountCard extends ConsumerWidget {
  const DeleteAccountCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TitledSectionCard(
        title: 'Delete Account',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deleting your account removes all personal information '
              'that you have stored in Fantasy Drum Corps and cannot be '
              'undone. Lineups you have created will remain on the site to '
              'allow other members to continue in your absence.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            gapH24,
            ElevatedButton(
              onPressed: () {
                _confirmDelete(context).then((confirmed) {
                  if (confirmed ?? false) {
                    ref
                        .read(profileScreenControllerProvider.notifier)
                        .deleteAccount();
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.errorContainer),
              child: Text(
                'DELETE ACCOUNT',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onErrorContainer),
              ),
            ),
          ],
        ));
  }

  Future<bool?> _confirmDelete(BuildContext context) async {
    final result = await showAlertDialog(
      context: context,
      title: 'Delete Account',
      content:
          'Are you sure you want to delete your account? This option cannot be undone.',
      defaultActionText: 'Delete',
      cancelActionText: 'Cancel',
    );
    return result;
  }
}
