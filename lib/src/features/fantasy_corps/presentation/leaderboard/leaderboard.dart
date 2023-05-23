import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/padded_table_cell.dart';
import 'package:fantasy_drum_corps/src/common_widgets/page_scaffold.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/data/fantasy_corps_repository.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:fantasy_drum_corps/src/utils/app_color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class Leaderboard extends ConsumerWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(watchUserFantasyCorpsProvider),
      data: (List<FantasyCorps> corps) => corps.isEmpty
          ? Center(
              child: Text('No Fantasy Corps Found.',
                  style: Theme.of(context).textTheme.titleLarge),
            )
          : LeaderboardContents(corps: corps),
    );
  }
}

class LeaderboardContents extends StatefulWidget {
  const LeaderboardContents({
    Key? key,
    required this.corps,
  }) : super(key: key);
  final List<FantasyCorps> corps;

  @override
  State<LeaderboardContents> createState() => _LeaderboardContentsState();
}

class _LeaderboardContentsState extends State<LeaderboardContents> {
  FantasyCorps? selectedCorps;

  @override
  Widget build(BuildContext context) {
    return PageScaffolding(
      pageTitle: 'Corps Leaderboard',
      child: Column(
        children: [
          Flex(
            direction:
                ResponsiveBreakpoints.of(context).largerOrEqualTo(DESKTOP)
                    ? Axis.horizontal
                    : Axis.vertical,
            mainAxisAlignment:
                ResponsiveBreakpoints.of(context).largerOrEqualTo(DESKTOP)
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
            crossAxisAlignment:
                ResponsiveBreakpoints.of(context).largerOrEqualTo(DESKTOP)
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
            children: [
              Text(
                'Select your corps to see your tour\'s leaderboard.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              gapH16,
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: DropdownButton<FantasyCorps>(
                  hint: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 15.0),
                    child: Text(
                      'Select a Corps',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  focusColor: Colors.transparent,
                  underline: Container(),
                  dropdownColor: Theme.of(context).colorScheme.inversePrimary,
                  value: selectedCorps,
                  items: widget.corps
                      .map(
                        (corps) => DropdownMenuItem<FantasyCorps>(
                          value: corps,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Text(corps.name),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (FantasyCorps? newValue) =>
                      setState(() => selectedCorps = newValue),
                ),
              ),
            ],
          ),
          gapH24,
          selectedCorps == null
              ? Center(
                  child: Text(
                    'Select a Fantasy Corps',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                )
              : TourLeaderboard(tourId: selectedCorps!.tourId),
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
          tourCorps.sort((a, b) => a.totalScore.compareTo(b.totalScore));
          final standingsMap = tourCorps.asMap();
          return Card(
            elevation: 5.0,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
              child: Column(
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
                      0: FractionColumnWidth(0.1),
                      1: FractionColumnWidth(0.2),
                      2: FlexColumnWidth(),
                      3: FlexColumnWidth(),
                    },
                    children: [
                      _getColumnHeaders(context),
                      for (final key in standingsMap.keys)
                        _getStandingRow(standingsMap[key]!, key + 1)
                    ],
                  )
                ],
              ),
            ),
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
              name,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColors.customGreen,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
          )
      ],
    );
  }

  TableRow _getStandingRow(FantasyCorps fantasyCorps, int rank) {
    return TableRow(
      children: [
        TableCellPadded(
          child: Text(rank.toString()),
        ),
        TableCellPadded(
          child: Text(fantasyCorps.name),
        ),
        TableCellPadded(
          child: Text(fantasyCorps.totalScore.toStringAsFixed(2)),
        )
      ],
    );
  }
}
