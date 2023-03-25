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
import 'package:go_router/go_router.dart';
import 'package:mime/mime.dart';

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
  static const imageMaxSize = 5000000;

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
          PrimaryButton(
            onSurface: true,
            onPressed: () => _submitDisplayName(),
            label: 'Update',
            isLoading: state.isLoading,
          ),
        ],
      ),
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

  // Submit display name changes to controller
  Future<void> _submitDisplayName() async {
    if (_formKey.currentState!.validate()) {
      final controller = ref.read(detailsCardControllerProvider.notifier);
      await controller.setDisplayName(displayName);
    }
  }

  // Clear the existing profile image from the application
  Future<void> _clearProfileImage() async {
    final controller = ref.read(detailsCardControllerProvider.notifier);
    await controller.clearUploadedImage(widget.player.photoUrl!);
  }

  // Display file upload dialog to user and retrieve selected file
  Future<void> _getImageFile() async {
    FilePickerResult? result;
    if (kIsWeb) {
      result = await FilePickerWeb.platform.pickFiles();
    } else {
      result = await FilePicker.platform.pickFiles();
    }
    if (result == null) {
      return;
    }

    if (!_validateImage(result)) {
      _showImageErrorDialog();
      return;
    }
    final controller = ref.read(detailsCardControllerProvider.notifier);
    await controller.uploadAvatarImage(result);
  }
  // Check file is an image and under the given max size
  bool _validateImage(FilePickerResult result) {
    final bytes = result.files.first.bytes;
    final size = result.files.single.size;
    final mimeType = lookupMimeType('', headerBytes: bytes) ?? '';
    return mimeType.startsWith('image') && size < imageMaxSize;
  }

  // Inform the user the file has not been accepted for upload
  void _showImageErrorDialog() async {
    await showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Invalid File'),
        content: const Text('Please make sure you have selected a valid image under 5MB in size'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Okay'),
          )
        ],
      );
    });
  }
}
