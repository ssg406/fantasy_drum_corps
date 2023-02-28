import 'package:fantasy_drum_corps/src/common_widgets/primary_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/leagues/presentation/create_league_controller.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Interface to create new [League] and choose public or private league
class CreateLeague extends ConsumerStatefulWidget {
  const CreateLeague({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateLeague> createState() => _CreateLeagueState();
}

class _CreateLeagueState extends ConsumerState<CreateLeague> {
  bool _publicSelected = false;
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String get name => _nameController.text;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  Future<void> _submit() async {
    final controller = ref.read(createLeagueControllerProvider.notifier);
    await controller.submit(leagueName: name, isPublic: _publicSelected);
  }

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      // Thumb icon when the switch is selected.
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.lock_open);
      }
      return const Icon(Icons.lock);
    },
  );

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(createLeagueControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(createLeagueControllerProvider);
    return ResponsiveCenter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
        child: Column(children: [
          Text('Create League', style: Theme.of(context).textTheme.titleLarge),
          gapH8,
          const Divider(thickness: 0.5),
          gapH16,
          Card(
            elevation: 2.0,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 25.0, horizontal: 45.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    gapH16,
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'League Name',
                        hintText: 'Fuzzy Tumblers',
                      ),
                    ),
                    gapH32,
                    Text('Make League Public',
                        style: Theme.of(context).textTheme.titleSmall),
                    gapH8,
                    Row(
                      children: [
                        Switch(
                            value: _publicSelected,
                            thumbIcon: thumbIcon,
                            onChanged: (value) =>
                                setState(() => _publicSelected = value)),
                        gapW8,
                        Text(_publicSelected ? 'Public' : 'Private',
                            style: Theme.of(context).textTheme.labelLarge),
                      ],
                    ),
                    gapH16,
                    // TODO create date of league draft
                    // TODO league size
                    Center(
                      child: PrimaryButton(
                          onPressed: _submit,
                          label: 'CREATE',
                          isLoading: state.isLoading,
                          onSurface: true),
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
