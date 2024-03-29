import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/common_buttons.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/sponsored_corps_card/sponsored_corps_card_controller.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// [SponsoredCorpsCard] on the profile page allows the user to select a
/// Drum Corps that will receive their donation at the end of the season.
class SponsoredCorpsCard extends ConsumerStatefulWidget {
  const SponsoredCorpsCard({Key? key}) : super(key: key);

  @override
  ConsumerState<SponsoredCorpsCard> createState() => _SponsoredCorpsCardState();
}

class _SponsoredCorpsCardState extends ConsumerState<SponsoredCorpsCard> {
  final _formKey = GlobalKey<FormState>();
  DrumCorps? _selectedCorps;

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(sponsoredCorpsCardControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(sponsoredCorpsCardControllerProvider);

    return AsyncValueWidget(
      value: ref.watch(playerStreamProvider),
      data: (Player? player) {
        final selectedCorps = player?.selectedCorps;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sponsored Drum Corps',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            gapH16,
            Form(
              key: _formKey,
              child: DropdownButtonFormField<DrumCorps>(
                value: selectedCorps,
                decoration: const InputDecoration(labelText: 'Sponsored Corps'),
                items: DrumCorps.values.map((drumCorps) {
                  return DropdownMenuItem<DrumCorps>(
                      value: drumCorps,
                      child: Text(
                        drumCorps.fullName,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ));
                }).toList(),
                onChanged: (DrumCorps? newValue) {
                  setState(() => _selectedCorps = newValue);
                },
              ),
            ),
            gapH16,
            Align(
              alignment: Alignment.bottomRight,
              child: PrimaryTextButton(
                onPressed: _submitSelectedCorps,
                icon: Icons.check,
                isLoading: state.isLoading,
                labelText: 'Save Selection',
              ),
            )
          ],
        );
      },
    );
  }

  // Check that a corps has been selected and submit the choice to the controller
  Future<void> _submitSelectedCorps() async {
    if (_formKey.currentState!.validate()) {
      final controller =
          ref.read(sponsoredCorpsCardControllerProvider.notifier);
      await controller.selectSponsoredCorps(selectedCorps: _selectedCorps!);
    }
  }
}
