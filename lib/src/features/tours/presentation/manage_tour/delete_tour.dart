import 'package:fantasy_drum_corps/src/common_widgets/item_label.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/manage_tour/manage_tour_controller.dart';
import 'package:fantasy_drum_corps/src/utils/alert_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widgets/common_buttons.dart';
import '../../../../routing/app_routes.dart';

class DeleteTour extends ConsumerWidget {
  const DeleteTour({Key? key, required this.tour}) : super(key: key);
  final Tour tour;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ItemLabel(label: 'Delete Tour'),
        gapH8,
        Text(
          'Deleting a tour is irreversible. Please be sure you want to proceed!',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        gapH16,
        ButtonBar(
          children: [
            PrimaryActionButton(
              icon: Icons.delete_forever_outlined,
              isDestructive: true,
              onPressed: () async {
                final router = GoRouter.of(context);
                final confirmed = await _confirmDelete(context);
                if (confirmed ?? false) {
                  ref
                      .read(manageTourControllerProvider.notifier)
                      .deleteTour(tourId: tour.id!);
                  router.goNamed(AppRoutes.myTours.name);
                }
              },
              labelText: 'DELETE TOUR',
            ),
          ],
        ),
      ],
    );
  }

  Future<bool?> _confirmDelete(BuildContext context) => showAlertDialog(
        context: context,
        title: 'Delete Tour',
        content:
            'Are you sure you want to delete the tour? This option cannot be undone.',
        defaultActionText: 'Delete',
        cancelActionText: 'Cancel',
      );
}
