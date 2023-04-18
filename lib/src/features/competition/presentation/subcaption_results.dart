import 'package:fantasy_drum_corps/src/common_widgets/padded_table_cell.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SubcaptionResults extends ConsumerStatefulWidget {
  const SubcaptionResults({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SubcaptionResultsState();
}

class _SubcaptionResultsState extends ConsumerState<SubcaptionResults> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ResponsiveCenter(
        maxContentWidth: 1200,
        child: Padding(
          padding: pagePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Compare the scores!',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              gapH8,
              Text(
                'Let\'s see how your corps compared to your competitor.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              gapH32,
              Card(
                child: Padding(
                  padding: cardPadding,
                  child: Table(
                    columnWidths: <int, TableColumnWidth>{
                      // Corps 1 caption
                      0: FractionColumnWidth(0.25),
                      // Corps 1 Score
                      1: FlexColumnWidth(),
                      // Center Label
                      2: ResponsiveBreakpoints.of(context).largerThan(TABLET)
                          ? FlexColumnWidth()
                          : FixedColumnWidth(0),
                      // Corps 2 Score
                      3: FlexColumnWidth(),
                      // Corps 2 caption
                      4: FractionColumnWidth(0.25),
                    },
                    children: [
                      _getColumnHeaders(
                          corps1Name: 'Corps 1',
                          corps1Score: 100.11,
                          corps2Name: 'Corps 2',
                          corps2Score: 99.88),
                      ..._getRowSet(),
                      ..._getRowSet(),
                      ..._getRowSet(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _getColumnHeaders(
      {required String corps1Name,
      required double corps1Score,
      required String corps2Name,
      required double corps2Score}) {
    return TableRow(children: [
      TableCellPadded(
        child: Text(
          corps1Name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      TableCellPadded(
        child: Text(
          corps1Score.toString(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      Container(),
      TableCellPadded(
        child: Text(
          corps2Score.toString(),
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      ),
      TableCellPadded(
        child: Text(
          corps2Name,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.right,
        ),
      ),
    ]);
  }

  List<TableRow> _getRowSet() {
    return [
      TableRow(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Theme.of(context).colorScheme.inversePrimary))),
        children: [
          Container(),
          Container(),
          Container(
            color: Colors.blue,
            child: ResponsiveVisibility(
              visible: ResponsiveBreakpoints.of(context).largerThan(TABLET),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'General Effect',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Container(),
          Container(),
        ],
      ),
      TableRow(
        children: [
          TableCellPadded(
            child: Text('[GE1 - 1 Corps'),
          ),
          TableCellPadded(
            child: Text(
              '[##.##]',
              textAlign: TextAlign.center,
            ),
          ),
          TableCellPadded(
            padding: EdgeInsets.zero,
            verticalAlignment: TableCellVerticalAlignment.fill,
            child: Container(
              color: Colors.blue,
              child: Text(
                'GE 1',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          TableCellPadded(
            child: Text(
              '[##.##]',
              textAlign: TextAlign.center,
            ),
          ),
          TableCellPadded(
            child: Text(
              '[GE1 - 1 Corps]',
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
      TableRow(children: [
        TableCellPadded(
          child: Text('[GE1 - 2 Corps]'),
        ),
        TableCellPadded(
          child: Text(
            '[##.##]',
            textAlign: TextAlign.center,
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.fill,
          child: Container(
            color: Colors.blue,
          ),
        ),
        TableCellPadded(
          child: Text(
            '[##.##]',
            textAlign: TextAlign.center,
          ),
        ),
        TableCellPadded(
          child: Text(
            '[GE1 - 2 Corps]',
            textAlign: TextAlign.right,
          ),
        ),
      ])
    ];
  }
}
