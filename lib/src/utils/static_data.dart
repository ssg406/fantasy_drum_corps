import 'dart:math';

import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';

import '../features/fantasy_corps/domain/caption_model.dart';

/// Returns static data used for testing
class DrumCorpsData {
  static List<DrumCorpsCaption> getAllPicks() {
    List<DrumCorpsCaption> allPicks = List.empty(growable: true);

    for (final caption in Caption.values) {
      for (final corps in DrumCorps.values) {
        allPicks.add(DrumCorpsCaption(
            drumCorpsCaptionId: '${caption.name} ${corps.name}',
            corps: corps,
            caption: caption));
      }
    }
    return allPicks;
  }

  static Map<Caption, List<DrumCorpsCaption>> getAvailablePicksMap() {
    final availablePicks = <Caption, List<DrumCorpsCaption>>{};
    for (final caption in Caption.values) {
      final corpsList = DrumCorps.values
          .map((corps) => DrumCorpsCaption(
              drumCorpsCaptionId: Random().nextDouble().toString(),
              caption: caption,
              corps: corps))
          .toList();
      availablePicks.addAll({caption: corpsList});
    }
    return availablePicks;
  }
}
