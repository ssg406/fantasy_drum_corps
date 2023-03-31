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
    return Row(
      children: [
        const ItemLabel(label: 'Manage Draft'),
        gapW32,
        Row(
          children: [
            Tooltip(
              message: 'Notify tour members of the draft and begin countdown.',
              child: TextButton.icon(
                onPressed: () => debugPrint('start draft'),
                icon: const FaIcon(FontAwesomeIcons.shieldHalved),
                label: const Text('START DRAFT'),
              ),
            ),
            gapW24,
            Tooltip(
              child: TextButton.icon(
                onPressed: () => context.goNamed(
                  AppRoutes.draft.name,
                  params: {'tid': tourId},
                ),
                icon: const FaIcon(FontAwesomeIcons.circlePlay),
                label: const Text('GO TO DRAFT PAGE'),
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
