import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/error_message_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/primary_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/primary_text_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/titled_section_card.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/profile/data/user_corps_repository.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/sponsored_corps_card/sponsored_corps_card_controller.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:fantasy_drum_corps/src/utils/static_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SponsoredCorpsCard extends ConsumerStatefulWidget {
  const SponsoredCorpsCard({Key? key}) : super(key: key);

  @override
  ConsumerState<SponsoredCorpsCard> createState() => _SponsoredCorpsCardState();
}

class _SponsoredCorpsCardState extends ConsumerState<SponsoredCorpsCard> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCorps;
  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(sponsoredCorpsCardControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(sponsoredCorpsCardControllerProvider);
    return AsyncValueWidget(
      value: ref.watch(selectedCorpsProvider),
      data: (String? selectedCorps) {
        return TitledSectionCard(
          title: 'Sponsored Drum Corps',
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: DropdownButtonFormField<String>(
                  value: selectedCorps,
                  validator: (String? selection) {
                    return selection == null ? 'Please make a selection' : null;
                  },
                  decoration:
                      const InputDecoration(labelText: 'Sponsored Corps'),
                  items: DrumCorpsData.allNames.map<DropdownMenuItem<String>>(
                    (String corps) {
                      return DropdownMenuItem<String>(
                        value: corps,
                        child: Text(corps),
                      );
                    },
                  ).toList(),
                  onChanged: (String? newValue) {
                    setState(() => _selectedCorps = newValue);
                  },
                ),
              ),
              gapH20,
              PrimaryButton(
                onSurface: true,
                label: 'Change Selection',
                isLoading: state.isLoading,
                onPressed: _submitSelection,
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _submitSelection() async {
    if (_formKey.currentState!.validate()) {
      final controller =
          ref.read(sponsoredCorpsCardControllerProvider.notifier);
      await controller.selectSponsoredCorps(selectedCorps: _selectedCorps!);
    }
  }
}
