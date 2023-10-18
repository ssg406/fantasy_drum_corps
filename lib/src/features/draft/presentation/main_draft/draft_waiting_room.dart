import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fantasy_drum_corps/src/common_widgets/page_scaffold.dart';
import 'package:fantasy_drum_corps/src/common_widgets/player_widget.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:fantasy_drum_corps/src/utils/app_color_schemes.dart';
import 'package:flutter/material.dart';

class DraftWaitingRoom extends StatelessWidget {
  const DraftWaitingRoom({
    super.key,
    required this.tourName,
    required this.players,
    required this.isTourOwner,
    required this.markPlayerReady,
    required this.playerIsReady,
    this.canStartDraft = false,
    this.onOwnerStartsDraft,
    this.onBackPressed,
  });

  final String tourName;
  final Map<Player, bool> players;
  final bool isTourOwner;
  final VoidCallback markPlayerReady;
  final bool playerIsReady;
  final bool canStartDraft;
  final VoidCallback? onOwnerStartsDraft;
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return PageScaffolding(
      pageTitle: '$tourName Draft Waiting Room',
      onBackPressed: onBackPressed,
      child: Column(
        children: [
          players.isEmpty
              ? _getNoPlayersDisplay(context)
              : _getJoinedPlayersDisplay(context),
          gapH16,
          ButtonBar(
            children: [
              if (isTourOwner)
                FilledButton(
                  onPressed: canStartDraft ? onOwnerStartsDraft : null,
                  child:
                      Text(canStartDraft ? 'START DRAFT' : 'PLAYERS NOT READY'),
                ),
              FilledButton(
                onPressed: playerIsReady ? null : markPlayerReady,
                child: Text(playerIsReady ? 'PLAYER READY' : 'READY TO PLAY'),
              )
            ],
          ),
          if (!isTourOwner) _getNonOwnerWaitingText(context),
        ],
      ),
    );
  }

  Widget _getNonOwnerWaitingText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(
          strokeWidth: 3.0,
          color: AppColors.customGreen,
        ),
        gapW16,
        Text(
          'Waiting for tour owner to start draft...',
          style: Theme.of(context).textTheme.titleMedium,
        )
      ],
    );
  }

  Widget _getNoPlayersDisplay(BuildContext context) {
    return Column(
      children: [
        Text(
          'Waiting for server...',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const CircularProgressIndicator(),
      ],
    );
  }

  Widget _getJoinedPlayersDisplay(BuildContext context) {
    return Column(
      children: [
        DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyLarge!,
          child: Row(
            children: [
              const Text('Players are arriving'),
              AnimatedTextKit(
                repeatForever: true,
                pause: const Duration(milliseconds: 500),
                animatedTexts: [
                  TyperAnimatedText('...',
                      speed: const Duration(milliseconds: 200)),
                ],
              )
            ],
          ),
        ),
        gapH16,
        Row(
          children: [
            for (final playerEntry in players.entries) ...[
              Column(
                children: [
                  PlayerWidget(
                    name: playerEntry.key.displayName,
                    avatarString: playerEntry.key.avatarString,
                  ),
                  gapH8,
                  if (playerEntry.value)
                    Text(
                      'READY',
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  else
                    Text(
                      'NOT READY',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                ],
              ),
              gapW16,
            ]
          ],
        ),
      ],
    );
  }
}
