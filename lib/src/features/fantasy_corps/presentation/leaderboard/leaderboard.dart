import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/page_scaffold.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/data/fantasy_corps_repository.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select your corps to see your tour\'s leaderboard.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
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
                      .map((corps) => DropdownMenuItem<FantasyCorps>(
                          value: corps,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Text(corps.name),
                          )))
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

class TourLeaderboard extends StatelessWidget {
  const TourLeaderboard({Key? key, required this.tourId}) : super(key: key);
  final String tourId;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
