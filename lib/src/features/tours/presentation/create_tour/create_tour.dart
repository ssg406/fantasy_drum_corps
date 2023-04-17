import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/back_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/date_time_picker.dart';
import 'package:fantasy_drum_corps/src/common_widgets/not_found.dart';
import 'package:fantasy_drum_corps/src/common_widgets/primary_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/create_tour/create_tour_controller.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/create_tour/private_tour_switch.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/create_tour/tour_validators.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:fantasy_drum_corps/src/utils/alert_dialogs.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:fantasy_drum_corps/src/utils/datetime_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateTour extends ConsumerWidget {
  const CreateTour({
    Key? key,
    this.tourId,
  }) : super(key: key);

  final String? tourId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return tourId == null
        ? const CreateTourContents()
        : AsyncValueWidget(
            value: ref.watch(fetchTourProvider(tourId!)),
            data: (Tour? tour) => tour == null
                ? const NotFound()
                : CreateTourContents(tour: tour));
  }
}

class CreateTourContents extends ConsumerStatefulWidget {
  const CreateTourContents({Key? key, this.tour}) : super(key: key);

  final Tour? tour;

  @override
  ConsumerState createState() => _CreateTourContentsState();
}

class _CreateTourContentsState extends ConsumerState<CreateTourContents>
    with TourValidators {
  bool _publicSelected = true;
  String? _id;
  String? _name;
  String? _description;
  String? _password;
  List<String>? _members;
  final _formKey = GlobalKey<FormState>();
  DateTime? pickedDate;
  TimeOfDay? pickedTime;
  bool editing = false;
  String? _dateTimeErrorText;

  @override
  void initState() {
    if (widget.tour != null) {
      editing = true;
      _id = widget.tour!.id;
      _name = widget.tour!.name;
      _description = widget.tour!.description;
      _password = widget.tour?.password;
      pickedDate = DateTimeUtils.dateTimeFromCombinedDateTime(
          widget.tour!.draftDateTime);
      pickedTime = DateTimeUtils.timeOfDayFromCombinedDateTime(
          widget.tour!.draftDateTime);
      _publicSelected = widget.tour!.isPublic;
      _members = widget.tour!.members;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(createTourControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(createTourControllerProvider);
    return SingleChildScrollView(
      child: ResponsiveCenter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
          child: Column(
            children: [
              Text(editing ? 'Edit Tour' : 'Create Tour',
                  style: Theme.of(context).textTheme.titleLarge),
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
                          initialValue: _name,
                          onChanged: (value) => _name = value,
                          validator: (String? input) =>
                              getNameErrors(input ?? ''),
                          decoration: const InputDecoration(
                            labelText: 'Tour Name',
                            hintText: 'Cadets Alumni 99',
                          ),
                        ),
                        gapH32,
                        TextFormField(
                          initialValue: _description,
                          onChanged: (value) => _description = value,
                          validator: (String? input) =>
                              getDescriptionErrors(input ?? ''),
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            hintText: 'A tour for alumni of the 1999 Cadets',
                          ),
                        ),
                        gapH32,
                        Row(
                          children: [
                            PrivateTourSwitch(
                              publicSelected: _publicSelected,
                              onChanged: (selected) =>
                                  setState(() => _publicSelected = selected),
                            ),
                            if (!_publicSelected) gapW32,
                            if (!_publicSelected)
                              Expanded(
                                child: TextFormField(
                                  initialValue: _password,
                                  onChanged: (value) => _password = value,
                                  validator: (input) {
                                    if (_publicSelected) {
                                      return null;
                                    }
                                    return getPasswordErrors(input ?? '');
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Tour Password',
                                      hintText:
                                          'Other players will need this password to join'),
                                ),
                              ),
                          ],
                        ),
                        DateTimePicker(
                          labelText:
                              'Select a tour draft date and time. You will still need to sign in and initiate the draft as the tour owner.',
                          selectedDate: pickedDate,
                          selectedTime: pickedTime,
                          dateTimeErrorText: _dateTimeErrorText,
                          onSelectedDate: (selectedDate) =>
                              setState(() => pickedDate = selectedDate),
                          onSelectedTime: (selectedTime) =>
                              setState(() => pickedTime = selectedTime),
                        ),
                        gapH32,
                        Center(
                          child: PrimaryButton(
                            onPressed:
                                editing ? _submitEditedTour : _submitNewTour,
                            label: editing ? 'UPDATE' : 'CREATE',
                            isLoading: state.isLoading,
                            onSurface: true,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              gapH16,
              CustomBackButton(
                customOnPressed: () => context.pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validate() {
    if (_formKey.currentState!.validate()) {
      if (pickedDate == null || pickedTime == null) {
        setState(
            () => _dateTimeErrorText = 'Please enter a draft date and time');
        return false;
      }
      return true;
    }
    return false;
  }

  void _submitEditedTour() async {
    if (!_validate()) return;
    debugPrint(
        'submitted values: name: $_name, description: $_description, public: $_publicSelected, password: $_password, owner: ${widget.tour!.owner},  pickedDate: $pickedDate, pickedTime: $pickedTime');
    final controller = ref.read(createTourControllerProvider.notifier);
    final draftDateTime =
        DateTimeUtils.combineDateAndTime(pickedDate!, pickedTime!);
    final updatedTour = Tour(
        id: _id,
        name: _name!,
        description: _description!,
        isPublic: _publicSelected,
        password: _password,
        owner: widget.tour!.owner,
        members: _members!,
        draftDateTime: draftDateTime,
        draftActive: false);
    await controller.updateTour(updatedTour);
    _showSuccessMessage();
  }

  void _submitNewTour() async {
    if (!_validate()) return;
    final controller = ref.read(createTourControllerProvider.notifier);
    final draftDateTime =
        DateTimeUtils.combineDateAndTime(pickedDate!, pickedTime!);
    await controller.submitTour(
      name: _name!,
      description: _description!,
      isPublic: _publicSelected,
      password: _password,
      draftDateTime: draftDateTime,
    );
    _showSuccessMessage();
  }

  void _showSuccessMessage() async {
    showAlertDialog(
        context: context,
        title: editing ? 'Tour Updated' : 'Tour Created',
        content: editing
            ? 'Tour updated successfully. Have fun!'
            : 'Tour created successfully! Invite your friends and get ready for the draft!');
    context.goNamed(AppRoutes.myTours.name);
  }
}
