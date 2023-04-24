import 'dart:async';

import 'package:fantasy_drum_corps/src/common_widgets/accent_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/label_checkbox.dart';
import 'package:fantasy_drum_corps/src/common_widgets/not_found.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/draft/data/all_draft_picks.dart';
import 'package:fantasy_drum_corps/src/features/draft/domain/socket_events.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_model.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:fantasy_drum_corps/src/utils/alert_dialogs.dart';
import 'package:fantasy_drum_corps/src/utils/app_color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

const turnLength = 45;

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
  late io.Socket socket;
  List<DrumCorpsCaption>? availablePicks;
  int remainingTime = turnLength;
  int roundNumber = 0;
  String? currentPick;
  String? nextPick;
  Timer? turnTimer;
  bool canPick = false;

  final Lineup fantasyCorps = {};
  List<Caption> captionFilters = List.empty(growable: true);

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
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: TimerCard(remainingTime: remainingTime),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: RoundCard(roundNumber: roundNumber),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 2,
                      child: CurrentPickCard(
                        currentPick: currentPick,
                        nextPick: nextPick,
                      ),
                    ),
                  ],
                ),
              ),
              IntrinsicHeight(
                child: Flex(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  direction:
                      ResponsiveBreakpoints.of(context).smallerThan(TABLET)
                          ? Axis.vertical
                          : Axis.horizontal,
                  children: [
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: CaptionFilterCard(
                        onFilterSelected: _onFilterChanged,
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: AvailableCaptions(
                        canPick: canPick,
                        availableCaptions: availablePicks,
                        onCaptionSelected: _onCaptionSelected,
                      ),
                    ),
                  ],
                ),
              ),
              PlayerLineup(
                lineup: fantasyCorps,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onFilterChanged(checked, caption) {
    if (checked) {
      setState(() => captionFilters.add(caption));
    } else {
      setState(() => captionFilters.remove(caption));
    }
  }

  void _onCaptionSelected(DrumCorpsCaption drumCorpsCaption) {
    var existingPicks = fantasyCorps[drumCorpsCaption.caption];
    final takenSlots = existingPicks?.length ?? 0;

    if (takenSlots > 1) {
      showAlertDialog(
          context: context,
          title: 'No ${drumCorpsCaption.caption.name} slots available');
      return;
    }
    // Cancel timer if set
    turnTimer?.cancel();

    socket.emit(
        'clientSendsPick', {'pickId': drumCorpsCaption.drumCorpsCaptionId});
    setState(() {
      remainingTime = 0;
      if (existingPicks != null) {
        existingPicks.add(drumCorpsCaption.corps);
        fantasyCorps.addAll({drumCorpsCaption.caption: existingPicks});
      } else {
        fantasyCorps.addAll({
          drumCorpsCaption.caption: [drumCorpsCaption.corps]
        });
      }
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final tourId = widget.tourId;
    final userId = widget.userId;

    // Set empty lineup
    for (final caption in Caption.values) {
      fantasyCorps.addAll({caption: List.empty(growable: true)});
    }
    socket = io.io('http://localhost:3000');
    if (socket.connected) {
      socket.disconnect();
    }
    socket.onConnect((_) {
      // Emit identification
      socket.emit(SocketEvents.clientSendsIdentification.name,
          {'tourId': tourId, 'uid': userId});

      socket.on('foundTour', (data) => debugPrint(data.toString()));

      socket.on('serverSendsStartingPicks', (data) {
        final picks = data['startingPicks'] as List<dynamic>;
        // Set empty lineup
        for (final caption in Caption.values) {
          fantasyCorps.addAll({caption: List.empty(growable: true)});
        }
        final filteredPicks = startingDraftPicks
            .where((element) => picks.contains(element.drumCorpsCaptionId))
            .toList();
        setState(() {
          availablePicks = filteredPicks;
        });
      });

      socket.on('draftStateUpdated', (data) {
        final roundNumber = data['roundNumber'] as int;
        final picks = data['availablePicks'] as List<dynamic>;
        _updateDraftState(roundNumber, picks);
      });

      socket.on('draftTurnStart', (data) {
        debugPrint('turn is starting');
        setState(() {
          remainingTime = turnLength;
          currentPick = data['currentTurn'] as String?;
          nextPick = data['nextTurn'] as String?;
          canPick = currentPick == userId;
        });
        turnTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (remainingTime == 0) {
            socket.emit('clientTurnTimeOut');
            debugPrint('Clients turn timed out');
            // Make a random pick
            timer.cancel();
          } else {
            setState(() {
              remainingTime--;
            });
          }
        });
      });
      socket.on('draftOver', (_) {
        debugPrint('draft is over');
        turnTimer?.cancel();
        showAlertDialog(context: context, title: 'Draft Complete');
        // write corps lineup to firebase
      });
    });
  }

  void _updateDraftState(int currentRound, List<dynamic> pickIds) {
    final filteredPicks = startingDraftPicks
        .where((element) => pickIds.contains(element.drumCorpsCaptionId))
        .toList();
    setState(() {
      roundNumber = currentRound;
      availablePicks = filteredPicks;
    });
  }

  void _startTurn() {}

  void _endTurn() {}
}

