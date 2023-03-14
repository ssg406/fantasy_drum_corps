import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/utils/static_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeeklyScores extends ConsumerStatefulWidget {
  const WeeklyScores({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _WeeklyScoresState();
}

class _WeeklyScoresState extends ConsumerState<WeeklyScores> {
  String? selectedWeek;
  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      maxContentWidth: 1000,
      child: Padding(
        padding: pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Let\'ts check out the scores!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Flexible(
                  child: DropdownButtonFormField<String>(
                    value: selectedWeek,
                    validator: (String? selection) {
                      return selection == null
                          ? 'Please make a selection'
                          : null;
                    },
                    decoration: const InputDecoration(labelText: 'Week #'),
                    items: DrumCorpsData.allNames.map<DropdownMenuItem<String>>(
                      (String corps) {
                        return DropdownMenuItem<String>(
                          value: corps,
                          child: Text(corps),
                        );
                      },
                    ).toList(),
                    onChanged: (String? newValue) {
                      setState(() => selectedWeek = newValue);
                    },
                  ),
                ),
              ],
            ),
            gapH32,
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Flexible(
                  fit: FlexFit.tight,
                  child: MatchCard(
                      matchNumber: 1,
                      corps1: 'Silverado Cadets',
                      corps2: 'Ghost of Faust',
                      corps1Score: 183.5,
                      corps2Score: 178.9),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: MatchCard(
                      matchNumber: 2,
                      corps1: 'Ghost of Faust',
                      corps2: 'Yowza Yowza',
                      corps1Score: 180.5,
                      corps2Score: 180.9),
                ),
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Flexible(
                  fit: FlexFit.tight,
                  child: MatchCard(
                      matchNumber: 3,
                      corps1: 'Silverado Cadets',
                      corps2: 'Ghost of Faust',
                      corps1Score: 184.5,
                      corps2Score: 180.9),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: MatchCard(
                      matchNumber: 4,
                      corps1: 'Silverado Cadets',
                      corps2: 'The Red Coats are Coming!',
                      corps1Score: 181.5,
                      corps2Score: 185.9),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MatchCard extends StatelessWidget {
  const MatchCard(
      {Key? key,
      required this.matchNumber,
      required this.corps1,
      required this.corps2,
      required this.corps1Score,
      required this.corps2Score})
      : super(key: key);
  final int matchNumber;
  final String corps1;
  final String corps2;
  final double corps1Score;
  final double corps2Score;

  @override
  Widget build(BuildContext context) {
    final winningCorps = corps1Score > corps2Score ? corps1 : corps2;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Matchup $matchNumber',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            gapH16,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  corps1,
                  style: textTheme.bodyLarge!.copyWith(
                      color: winningCorps == corps1 ? Colors.green : null),
                ),
                Text(
                  corps1Score.toString(),
                  style: textTheme.bodyLarge!.copyWith(
                      color: winningCorps == corps1 ? Colors.green : null),
                ),
              ],
            ),
            gapH8,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  corps2,
                  style: textTheme.bodyLarge!.copyWith(
                      color: winningCorps == corps2 ? Colors.green : null),
                ),
                Text(
                  corps2Score.toString(),
                  style: textTheme.bodyLarge!.copyWith(
                      color: winningCorps == corps2 ? Colors.green : null),
                ),
              ],
            ),
            gapH16,
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton.icon(
                icon: const Icon(Icons.read_more_outlined),
                label: const Text('View Subcaptions'),
                onPressed: () => debugPrint('view subcaptions'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
