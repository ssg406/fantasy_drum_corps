import 'package:fantasy_drum_corps/src/common_widgets/user_avatar.dart';
import 'package:flutter/material.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key, this.name, this.avatarString, this.size});

  final String? name;
  final String? avatarString;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Avatar(size: size ?? 45, avatarString: avatarString),
        Text(
          name ?? 'Anonymous',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
