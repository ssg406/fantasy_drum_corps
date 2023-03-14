import 'package:fantasy_drum_corps/src/common_widgets/alert_dialogs.dart';
import 'package:fantasy_drum_corps/src/common_widgets/primary_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/create_tour_controller.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Interface to create new [Tour] and choose public or private tour
class CreateTour extends ConsumerStatefulWidget {
  const CreateTour({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateTour> createState() => _CreateTourState();
}

class _CreateTourState extends ConsumerState<CreateTour> {
  bool _publicSelected = false;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime? pickedDate;
  TimeOfDay? pickedTime;

  String get name => _nameController.text;
  String get description => _descriptionController.text;

  @override
  void dispose() {
    _descriptionController.dispose();
    _passwordController.dispose();
    _dateController.dispose();
    _nameController.dispose();
    _timeController.dispose();
    super.dispose();
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
    ref.listen<AsyncValue>(createTourControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(createTourControllerProvider);
    return SingleChildScrollView(
      child: ResponsiveCenter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
          child: Column(children: [
            Text('Create Tour', style: Theme.of(context).textTheme.titleLarge),
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
                        validator: (String? input) => (input ?? '').isEmpty
                            ? 'Please enter a name'
                            : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'Tour Name',
                          hintText: 'Fuzzy Tumblers',
                        ),
                      ),
                      gapH32,
                      TextFormField(
                        controller: _descriptionController,
                        validator: (String? input) => (input ?? '').isEmpty
                            ? 'Please enter a description'
                            : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          hintText: 'A tour for alumni of the 2001 Bluecoats',
                        ),
                      ),
                      gapH32,
                      Text('Make Tour Public',
                          style: Theme.of(context).textTheme.labelLarge),
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
                      gapH32,
                      if (!_publicSelected) ...[
                        TextFormField(
                            controller: _passwordController,
                            validator: (input) {
                              if (_publicSelected) {
                                return null;
                              }
                              return (input ?? '').isEmpty
                                  ? 'Please enter a password'
                                  : null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                                labelText: 'Tour Password',
                                hintText:
                                    'Other players will need this password to join')),
                        gapH32
                      ],
                      Text(
                        'Select a date and time here for the convenience of your tour members. You will need to sign in and start the draft yourself when ready.',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      gapH32,
                      TextFormField(
                          controller: _dateController,
                          validator: (input) => (input ?? '').isEmpty
                              ? 'Please enter a date'
                              : null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.calendar_today),
                            labelText: 'Draft Date',
                          ),
                          readOnly: true,
                          onTap: () async {
                            pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2023, 6, 1));

                            if (pickedDate != null) {
                              String formattedDate = DateFormat.yMMMMd('en_US')
                                  .format(pickedDate!);
                              setState(() {
                                _dateController.text = formattedDate;
                              });
                            }
                          }),
                      gapH32,
                      TextFormField(
                        controller: _timeController,
                        validator: (input) => (input ?? '').isEmpty
                            ? 'Please enter a time'
                            : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.access_time_rounded),
                            labelText: 'Draft Time'),
                        readOnly: true,
                        onTap: () async {
                          pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            initialEntryMode: TimePickerEntryMode.input,
                          );
                          if (pickedTime != null) {
                            setState(() {
                              _timeController.text =
                                  pickedTime!.format(context);
                            });
                          }
                        },
                      ),
                      gapH32,
                      Center(
                        child: PrimaryButton(
                            onPressed: _submitTour,
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
      ),
    );
  }

  void _submitTour() async {
    if (_formKey.currentState!.validate()) {
      final controller = ref.read(createTourControllerProvider.notifier);
      final tourDraftTime = DateTime(pickedDate!.year, pickedDate!.month,
          pickedDate!.day, pickedTime!.hour, pickedTime!.minute);
      await controller.submitTour(
        name: name,
        description: description,
        isPublic: _publicSelected,
        password: _passwordController.text,
        draftDateTime: tourDraftTime,
      );
    }
    _confirmCreation();
  }

  void _confirmCreation() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tour Created'),
          content: const Text(
              'Congratulations on your new tour! Let your friends know and make sure to give them the password if you created a private tour. Remember to log back in to initate the draft at your chosen time!'),
          actions: [
            TextButton(
              onPressed: () => context.goNamed(AppRoutes.myTours.name),
              child: const Text('Back to Tours'),
            )
          ],
        );
      },
    );
  }
}
