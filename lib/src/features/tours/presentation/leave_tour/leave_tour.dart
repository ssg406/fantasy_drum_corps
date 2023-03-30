import 'package:fantasy_drum_corps/src/common_widgets/primary_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/common_widgets/titled_section_card.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/leave_tour/leave_tour_controller.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:fantasy_drum_corps/src/utils/alert_dialogs.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LeaveTour extends ConsumerStatefulWidget {
  const LeaveTour({
    Key? key,
    required this.tourId,
    this.tour,
  }) : super(key: key);

  final String tourId;
  final Tour? tour;

  @override
  ConsumerState createState() => _LeaveTourState();
}

class _LeaveTourState extends ConsumerState<LeaveTour> {
  late String _tourId;
  late String _name;
  late DateTime _date;

  @override
  void initState() {
    super.initState();
    if (widget.tour != null) {
      _tourId = widget.tourId;
      _name = widget.tour!.name;
      _date = widget.tour!.draftDateTime;
    }
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
    return widget.tour == null
        ? Container()
        : SingleChildScrollView(
            child: ResponsiveCenter(
            maxContentWidth: 800,
            child: Padding(
              padding: pagePadding,
              child: TitledSectionCard(
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
