import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/item_label.dart';
import 'package:fantasy_drum_corps/src/common_widgets/player_widget.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/application/player_tour_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class TourMembers extends ConsumerWidget {
  const TourMembers({Key? key, required this.members}) : super(key: key);
  final List<String> members;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(watchTourPlayersProvider(members)),
      data: (List<Player> players) {
        return Flex(
          direction: ResponsiveBreakpoints.of(context).largerOrEqualTo(TABLET)
              ? Axis.horizontal
              : Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ItemLabel(label: 'Tour Members'),
            Wrap(
              children: [
                for (final player in players) ...[
                  PlayerWidget(
                      name: player.displayName,
                      avatarString: player.avatarString),
                  gapW8,
                ]
              ],
            ),
          ],
        );
      },
    );
  }
}
