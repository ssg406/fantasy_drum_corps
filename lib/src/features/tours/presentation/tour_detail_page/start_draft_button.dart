import 'package:fantasy_drum_corps/src/common_widgets/common_buttons.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/draft_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/app_routes.dart';

class DraftButton extends ConsumerWidget {
  const DraftButton({
    Key? key,
    required this.tourId,
    required this.draftComplete,
    required this.isOwner,
    required this.playerId,
  }) : super(key: key);

  final String tourId;
  final bool draftComplete;
  final bool isOwner;
  final String playerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PrimaryActionButton(
      icon: Icons.play_circle_outline_outlined,
      onPressed: () {
        if (!draftComplete) {
          ref.read(draftControllerProvider.notifier).joinRoom(
              playerId: playerId,
              tourId: tourId,
              action: isOwner ? 'create' : 'join');
        }
        context.pushNamed(AppRoutes.draftLobby.name,
            pathParameters: {'tid': tourId});
      },
      labelText: 'Go to Draft',
    );
  }
}
