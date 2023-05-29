import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/back_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/not_found.dart';
import 'package:fantasy_drum_corps/src/common_widgets/primary_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/common_widgets/titled_section_card.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/leave_tour/leave_tour_controller.dart';
import 'package:fantasy_drum_corps/src/routing/app_routes.dart';
import 'package:fantasy_drum_corps/src/utils/alert_dialogs.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LeaveTour extends ConsumerWidget {
  const LeaveTour({
    Key? key,
    required this.tourId,
  }) : super(key: key);
  final String tourId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(fetchTourProvider(tourId)),
      data: (Tour? tour) {
        return tour == null ? const NotFound() : LeaveTourContents(tour: tour);
      },
    );
  }
}

class LeaveTourContents extends ConsumerStatefulWidget {
  const LeaveTourContents({
    Key? key,
    required this.tour,
  }) : super(key: key);

  final Tour tour;

  @override
  ConsumerState createState() => _LeaveTourContentsState();
}

class _LeaveTourContentsState extends ConsumerState<LeaveTourContents> {
  late String _tourId;
  late String _name;
  late DateTime _date;

  @override
  void initState() {
    super.initState();
    _tourId = widget.tour.id!;
    _name = widget.tour.name;
    _date = widget.tour.draftDateTime;
  }

  String _getRemainingTime() {
    final remainingDaysInt = _date.difference(DateTime.now()).inDays;
    return '$remainingDaysInt day${remainingDaysInt > 1 ? 's' : ''}';
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(leaveTourControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(leaveTourControllerProvider);
    return SingleChildScrollView(
        child: ResponsiveCenter(
      maxContentWidth: 800,
      child: Padding(
        padding: pagePadding,
        child: Column(
          children: [
            TitledSectionCard(
              title: 'Leave Tour',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Are you sure you want to leave $_name?',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                      'There\'s only ${_getRemainingTime()} days until the draft! Your tour mates will be sad to lose you.'),
                  gapH24,
                  Row(
                    children: [
                      PrimaryButton(
                        isLoading: state.isLoading,
                        onPressed: _leaveTour,
                        label: 'LEAVE',
                      ),
                      PrimaryButton(
                          isLoading: state.isLoading,
                          onPressed: () => context.pop(),
                          label: 'STAY'),
                    ],
                  )
                ],
              ),
            ),
            gapH16,
            CustomBackButton(
              customOnPressed: () => context.pop(),
            ),
          ],
        ),
      ),
    ));
  }

  void _leaveTour() async {
    final controller = ref.read(leaveTourControllerProvider.notifier);
    controller.leaveTour(_tourId);
    await showAlertDialog(
        context: context,
        title: 'Success',
        content: 'You left the tour successfully.');
    if (mounted) {
      context.goNamed(AppRoutes.myTours.name);
    }
  }
}
