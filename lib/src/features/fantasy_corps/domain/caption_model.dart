import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';

class DrumCorpsCaption {
  const DrumCorpsCaption({
    required this.corps,
    required this.caption,
  });

  final DrumCorps corps;
  final Caption caption;
}
