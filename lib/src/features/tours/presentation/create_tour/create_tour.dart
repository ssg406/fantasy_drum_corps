import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/common_buttons.dart';
import 'package:fantasy_drum_corps/src/common_widgets/date_time_picker.dart';
import 'package:fantasy_drum_corps/src/common_widgets/not_found.dart';
import 'package:fantasy_drum_corps/src/common_widgets/page_scaffold.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/create_tour/create_tour_controller.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/create_tour/incomplete_profile.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/create_tour/private_tour_switch.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/create_tour/tour_validators.dart';
import 'package:fantasy_drum_corps/src/routing/app_routes.dart';
import 'package:fantasy_drum_corps/src/utils/alert_dialogs.dart';
import 'package:fantasy_drum_corps/src/utils/datetime_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class CreateTour extends ConsumerWidget {
  const CreateTour({
    Key? key,
    this.tourId,
  }) : super(key: key);

  final String? tourId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (tourId == null) {
      return AsyncValueWidget(
          value: ref.watch(playerStreamProvider),
          data: (Player? player) {
            final hasDisplayName = player?.hasDisplayName ?? false;
            return AsyncValueWidget(
              value: ref.watch(userChangesStreamProvider),
              data: (User? user) {
                _reloadUser(user);
                final emailVerified = user?.emailVerified ?? false;
                return hasDisplayName && emailVerified
                    ? const CreateTourContents()
                    : const IncompleteProfileWarning();
              },
            );
          });
    } else {
      return AsyncValueWidget(
          value: ref.watch(fetchTourProvider(tourId!)),
          data: (Tour? tour) =>
              tour == null ? const NotFound() : CreateTourContents(tour: tour));
    }
  }

  void _reloadUser(User? user) async {
    await user?.reload();
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
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createTourControllerProvider);
    return PageScaffolding(
      pageTitle: editing ? 'Edit Tour' : 'Create Tour',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gapH16,
            TextFormField(
              initialValue: _name,
              onChanged: (value) => _name = value,
              validator: (String? input) => getNameErrors(input ?? ''),
              decoration: const InputDecoration(
                labelText: 'Tour Name',
                hintText: 'Cadets Alumni 99',
              ),
            ),
            gapH32,
            TextFormField(
              initialValue: _description,
              onChanged: (value) => _description = value,
              validator: (String? input) => getDescriptionErrors(input ?? ''),
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'A tour for alumni of the 1999 Cadets',
              ),
            ),
            gapH32,
            Flex(
              direction:
                  ResponsiveBreakpoints.of(context).largerOrEqualTo(TABLET)
                      ? Axis.horizontal
                      : Axis.vertical,
              mainAxisAlignment:
                  ResponsiveBreakpoints.of(context).largerOrEqualTo(TABLET)
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
              children: [
                PrivateTourSwitch(
                  publicSelected: _publicSelected,
                  onChanged: (selected) =>
                      setState(() => _publicSelected = selected),
                ),
                if (!_publicSelected)
                  SizedBox(
                    width: 200,
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
              child: PrimaryActionButton(
                onPressed: editing ? _submitEditedTour : _submitNewTour,
                labelText: editing ? 'UPDATE' : 'CREATE',
                isLoading: state.isLoading,
                icon: Icons.add,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validate() {
    // First check that form validators pass
    if (_formKey.currentState!.validate()) {
      // Check if either date and time are null
      if (pickedDate == null || pickedTime == null) {
        // Error if no date or time was saved
        setState(
            () => _dateTimeErrorText = 'Please enter a draft date and time');
        // Fail validation: missing date
        return false;
      } else {
        // Pass: date and time set and form passes
        return true;
      }
    }
    // Form validators did not pass
    return false;
  }

  void _submitEditedTour() async {
    if (!_validate()) return;
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
        draftComplete: false);
    controller.updateTour(updatedTour);
    _showSuccessMessage();
    context.goNamed(AppRoutes.dashboard.name);
  }

  void _submitNewTour() async {
    if (!_validate()) return;
    final draftDateTime =
        DateTimeUtils.combineDateAndTime(pickedDate!, pickedTime!);
    final tour = Tour(
        name: _name!,
        description: _description!,
        isPublic: _publicSelected,
        password: _password,
        owner: '',
        members: [],
        draftDateTime: draftDateTime,
        draftComplete: false);
    ref.read(createTourControllerProvider.notifier).submitTour(tour);
    _showSuccessMessage();
    context.goNamed(AppRoutes.dashboard.name);
  }

  void _showSuccessMessage() {
    showAlertDialog(
        context: context,
        title: editing ? 'Tour Updated' : 'Tour Created',
        content: editing
            ? 'Tour updated successfully. Have fun!'
            : 'Tour created successfully! Invite your friends and get ready for the draft!');
  }
}
