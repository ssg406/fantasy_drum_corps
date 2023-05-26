import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/not_found.dart';
import 'package:fantasy_drum_corps/src/features/draft/data/remaining_picks_repository.dart';
import 'package:fantasy_drum_corps/src/features/draft/domain/remaining_picks.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_model.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AutoDraft extends ConsumerWidget {
  const AutoDraft({
    Key? key,
    required this.tour,
  }) : super(key: key);

  final Tour tour;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(fetchTourRemainingPicksProvider(tour.id!)),
      data: (RemainingPicks? remainingPicks) {
        if (remainingPicks == null) {
          return const NotFound();
        } else if (remainingPicks.leftOverPicks.isEmpty) {
          return const Text('No picks left');
        } else {
          return AutoDraftContents(
              remainingPicksList: remainingPicks.leftOverPicks);
        }
      },
    );
  }
}

class AutoDraftContents extends StatelessWidget {
  const AutoDraftContents({Key? key, required this.remainingPicksList})
      : super(key: key);
  final List<DrumCorpsCaption> remainingPicksList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final pick in remainingPicksList)
          Text(
              'Corps: ${pick.corps.fullName}   Caption: ${pick.caption.fullName}')
      ],
    );
  }
}
