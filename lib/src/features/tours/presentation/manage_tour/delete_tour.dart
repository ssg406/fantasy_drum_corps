import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/manage_tour/manage_tour_controller.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:fantasy_drum_corps/src/utils/alert_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DeleteTour extends ConsumerWidget {
  const DeleteTour({Key? key, required this.tour}) : super(key: key);
  final Tour tour;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delete Tour',
          style: Theme
              .of(context)
              .textTheme
              .titleMedium,
        ),
        gapH8,
        Text(
          'Deleting a tour is irreversible. Please be sure you want to proceed!',
          style: Theme
              .of(context)
              .textTheme
              .bodyLarge,
        ),
        gapH16,
        ElevatedButton(
          onPressed: () {
            _confirmDelete(context).then((confirmed) {
              if (confirmed ?? false) {
                ref
                    .read(manageTourControllerProvider.notifier)
                    .deleteTour(tourId: tour.id!);
                context.goNamed(AppRoutes.myTours.name);
              }
            });
          },
          style: ElevatedButton.styleFrom(
              backgroundColor:
              Theme
                  .of(context)
                  .colorScheme
                  .errorContainer),
          child: Text(
            'DELETE TOUR',
            style: Theme
                .of(context)
                .textTheme
                .bodyLarge!
                .copyWith(
                color: Theme
                    .of(context)
                    .colorScheme
                    .onErrorContainer),
          ),
        ),
      ],
    );
  }

  Future<bool?> _confirmDelete(BuildContext context) async {
    final result = await showAlertDialog(
      context: context,
      title: 'Delete Tour',
      content: 'Are you sure you want to delete the tour? This option cannot be undone.',
      defaultActionText: 'Delete',
      cancelActionText: 'Cancel',
    );
    return result;
  }
}