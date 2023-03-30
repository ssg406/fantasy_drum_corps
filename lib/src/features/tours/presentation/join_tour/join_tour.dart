import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/not_found.dart';
import 'package:fantasy_drum_corps/src/common_widgets/primary_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/common_widgets/titled_section_card.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/join_tour/join_tour_controller.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:fantasy_drum_corps/src/utils/alert_dialogs.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class JoinTour extends ConsumerWidget {
  const JoinTour({
    Key? key,
    this.tourId,
  }) : super(key: key);

  final String? tourId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.read(fetchTourProvider(tourId!)),
      data: (Tour? tour) {
        return tour == null ? const NotFound() : JoinTourContents(tour: tour);
      },
    );
  }
}

class JoinTourContents extends ConsumerStatefulWidget {
  const JoinTourContents({
    Key? key,
    required this.tour,
  }) : super(key: key);

  final Tour tour;

  @override
  ConsumerState<JoinTourContents> createState() => _JoinTourContentsState();
}

class _JoinTourContentsState extends ConsumerState<JoinTourContents> {
  late bool _isPublic;
  late String? _password;
  late String _tourId;
  late String _name;
  String? _enteredPassword;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _isPublic = widget.tour.isPublic;
    _password = widget.tour.password;
    _tourId = widget.tour.id!;
    _name = widget.tour.name;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(joinTourControllerProvider,
            (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(joinTourControllerProvider);
    return SingleChildScrollView(
      child: ResponsiveCenter(
        maxContentWidth: 800,
        child: Padding(
          padding: pagePadding,
          child:
          TitledSectionCard(
            title: 'Are you sure?',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Are you ready to join the tour $_name?',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium,
                ),
                gapH24,
                if (!_isPublic) ...[
                  Text(
                    'Enter tour password',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium,
                  ),
                  gapH8,
                  TextField(
                    onChanged: (input) => _enteredPassword = input,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.lock_outline_rounded),
                      labelText: 'Password',
                      errorText: _errorText,
                    ),
                  ),
                  gapH24,
                ],
                Row(
                  children: [
                    PrimaryButton(
                        onPressed: () => _submit(),
                        label: 'JOIN',
                        isLoading: state.isLoading),
                    PrimaryButton(
                      onPressed: () => context.pop(),
                      label: 'CANCEL',
                      isLoading: state.isLoading,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() async {
    final controller = ref.read(joinTourControllerProvider.notifier);

    if (!_isPublic && (_enteredPassword != _password)) {
      setState(() =>
      _errorText = 'Please check that you entered the password correctly.');
      return;
    }
    await controller.joinTour(tourId: _tourId);
    if (mounted) {
      showAlertDialog(
          context: context,
          title: 'Joined Tour!',
          content: 'Tour joined successfully!');
    }
    if (mounted) {
      context.goNamed(AppRoutes.searchTours.name);
    }
  }
}
