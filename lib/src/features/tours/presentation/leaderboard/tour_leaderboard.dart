import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/async_value_widget.dart';
import '../../../../common_widgets/padded_table_cell.dart';
import '../../../../constants/app_sizes.dart';
import '../../../fantasy_corps/data/fantasy_corps_repository.dart';
import '../../../fantasy_corps/domain/fantasy_corps.dart';

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
