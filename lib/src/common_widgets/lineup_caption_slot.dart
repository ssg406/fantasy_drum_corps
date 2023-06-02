import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:flutter/material.dart';

class LineupCaptionSlot extends StatelessWidget {
  const LineupCaptionSlot({super.key, this.pick, required this.caption});

  final Caption caption;
  final DrumCorps? pick;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(caption.fullName, style: Theme
          .of(context)
          .textTheme
          .titleMedium,),
      subtitle: pick == null
          ? Text(
        'OPEN SLOT',
        style: Theme
            .of(context)
            .textTheme
            .titleSmall,
      )
          : Text(
        pick!.fullName,
        style: Theme
            .of(context)
            .textTheme
            .titleSmall,
      ),

    );
  }
}
