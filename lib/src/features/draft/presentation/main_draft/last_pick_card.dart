import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_model.dart';
import 'package:fantasy_drum_corps/src/utils/app_color_schemes.dart';
import 'package:flutter/material.dart';

class LastPickCard extends StatelessWidget {
  const LastPickCard({Key? key, this.lastPlayersPick}) : super(key: key);
  final DrumCorpsCaption? lastPlayersPick;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'LAST PICK ',
        style: Theme.of(context).textTheme.bodyLarge,
        children: [
          TextSpan(
              text: lastPlayersPick?.displayString,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: AppColors.customBlue)),
        ],
      ),
    );
  }
}
