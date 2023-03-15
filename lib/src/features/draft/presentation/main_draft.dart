import 'package:fantasy_drum_corps/src/common_widgets/label_checkbox.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/common_widgets/titled_section_card.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/utils/static_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// [TourDraft] is responsible for coordinating the live draft event.
/// The containing class is the only class which communicates with the Socket.io
/// server. State of child widgets is updated from here.
class TourDraft extends ConsumerStatefulWidget {
  const TourDraft({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _TourDraftState();
}

class _TourDraftState extends ConsumerState<TourDraft> {
  // Receive from server
  // List<Caption> availableCaptions;
  // String currentTurn;
  // String nextTurn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: pagePadding,
      child: SingleChildScrollView(
        child: ResponsiveCenter(
          maxContentWidth: 1000,
          child: Column(
            children: [
              IntrinsicHeight(
                child: Flex(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  direction: MediaQuery.of(context).size.width < 800
                      ? Axis.vertical
                      : Axis.horizontal,
                  children: const [
                    Flexible(
                      fit: FlexFit.tight,
                      child: TimerCard(),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: RoundCard(),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 2,
                      child: CurrentPickCard(),
                    ),
                  ],
                ),
              ),
              IntrinsicHeight(
                child: Flex(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  direction: MediaQuery.of(context).size.width < 800
                      ? Axis.vertical
                      : Axis.horizontal,
                  children: const [
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: CaptionFilterCard(),
                    ),
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: AvailableCaptions(),
                    ),
                  ],
                ),
              ),
              IntrinsicHeight(
                child: Flex(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  direction: MediaQuery.of(context).size.width < 1000
                      ? Axis.vertical
                      : Axis.horizontal,
                  children: const [
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: PlayerLineup(),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: SelectFantasyCorpsCard(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // Setup socket
    // onStateUpdate
    //      call _updateDraftState with list update, current turn, next turn
    // onTurnStart
    //      call _startTurn with name of current picker
    // onTurnEnd
    //      call _turnEnd
    // onDraftOver
    //      Write lineup to repository
    // repeat
  }

  void _updateDraftState() {
    // Reset list contents
    // Set current pick, set next pick
    // Reset timer
  }

  void _startTurn() {
    /// If (my turn)
    ///   enable picking
    ///   start timer
  }

  void _endTurn() {
    /// if (itWasMyTurn)
    ///   submit pick to server
    ///   stop timer
    ///   update lineup in repository
  }
}

/// Displays the lineup the player is building during the draft
class PlayerLineup extends StatelessWidget {
  const PlayerLineup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledSectionCard(
      title: 'Fantasy Corps Lineup',
      child: SizedBox(
        height: 350,
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 2,
          children: [
            for (final caption in DrumCorpsData.captionFullNames)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    caption,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text('Position 1',
                      style: Theme.of(context).textTheme.bodyLarge),
                  Text(
                    'Position 2',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

/// Shows remaining picks a player can choose on their turn, contains ListView
class AvailableCaptions extends StatelessWidget {
  const AvailableCaptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: cardPadding,
        child: SizedBox(
          height: 350,
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 3.0,
            children: [
              for (final corps in DrumCorpsData.allNames)
                for (final caption in DrumCorpsData.captionFullNames)
                  InkWell(
                    onTap: () => debugPrint('selected caption'),
                    child: ListTile(
                      title: Text(corps),
                      subtitle: Text(caption),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Changes view of selections between different Fantasy Corps in the tour
class SelectFantasyCorpsCard extends StatelessWidget {
  const SelectFantasyCorpsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'View another player\'s selections',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            gapH16,
            DropdownButtonFormField<String>(
              validator: (String? selection) {
                return selection == null ? 'Please make a selection' : null;
              },
              decoration: const InputDecoration(labelText: 'Sponsored Corps'),
              items: DrumCorpsData.allNames.map<DropdownMenuItem<String>>(
                (String corps) {
                  return DropdownMenuItem<String>(
                    value: corps,
                    child: Text(corps),
                  );
                },
              ).toList(),
              onChanged: (String? newValue) => print(newValue),
            ),
          ],
        ),
      ),
    );
  }
}

class TimerCard extends StatelessWidget {
  const TimerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: cardPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Draft Timer',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              ':00',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: Colors.green[600], fontSize: 80.0),
            ),
          ],
        ),
      ),
    );
  }
}

class RoundCard extends StatelessWidget {
  const RoundCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: cardPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Round',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '01',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: Colors.blue[300], fontSize: 80.0),
            ),
          ],
        ),
      ),
    );
  }
}

class CurrentPickCard extends StatelessWidget {
  const CurrentPickCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Picking...',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '@samwise122',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.green[400],
                  ),
            ),
            gapH32,
            Text(
              'Up Next...',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '@bjones86',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.amber,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class CaptionFilterCard extends StatelessWidget {
  const CaptionFilterCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: cardPadding,
        child: Column(
          children: [
            const Text('Best Available Captions Left'),
            Wrap(
              spacing: 5.0,
              direction: Axis.horizontal,
              children: [
                for (final caption in DrumCorpsData.captionAbbreviations)
                  LabelCheckbox(
                    caption,
                    onChecked: (checked) => debugPrint(checked.toString()),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
