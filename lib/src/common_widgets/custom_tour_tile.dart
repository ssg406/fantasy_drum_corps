import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomTourTile extends StatelessWidget {
  const CustomTourTile({Key? key, required this.tour}) : super(key: key);
  final Tour tour;

  String get tourName => tour.name;

  String get tourDescription => tour.description;

  bool get isPublic => tour.isPublic;

  int get openSlots => tour.slotsAvailable;

  String _getSlotsText() {
    if (openSlots == 0) {
      return 'Tour Full';
    }
    return '$openSlots ${openSlots == 1 ? 'slot' : 'slots'}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.inversePrimary,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tourName,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          gapH8,
          Text(
            tourDescription,
            style: Theme.of(context).textTheme.bodyMedium,
            softWrap: true,
          ),
          gapH8,
          Row(
            children: [
              Icon(
                isPublic ? Icons.lock_open_rounded : Icons.lock,
                color: isPublic ? Colors.green : Colors.red,
              ),
              gapW8,
              Text(
                isPublic ? 'Public' : 'Private',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: isPublic ? Colors.green : Colors.red),
              ),
              gapW16,
              const Icon(
                Icons.person,
                color: Colors.blue,
              ),
              gapW8,
              Text(
                _getSlotsText(),
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.blue),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () => context.pushNamed(AppRoutes.tourDetail.name,
                    params: {'tid': tour.id!}),
                icon: const Icon(Icons.arrow_circle_right_outlined),
                label: Text(
                  'View',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
          gapH16,
        ],
      ),
    );
  }
}
