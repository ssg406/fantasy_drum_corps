import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/primary_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/titled_section_card.dart';
import 'package:fantasy_drum_corps/src/common_widgets/user_avatar.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/register_screen_validators.dart';
import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/details_card/details_card_controller.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailsCard extends ConsumerWidget {
  const DetailsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(playerStreamProvider),
      data: (Player player) => DetailsCardContents(player: player),
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

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(detailsCardControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(detailsCardControllerProvider);
    return TitledSectionCard(
      title: 'User Details',
      child: Column(
        children: [
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
                      : Avatar(
                          radius: 50,
                          photoUrl: widget.player.photoUrl,
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
                        controller: _nameController
                          ..text = widget.player.displayName ?? '',
                        validator: (input) => canSubmitDisplayName(input ?? '')
                            ? null
                            : getDisplayNameErrors(input ?? ''),
                        decoration:
                            const InputDecoration(labelText: 'Display Name'),
                        onEditingComplete: _submit,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          PrimaryButton(
            onSurface: true,
            onPressed: () => _submit(),
            label: 'Update',
            isLoading: state.isLoading,
          ),
        ],
      ),
    );
  }

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
          onTap: _getImageFile,
          child: const ListTile(
            leading: Icon(Icons.upload),
            title: Text('Upload Image'),
          ),
        ),
        PopupMenuItem(
          enabled: widget.player.photoUrl != null,
          onTap: _clearProfileImage,
          child: const ListTile(
            leading: Icon(Icons.delete_forever),
            title: Text('Clear Image'),
          ),
        ),
      ],
    );
  }

  Future<void> _submit() async {
    if (true) {
      final controller = ref.read(detailsCardControllerProvider.notifier);
      await controller.setDisplayName(_nameController.text);
    }
  }

  Future<void> _clearProfileImage() async {
    final controller = ref.read(detailsCardControllerProvider.notifier);
    await controller.clearUploadedImage(widget.player.photoUrl!);
  }

  Future<void> _getImageFile() async {
    FilePickerResult? result;
    if (kIsWeb) {
      result = await FilePickerWeb.platform.pickFiles();
    } else {
      result = await FilePicker.platform.pickFiles();
    }
    if (result != null) {
      final controller = ref.read(detailsCardControllerProvider.notifier);
      await controller.uploadAvatarImage(result);
    }
  }
}
