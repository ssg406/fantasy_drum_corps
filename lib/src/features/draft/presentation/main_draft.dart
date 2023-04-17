import 'dart:developer' as dev;

import 'package:fantasy_drum_corps/src/common_widgets/accent_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/label_checkbox.dart';
import 'package:fantasy_drum_corps/src/common_widgets/not_found.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/common_widgets/titled_section_card.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/draft/domain/socket_events.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class TourDraft extends ConsumerWidget {
  const TourDraft({
    super.key,
    this.tourId,
  });

  final String? tourId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(authRepositoryProvider).currentUser?.uid;
    if (userId == null) {
      return const NotFound();
    }
    if (tourId == null) {
      return const NotFound();
    }
    return TourDraftContents(tourId: tourId!, userId: userId);
  }
}

class TourDraftContents extends ConsumerStatefulWidget {
  const TourDraftContents({
    Key? key,
    required this.tourId,
    required this.userId,
  }) : super(key: key);

  final String tourId;
  final String userId;

  @override
  ConsumerState createState() => _TourDraftContentsState();
}

class _TourDraftContentsState extends ConsumerState<TourDraftContents> {
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
    super.initState();
    final tourId = widget.tourId;
    final userId = widget.userId;
    // Handle tourId == null

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

    io.Socket socket = io.io('http://localhost:3000');
    socket.onConnect((_) {
      dev.log('Socket is connected', name: 'Socket.io');
      dev.log('emitting userId of $userId and tourId of $tourId',
          name: 'Socket.io');
      socket.emit(SocketEvent.onIdentifyClient.name, {
        'uid': userId,
        'tourId': tourId,
      });
    });

    socket.onError((data) {
      dev.log('there was a socket error $data', name: 'Socket.io');
    });
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
            for (final caption in Caption.values)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    caption.name,
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
        child: Column(
          children: [
            Text('Remaining Picks',
                style: Theme.of(context).textTheme.titleMedium),
            gapH8,
            SizedBox(
              height: 350,
              child: ListView(
                children: [
                  for (final corps in DrumCorps.values)
                    for (final caption in Caption.values)
                      InkWell(
                        onTap: () => debugPrint(
                            'selected ${corps.name} ${caption.name}'),
                        child: Text('${corps.name} ${caption.name}'),
                      )
                ],
              ),
            ),
            gapH8,
            Align(
                alignment: Alignment.bottomRight,
                child: AccentButton(
                  label: 'Draft',
                  onPressed: () => debugPrint('drafted'),
                ))
          ],
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
              items: DrumCorps.values.map<DropdownMenuItem<String>>(
                (DrumCorps corps) {
                  return DropdownMenuItem<String>(
                    value: corps.name,
                    child: Text(corps.name),
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
            Text(
              'Filter Remaining Captions by Type',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Wrap(
              spacing: 5.0,
              direction: Axis.horizontal,
              children: [
                for (final caption in Caption.values)
                  LabelCheckbox(
                    caption.abbreviation,
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
