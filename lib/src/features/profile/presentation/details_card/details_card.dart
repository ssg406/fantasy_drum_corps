import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/user_avatar.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/register_screen_validators.dart';
import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/details_card/details_card_controller.dart';
import 'package:fantasy_drum_corps/src/routing/app_routes.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widgets/common_buttons.dart';

/// [DetailsCard] presents a UI that allows the user to change their display
/// name and update or remove their profile image
class DetailsCard extends ConsumerWidget {
  const DetailsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get player object and pass to widget
    return AsyncValueWidget(
      value: ref.watch(playerStreamProvider),
      data: (Player? player) =>
          player == null ? Container() : DetailsCardContents(player: player),
    );
  }
}

class DetailsCardContents extends ConsumerStatefulWidget {
  const DetailsCardContents({Key? key, required this.player}) : super(key: key);

  final Player player;

  @override
  ConsumerState createState() => _DetailsCardContentsState();
}

class _DetailsCardContentsState extends ConsumerState<DetailsCardContents>
    with RegistrationValidators {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  String get displayName => _nameController.text;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onDisplayNameEditingComplete() {
    if (!canSubmitDisplayName(displayName)) {
      return;
    }
    _submitDisplayName();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(detailsCardControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(detailsCardControllerProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Avatar and Display Name',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        gapH16,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTapDown: (tapDetails) =>
                  _showAvatarMenu(tapDetails.globalPosition),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: state.isLoading
                    ? const CircularProgressIndicator()
                    : Tooltip(
                        message: 'Edit Avatar',
                        child: Avatar(
                          size: 100,
                          avatarString: widget.player.avatarString,
                        ),
                      ),
              ),
            ),
            gapW24,
            Expanded(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      enabled: !state.isLoading,
                      controller: _nameController
                        ..text = widget.player.displayName ?? '',
                      validator: (input) => canSubmitDisplayName(input ?? '')
                          ? null
                          : getDisplayNameErrors(input ?? ''),
                      decoration:
                          const InputDecoration(labelText: 'Display Name'),
                      onEditingComplete: _onDisplayNameEditingComplete,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: PrimaryTextButton(
            onPressed: _submitDisplayName,
            icon: Icons.check,
            isLoading: state.isLoading,
            labelText: 'Save',
          ),
        ),
      ],
    );
  }

  // Display pop up menu on click of avatar that allows user to add a new
  // profile image or clear an existing one
  void _showAvatarMenu(clickPosition) async {
    Size screenSize = MediaQuery.of(context).size;
    double left = clickPosition.dx;
    double top = clickPosition.dy;
    double right = screenSize.width - left;
    double bottom = screenSize.height - top;

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, right, bottom),
      items: [
        PopupMenuItem(
          onTap: () => context.pushNamed(AppRoutes.createFluttermoji.name,
              pathParameters: {'uid': widget.player.playerId!}),
          child: const ListTile(
            leading: Icon(Icons.upload),
            title: Text('Create Avatar'),
          ),
        ),
        PopupMenuItem(
          enabled: widget.player.avatarString != null,
          onTap: _clearUserAvatar,
          child: const ListTile(
            leading: Icon(Icons.delete_forever),
            title: Text('Clear Avatar'),
          ),
        ),
      ],
    );
  }

  // Submit display name changes to controller
  Future<void> _submitDisplayName() async {
    if (_formKey.currentState!.validate()) {
      final controller = ref.read(detailsCardControllerProvider.notifier);
      await controller.setDisplayName(displayName);
    }
  }

  // Clear the existing profile image from the application
  Future<void> _clearUserAvatar() async {
    final controller = ref.read(detailsCardControllerProvider.notifier);
    await controller.clearUserAvatar();
  }
}
