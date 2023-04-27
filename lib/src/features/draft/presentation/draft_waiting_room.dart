import 'package:fantasy_drum_corps/src/common_widgets/back_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/player_widget.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DraftWaitingRoom extends StatelessWidget {
  const DraftWaitingRoom({
    super.key,
    required this.tourName,
    required this.players,
    required this.isTourOwner,
    this.onOwnerStartsDraft,
  });

  final String tourName;
  final List<Player> players;
  final bool isTourOwner;
  final VoidCallback? onOwnerStartsDraft;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: pagePadding,
        child: Center(
          child: Column(
            children: [
              Text(
                '$tourName Draft Lobby',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              gapH16,
              players.isEmpty
                  ? Row(
                      children: [
                        const CircularProgressIndicator(),
                        gapW16,
                        Text(
                          'Waiting for players...',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        for (final player in players)
                          PlayerWidget(
                            name: player.displayName,
                            avatarString: player.avatarString,
                          ),
                      ],
                    ),
              gapH16,
              isTourOwner
                  ? ElevatedButton.icon(
                      icon: const FaIcon(FontAwesomeIcons.shieldHalved),
                      label: const Text('Start Draft'),
                      onPressed: onOwnerStartsDraft!,
                    )
                  : const Text('Waiting for tour owner to start draft'),
              gapH16,
              const CustomBackButton(),
            ],
          ),
        ),
      ),
    );
  }
}
