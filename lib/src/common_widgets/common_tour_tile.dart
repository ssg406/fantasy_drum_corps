import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class CommonTourTile extends StatelessWidget {
  const CommonTourTile({super.key, required this.tour});

  final Tour tour;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        tour.name,
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              tour.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          if (ResponsiveBreakpoints.of(context).largerThan(TABLET))
            TourDetails(tour: tour),
        ],
      ),
      isThreeLine: true,
      onTap: () => context.goNamed(
        AppRoutes.tourDetail.name,
        pathParameters: {'tid': tour.id!},
      ),
      subtitleTextStyle: Theme.of(context).textTheme.titleMedium,
    );
  }
}

class TourDetails extends StatelessWidget {
  const TourDetails({super.key, required this.tour});

  final Tour tour;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TourDetailChip(
            text: tour.draftComplete ? 'Draft Complete' : 'Draft Pending'),
        TourDetailChip(text: tour.isPublic ? 'Public' : 'Private'),
        TourDetailChip(
            text:
                '${tour.members.length} Member${tour.members.length > 1 ? 's' : ''}'),
      ],
    );
  }
}

class TourDetailChip extends StatelessWidget {
  const TourDetailChip({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Chip(
        elevation: 5,
        side: BorderSide.none,
        labelStyle: Theme.of(context).textTheme.labelLarge,
        label: Text(text),
      ),
    );
  }
}
