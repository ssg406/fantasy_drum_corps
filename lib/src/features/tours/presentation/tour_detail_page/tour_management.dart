import 'package:fantasy_drum_corps/src/features/tours/presentation/tour_detail_page/tour_detail_controller.dart';
import 'package:fantasy_drum_corps/src/utils/alert_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widgets/common_buttons.dart';
import '../../../../routing/app_routes.dart';
import '../../domain/tour_model.dart';

class TourManagement extends ConsumerWidget {
  const TourManagement({super.key, required this.tour});

  final Tour tour;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tourDetailControllerProvider);
    return OverflowBar(
      children: [
        PrimaryTextButton(
          icon: Icons.edit,
          onPressed: () {
            context.pushNamed(AppRoutes.editTour.name,
                pathParameters: {'tid': tour.id!}, extra: tour);
          },
          labelText: 'Edit',
        ),
        if (tour.draftComplete)
          PrimaryTextButton(
            isDestructive: true,
            isLoading: state.isLoading,
            onPressed: () async {
              final confirmed = await _confirmReset(context);
              if (confirmed ?? false) {
                ref
                    .read(tourDetailControllerProvider.notifier)
                    .resetDraft(tour.id!);
              }
            },
            icon: Icons.error_outline_outlined,
            labelText: 'Reset Draft',
          ),
        PrimaryTextButton(
          isDestructive: true,
          onPressed: () async {
            final router = GoRouter.of(context);
            final confirmed = await _confirmDelete(context);
            if (confirmed ?? false) {
              ref
                  .read(tourDetailControllerProvider.notifier)
                  .deleteTour(tourId: tour.id!);
              router.goNamed(AppRoutes.dashboard.name);
            }
          },
          icon: Icons.delete_forever_outlined,
          labelText: 'Delete Tour',
        )
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

  Future<bool?> _confirmReset(BuildContext context) => showAlertDialog(
        context: context,
        title: 'Reset Draft',
        content:
            'Are you sure you want to reset the draft? All Fantasy Corps in the tour will be erased.',
        defaultActionText: 'Reset',
        cancelActionText: 'Cancel',
      );
}
