import 'dart:math';

import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/not_found.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/draft/data/remaining_picks_repository.dart';
import 'package:fantasy_drum_corps/src/features/draft/domain/remaining_picks.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_model.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

import '../../../common_widgets/lineup_caption_slot.dart';
import '../../../common_widgets/page_scaffold.dart';
import '../../fantasy_corps/domain/caption_enum.dart';

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

class AutoDraftContents extends StatefulWidget {
  const AutoDraftContents({Key? key, required this.remainingPicksList})
      : super(key: key);
  final List<DrumCorpsCaption> remainingPicksList;

  @override
  State<AutoDraftContents> createState() => _AutoDraftContentsState();
}

class _AutoDraftContentsState extends State<AutoDraftContents> {
  final Lineup lineup = {};
  final Map<Caption, List<DrumCorpsCaption>> leftPicks = {};

  @override
  Widget build(BuildContext context) {
    return PageScaffolding(
      pageTitle: 'Generate Lineup',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'It looks like you missed the draft for your tour. You can still '
                'generate a random lineup from the picks left over from the '
                'main draft, and your Fantasy Corps will immediately '
                'populate with the current scores from this season. Click the '
                'button below to create a lineup. Once the lineup has been '
                'created, it is permanent.',
            style: Theme
                .of(context)
                .textTheme
                .bodyLarge,
          ),
          gapH16,
          Text(
            'There were ${widget.remainingPicksList
                .length} picks remaining after the draft.',
            style: Theme
                .of(context)
                .textTheme
                .titleMedium,
          ),
          gapH16,
          FilledButton.icon(
            icon: const Icon(Icons.play_circle_outline_rounded),
            onPressed: _generateLineup,
            label: const Text('Generate Lineup'),
          ),
          GridView.count(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            crossAxisCount:
            ResponsiveBreakpoints.of(context).largerThan(TABLET)
                ? 4
                : 2,
            childAspectRatio: 2,
            children: [
              for (final caption in lineup.keys)
                LineupCaptionSlot(
                    pick: lineup[caption], caption: caption)
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Write keys to lineup and leftPicks map
    for (final caption in Caption.values) {
      lineup.addAll({caption: null});
      leftPicks.addAll({caption: List.empty(growable: true)});
    }
  }

  void _generateLineup() {
    // Generate leftPicks Map<Caption, List<DrumCorpsCaption>>
    for (final pick in widget.remainingPicksList) {
      leftPicks[pick.caption]!.add(pick);
    }

    // For every list corresponding to Caption in leftPicks, shuffle the list
    for (final key in leftPicks.keys) {
      leftPicks[key]!.shuffle();
    }

    // For each key in the lineup, randomize index variable between 0 and leftPicks[key].length
    for (final caption in lineup.keys) {
      final index = Random().nextInt(leftPicks[caption]!.length);

      // autoGenLineup[key] = leftPicks[key][index]
      setState(() {
        lineup[caption] = leftPicks[caption]![index].corps;
      });
    }
  }
}
