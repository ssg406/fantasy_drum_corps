import 'package:fantasy_drum_corps/src/common_widgets/item_label.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/manage_tour/manage_tour_controller.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        const ItemLabel(label: 'Manage Draft'),
        gapH8,
        Text(
          'Start the draft to begin the process of building corps with your tour mates. Go to the draft page to acccess the draft if it is in progress.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        ButtonBar(
          buttonMinWidth: 75,
          children: [
            if (tour.draftComplete)
              Consumer(
                builder: (context, ref, child) {
                  return FilledButton.icon(
                    onPressed: () async {
                      final controller =
                          ref.read(manageTourControllerProvider.notifier);
                      await controller.resetDraft(tour.id!);
                    },
                    style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.error),
                    icon: const Icon(Icons.error_outline_rounded),
                    label: const Tooltip(
                      message:
                          'Erases all Fantasy Corps created for this tour and makes '
                          'the draft available again.',
                      child: Text('RESET DRAFT'),
                    ),
                  );
                },
              ),
            if (!tour.draftComplete)
              FilledButton.icon(
                onPressed: () => context.goNamed(
                  AppRoutes.draftLobby.name,
                  params: {'tid': tourId},
                ),
                icon: const FaIcon(FontAwesomeIcons.circlePlay),
                label: const Tooltip(
                  message: 'Go to the draft page.',
                  child: Text(
                    'Go to Draft',
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
