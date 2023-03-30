import 'package:fantasy_drum_corps/src/common_widgets/user_avatar.dart';
import 'package:flutter/material.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key, this.name, this.photoUrl});

  final String? name;
  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Avatar(radius: 15, photoUrl: photoUrl),
        Text(
          name ?? 'Anonymous',
          style: const TextStyle(
            color: Colors.white60,
          ),
        ),
      ],
    );
  }
}
