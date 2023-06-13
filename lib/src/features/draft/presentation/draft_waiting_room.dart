import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fantasy_drum_corps/src/common_widgets/accent_button.dart';
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
    this.onOwnerStartsDraft,
  });

  final String tourName;
  final List<Player> players;
  final bool isTourOwner;
  final VoidCallback? onOwnerStartsDraft;

  @override
  Widget build(BuildContext context) {
    return PageScaffolding(
      pageTitle: '$tourName Draft Lobby',
      child: Column(
        children: [
          players.isEmpty
              ? _getNoPlayersDisplay(context)
              : _getJoinedPlayersDisplay(context),
          gapH16,
          isTourOwner
              ? AccentButton(
                  label: 'START DRAFT',
                  onPressed: onOwnerStartsDraft!,
                )
              : _getNonOwnerWaitingText(context),
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
            for (final player in players) ...[
              PlayerWidget(
                name: player.displayName,
                avatarString: player.avatarString,
              ),
              gapW16,
            ]
          ],
        ),
      ],
    );
  }
}
