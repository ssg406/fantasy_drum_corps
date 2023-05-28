import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/padded_table_cell.dart';
import 'package:fantasy_drum_corps/src/common_widgets/page_scaffold.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/data/fantasy_corps_repository.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class Leaderboard extends ConsumerWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(watchJoinedToursProvider),
      data: (List<Tour> tours) => tours.isEmpty
          ? Center(
              child: Text('No Tours Found.',
                  style: Theme.of(context).textTheme.titleLarge),
            )
          : LeaderboardContents(tours: tours),
    );
  }
}

class LeaderboardContents extends StatefulWidget {
  const LeaderboardContents({
    Key? key,
    required this.tours,
  }) : super(key: key);
  final List<Tour> tours;

  @override
  State<LeaderboardContents> createState() => _LeaderboardContentsState();
}

class _LeaderboardContentsState extends State<LeaderboardContents> {
  Tour? selectedTour;

  @override
  Widget build(BuildContext context) {
    final bool largerThanTablet =
        ResponsiveBreakpoints.of(context).largerThan(TABLET);
    return PageScaffolding(
      pageTitle: 'Corps Leaderboard',
      child: Column(
        children: [
          Flex(
            direction: largerThanTablet ? Axis.horizontal : Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: largerThanTablet
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              Text(
                'Select your tour to see the leaderboard.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              if (!largerThanTablet) gapH24,
              SizedBox(
                width: 300,
                child: DropdownButtonFormField<Tour>(
                  hint: const Text('Select a tour'),
                  value: selectedTour,
                  items: widget.tours
                      .where((tour) => tour.draftComplete)
                      .map((tour) => DropdownMenuItem<Tour>(
                            value: tour,
                            child: Text(tour.name),
                          ))
                      .toList(),
                  onChanged: (tour) => setState(() => selectedTour = tour),
                ),
              )
            ],
          ),
          gapH24,
          selectedTour == null
              ? Center(
                  child: Text(
                    'Select a Tour',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                )
              : TourLeaderboard(tourId: selectedTour!.id!),
        ],
      ),
    );
  }
}

class TourLeaderboard extends ConsumerWidget {
  const TourLeaderboard({Key? key, required this.tourId}) : super(key: key);
  final String tourId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(watchTourFantasyCorpsProvider(tourId)),
      data: (List<FantasyCorps> tourCorps) {
        if (tourCorps.isEmpty) {
          return const Text('No Fantasy Corps Found');
        } else {
          tourCorps.sort((a, b) => b.totalScore.compareTo(a.totalScore));
          final standingsMap = tourCorps.asMap();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'RANKINGS',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              gapH16,
              Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(3),
                  2: FlexColumnWidth(2),
                },
                children: [
                  _getColumnHeaders(context),
                  for (final key in standingsMap.keys)
                    _getStandingRow(standingsMap[key]!, key + 1, context)
                ],
              )
            ],
          );
        }
      },
    );
  }

  TableRow _getColumnHeaders(BuildContext context) {
    final colNames = ['Rank', 'Fantasy Corps', 'Score'];

    return TableRow(
      children: [
        for (final name in colNames)
          TableCellPadded(
            child: Text(
              name.toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          )
      ],
    );
  }

  TableRow _getStandingRow(
      FantasyCorps fantasyCorps, int rank, BuildContext context) {
    return TableRow(
      children: [
        TableCellPadded(
          child: Text(
            rank.toString(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        TableCellPadded(
          child: Text(
            fantasyCorps.name,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        TableCellPadded(
          child: Text(
            fantasyCorps.totalScore.toStringAsFixed(2),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        )
      ],
    );
  }
}
