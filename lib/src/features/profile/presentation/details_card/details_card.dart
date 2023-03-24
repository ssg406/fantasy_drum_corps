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

class DetailsCard extends ConsumerStatefulWidget {
  const DetailsCard({Key? key}) : super(key: key);

  @override
  ConsumerState<DetailsCard> createState() => _DetailsCardState();
}

class _DetailsCardState extends ConsumerState<DetailsCard>
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
    return AsyncValueWidget(
      value: ref.watch(playerStreamProvider),
      data: (Player player) {
        return TitledSectionCard(
          title: 'User Details',
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _getImageFile,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Tooltip(
                        message: 'Change Image',
                        child: state.isLoading
                            ? const CircularProgressIndicator()
                            : Avatar(
                                radius: 50,
                                photoUrl: player.photoUrl,
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
                            controller: _nameController
                              ..text = player.displayName ?? '',
                            validator: (input) =>
                                canSubmitDisplayName(input ?? '')
                                    ? null
                                    : getDisplayNameErrors(input ?? ''),
                            decoration: const InputDecoration(
                                labelText: 'Display Name'),
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
      },
    );
  }

  Future<void> _submit() async {
    if (true) {
      final controller = ref.read(detailsCardControllerProvider.notifier);
      await controller.setDisplayName(_nameController.text);
    }
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
