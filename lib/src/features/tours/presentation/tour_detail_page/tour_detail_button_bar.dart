import 'package:fantasy_drum_corps/src/features/tours/presentation/tour_detail_page/start_draft_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widgets/common_buttons.dart';
import '../../../../routing/app_routes.dart';
import '../../domain/tour_model.dart';

class TourDetailButtonBar extends StatelessWidget {
  const TourDetailButtonBar(
      {Key? key, required this.tour, required this.userId})
      : super(key: key);

  final Tour tour;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      children: [
        if (tour.owner != userId &&
            !tour.members.contains(userId) &&
            tour.slotsAvailable > 0)
          PrimaryTextButton(
            icon: Icons.add,
            onPressed: () {
              context.pushNamed(AppRoutes.joinTour.name,
                  pathParameters: {'tid': tour.id!}, extra: tour);
            },
            labelText: 'Join Tour',
          ),
        if (tour.owner == userId)
          PrimaryTextButton(
            icon: Icons.settings,
            onPressed: () {
              context.pushNamed(AppRoutes.manageTour.name,
                  pathParameters: {'tid': tour.id!}, extra: tour);
            },
            labelText: 'ManageTour',
          ),
        if (tour.owner == userId)
          PrimaryTextButton(
            icon: Icons.edit,
            onPressed: () {
              context.pushNamed(AppRoutes.editTour.name,
                  pathParameters: {'tid': tour.id!}, extra: tour);
            },
            labelText: 'Edit Tour',
          ),
        if (tour.members.contains(userId) && tour.owner != userId)
          PrimaryTextButton(
            icon: Icons.remove,
            onPressed: () => context.pushNamed(AppRoutes.leaveTour.name,
                pathParameters: {'tid': tour.id!}, extra: tour),
            labelText: 'Leave Tour',
          ),
        if (tour.members.contains(userId))
          DraftButton(
            tourId: tour.id!,
            draftComplete: tour.draftComplete,
            isOwner: tour.owner == userId,
            playerId: userId,
          ),
      ],
    );
  }
}
