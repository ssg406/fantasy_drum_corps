import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiver/core.dart';

@immutable
class DrumCorpsCaption {
  const DrumCorpsCaption({
    required this.corps,
    required this.caption,
  });

  final DrumCorps corps;
  final Caption caption;

  DrumCorpsCaption copyWith({DrumCorps? corps, Caption? caption}) {
    return DrumCorpsCaption(
        corps: corps ?? this.corps, caption: caption ?? this.caption);
  }

  @override
  String toString() =>
      'DrumCorpsCaption(corps: ${corps.fullName}, ${caption.name})';

  @override
  int get hashCode => hash2(corps, caption);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DrumCorpsCaption &&
        other.corps == corps &&
        other.caption == caption;
  }
}
