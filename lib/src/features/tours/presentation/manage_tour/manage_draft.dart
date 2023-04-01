import 'package:fantasy_drum_corps/src/common_widgets/item_label.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:flutter/material.dart';
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
          alignment: MainAxisAlignment.start,
          buttonMinWidth: 75,
          children: [
            TextButton.icon(
              onPressed: () => debugPrint('start draft'),
              icon: const FaIcon(FontAwesomeIcons.shieldHalved),
              label: const Tooltip(
                message:
                    'Notify tour members of the draft and begin countdown.',
                child: Text(
                  'START DRAFT',
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () => context.goNamed(
                AppRoutes.draft.name,
                params: {'tid': tourId},
              ),
              icon: const FaIcon(FontAwesomeIcons.circlePlay),
              label: const Tooltip(
                message: 'Go to the draft page.',
                child: Text(
                  'GO TO DRAFT PAGE',
                ),
              ),
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
