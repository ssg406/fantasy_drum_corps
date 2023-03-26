import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:flutter/cupertino.dart';

@immutable
class DrumCorpsCaption {
  const DrumCorpsCaption({
    required this.corps,
    required this.caption,
  });

  final DrumCorps corps;
  final Caption caption;

  DrumCorpsCaption copyWith({DrumCorps? corps, Caption? caption}) {
    return DrumCorpsCaption(corps: corps ?? this.corps, caption: caption ?? this.caption);
  }
}
