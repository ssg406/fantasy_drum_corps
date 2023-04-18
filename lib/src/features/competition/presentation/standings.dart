import 'package:fantasy_drum_corps/src/common_widgets/padded_table_cell.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Standings extends ConsumerStatefulWidget {
  const Standings({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _StandingsState();
}

class _StandingsState extends ConsumerState<Standings> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ResponsiveCenter(
        maxContentWidth: 1200,
        child: Padding(
          padding: pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Peek at the Playoff Standing',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              gapH8,
              Text(
                'Earn your way to the top seed for Fantasy Finals Week! Tiebreaker is season points',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              gapH32,
              Card(
                child: Padding(
                  padding: cardPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Standings',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      gapH16,
                      Table(
                        columnWidths: <int, TableColumnWidth>{
                          0: const FlexColumnWidth(),
                          1: ResponsiveBreakpoints.of(context)
                                  .largerThan(TABLET)
                              ? const FractionColumnWidth(0.5)
                              : const FlexColumnWidth(2),
                          2: FlexColumnWidth(ResponsiveBreakpoints.of(context)
                                  .smallerThan(TABLET)
                              ? 2
                              : 1),
                          3: FlexColumnWidth(ResponsiveBreakpoints.of(context)
                                  .smallerThan(TABLET)
                              ? 2
                              : 1),
                        },
                        children: [
                          _getColumnHeaders(),
                          _getStandingRow(),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TableRow _getColumnHeaders() {
    final colNames = ['Rank', 'Corps', 'Season Pts', 'Record'];
    return TableRow(
      children: [
        for (final name in colNames)
          TableCellPadded(
            child: Text(
              name,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.green),
            ),
          ),
      ],
    );
  }

  TableRow _getStandingRow() {
    return const TableRow(children: [
      TableCellPadded(
        child: Text('1'),
      ),
      TableCellPadded(
        child: Text('Tempe Cadets'),
      ),
      TableCellPadded(
        child: Text('886.4'),
      ),
      TableCellPadded(
        child: Text('5 - 3'),
      ),
    ]);
  }
}
