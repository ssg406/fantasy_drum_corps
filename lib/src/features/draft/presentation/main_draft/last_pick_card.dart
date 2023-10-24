import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_model.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:flutter/material.dart';

class LastPickCard extends StatelessWidget {
  const LastPickCard({Key? key, this.lastPlayersPick}) : super(key: key);
  final DrumCorpsCaption? lastPlayersPick;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'LAST PICK ',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          _getPickText(),
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.primary),
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }

  String _getPickText() => lastPlayersPick == null
      ? ''
      : '${lastPlayersPick!.corps.fullName} ${lastPlayersPick!.caption.abbreviation}';
}
