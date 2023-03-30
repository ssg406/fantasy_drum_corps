import 'package:fantasy_drum_corps/src/common_widgets/primary_button.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ManageDraft extends StatelessWidget {
  const ManageDraft({Key? key, required this.tourId, required this.tour})
      : super(key: key);

  final String tourId;
  final Tour tour;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Manage Draft',
          style: Theme
              .of(context)
              .textTheme
              .titleMedium,
        ),
        gapH8,
        Text(
          'Use the links below to get to initiate the draft process and get to the draft. Other players will be notified and the countdown will be started.',
          style: Theme
              .of(context)
              .textTheme
              .bodyLarge,
        ),
        gapH8,
        Row(
          children: [
            PrimaryButton(
              onPressed: () => debugPrint('start draft'),
              isLoading: false,
              label: 'START DRAFT',
            ),
            PrimaryButton(
              onPressed: () =>
                  context.goNamed(
                    AppRoutes.draft.name,
                    params: {'tid': tourId},
                  ),
              isLoading: false,
              label: 'GO TO DRAFT',
            ),
          ],
        ),
      ],
    );
  }

  void _startDraft() {
    // Send request to socket server with tour ID
  }
}