/// Displays the lineup the player is building during the draft
class PlayerLineup extends StatelessWidget {
  const PlayerLineup({super.key, required this.lineup});

  final Lineup lineup;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: cardPadding,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FaIcon(
                  FontAwesomeIcons.shieldHalved,
                  color: AppColors.customGreen,
                ),
                gapW8,
                Text(
                  'Your Lineup',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            gapH24,
            SizedBox(
              height: 350,
              child: GridView.count(
                padding: const EdgeInsets.all(0),
                crossAxisCount:
                    ResponsiveBreakpoints.of(context).largerThan(TABLET)
                        ? 3
                        : 2,
                childAspectRatio: 2,
                children: [
                  for (final caption in lineup.keys)
                    LineupCaptionSlot(picks: lineup[caption]!, caption: caption)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LineupCaptionSlot extends StatelessWidget {
  const LineupCaptionSlot(
      {super.key, required this.picks, required this.caption});

  final Caption caption;
  final List<DrumCorps> picks;

  @override
  Widget build(BuildContext context) {
    final slotsAvailable = 2 - picks.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          caption.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        for (final pick in picks)
          Text(
            pick.fullName,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        Text(
          '$slotsAvailable slots available',
          style: Theme.of(context).textTheme.bodyLarge,
        )
      ],
    );
  }
}

/// Shows remaining picks a player can choose on their turn, contains ListView
class AvailableCaptions extends StatefulWidget {
  const AvailableCaptions(
      {super.key,
      this.availableCaptions,
      required this.onCaptionSelected,
      required this.canPick});

  final List<DrumCorpsCaption>? availableCaptions;
  final void Function(DrumCorpsCaption) onCaptionSelected;
  final bool canPick;

  @override
  State<AvailableCaptions> createState() => _AvailableCaptionsState();
}

class _AvailableCaptionsState extends State<AvailableCaptions> {
  int? _selectedIndex;
  DrumCorpsCaption? _selectedCaption;

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
                child: widget.availableCaptions == null
                    ? const Center(child: Text('No available captions'))
                    : ListView.builder(
                        itemCount: widget.availableCaptions!.length,
                        itemBuilder: (context, index) {
                          final corps =
                              widget.availableCaptions![index].corps.fullName;
                          final caption =
                              widget.availableCaptions![index].caption.name;
                          return ListTile(
                            title: Text('$corps - $caption'),
                            selected: index == _selectedIndex,
                            selectedColor: AppColors.customGreen,
                            visualDensity: const VisualDensity(
                                horizontal: -4.0, vertical: -4.0),
                            onTap: !widget.canPick
                                ? null
                                : () {
                                    setState(() {
                                      _selectedCaption =
                                          widget.availableCaptions![index];
                                      // Deselect if clicking on selected tile
                                      _selectedIndex = index == _selectedIndex
                                          ? null
                                          : index;
                                    });
                                  },
                          );
                        },
                      )),
            gapH8,
            if (widget.canPick)
              Align(
                alignment: Alignment.bottomRight,
                child: AccentButton(
                  label: 'Draft',
                  onPressed: () {
                    if (_selectedCaption == null) {
                      showAlertDialog(
                          context: context,
                          title: 'No Selection Made',
                          content: 'Select a caption to draft first.');
                      return;
                    }
                    widget.onCaptionSelected(_selectedCaption!);
                    setState(() {
                      // Reset the index and the caption to prevent duplication
                      _selectedIndex = null;
                      _selectedCaption = null;
                    });
                  },
                ),
              ),
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
  const TimerCard({
    super.key,
    required this.remainingTime,
  });

  final int remainingTime;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('00');
    return Card(
      child: Padding(
        padding: cardPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Time Left',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              ':${formatter.format(remainingTime)}',
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
  const RoundCard({
    super.key,
    required this.roundNumber,
  });

  final int roundNumber;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('00');
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
              formatter.format(roundNumber),
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
  const CurrentPickCard({
    super.key,
    this.currentPick,
    this.nextPick,
  });

  final String? currentPick;
  final String? nextPick;

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
              currentPick == null ? 'PENDING' : '@$currentPick',
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
              nextPick == null ? 'PENDING' : '@$nextPick',
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
  const CaptionFilterCard({
    super.key,
    required this.onFilterSelected,
  });

  final void Function(bool, Caption) onFilterSelected;

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
                    onChecked: (checked) => onFilterSelected(checked, caption),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
