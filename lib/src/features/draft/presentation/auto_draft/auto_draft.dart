import 'dart:math';

import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/not_found.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/draft/data/remaining_picks_repository.dart';
import 'package:fantasy_drum_corps/src/features/draft/domain/remaining_picks.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/data/fantasy_corps_repository.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_model.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

import '../../../../common_widgets/lineup_caption_slot.dart';
import '../../../../common_widgets/page_scaffold.dart';
import '../../../fantasy_corps/domain/caption_enum.dart';

class AutoDraft extends ConsumerWidget {
  const AutoDraft({
    Key? key,
    required this.tour,
  }) : super(key: key);

  final Tour tour;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
        showLoading: false,
        value: ref.watch(watchUserFantasyCorpsProvider),
        data: (List<FantasyCorps> userCorps) {
          // Get user Id
          final userId = ref
              .watch(authRepositoryProvider)
              .currentUser
              ?.uid;
          // Check for corps associated with given tour
          final hasCorps = userCorps
              .firstWhereOrNull((element) => element.tourId == tour.id);
          return hasCorps != null
              ? const DraftAlreadyRun()
              : AsyncValueWidget(
            value: ref.watch(fetchTourRemainingPicksProvider(tour.id!)),
            data: (RemainingPicks? remainingPicks) {
              if (remainingPicks == null || userId == null) {
                return const NotFound();
              } else if (remainingPicks.leftOverPicks.isEmpty) {
                return const Text('No picks left');
              } else {
                return AutoDraftContents(
                    remainingPicksList: remainingPicks.leftOverPicks,
                    tourId: tour.id!,
                    userId: userId);
              }
            },
          );
        });
  }
}

class AutoDraftContents extends StatefulWidget {
  const AutoDraftContents({Key? key,
    required this.remainingPicksList,
    required this.tourId,
    required this.userId})
      : super(key: key);
  final List<DrumCorpsCaption> remainingPicksList;
  final String tourId;
  final String userId;

  @override
  State<AutoDraftContents> createState() => _AutoDraftContentsState();
}

class _AutoDraftContentsState extends State<AutoDraftContents> {
  final Lineup lineup = {};
  final Map<Caption, List<DrumCorpsCaption>> leftPicks = {};
  bool lineupCreated = false;

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
            ResponsiveBreakpoints.of(context).largerThan(TABLET) ? 4 : 2,
            childAspectRatio: 2,
            children: [
              for (final caption in lineup.keys)
                LineupCaptionSlot(pick: lineup[caption], caption: caption)
            ],
          ),
          gapH12,
          if (lineupCreated)
            Column(
              children: [
                const CircularProgressIndicator(),
                gapH8,
                Text('Saving Lineup...', style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge),
              ],
            )
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

  void _generateLineup() async {
    // Generate leftPicks Map<Caption, List<DrumCorpsCaption>>
    for (final pick in widget.remainingPicksList) {
      leftPicks[pick.caption]!.add(pick);
    }

    // For every list corresponding to Caption in leftPicks, shuffle the list
    // TODO: consider deleting since index is selected randomly
    for (final key in leftPicks.keys) {
      leftPicks[key]!.shuffle();
    }

    // For each key in the lineup, randomize index variable between 0
    // and length of picks at caption key
    for (final caption in lineup.keys) {
      final index = Random().nextInt(leftPicks[caption]!.length);

      // autoGenLineup[key] = leftPicks[key][index]
      setState(() {
        lineup[caption] = leftPicks[caption]![index].corps;
      });
    }

    setState(() => lineupCreated = true);

    await Future.delayed(const Duration(seconds: 2));

    final fantasyCorps = FantasyCorps(
        tourId: widget.tourId,
        name: 'Unnamed Corps',
        userId: widget.userId,
        lineup: lineup);

    if (mounted) {
      context.goNamed(AppRoutes.createCorps.name,
          params: {'tid': widget.tourId}, extra: fantasyCorps);
    }
  }
}

class DraftAlreadyRun extends StatelessWidget {
  const DraftAlreadyRun({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'It looks like you already have a Fantasy Corps for this tour. '
              'The tour admin can reset all corps for this tour, or click below '
              'to go to your existing Fantasy Corps.',
          style: Theme
              .of(context)
              .textTheme
              .bodyLarge,
        ),
        gapH8,
        FilledButton(
          onPressed: () => context.goNamed(AppRoutes.myCorps.name),
          child: const Text('My Corps'),
        )
      ],
    );
  }
}
