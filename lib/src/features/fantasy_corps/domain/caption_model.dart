import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiver/core.dart';

@immutable
class DrumCorpsCaption {
  const DrumCorpsCaption({
    required this.drumCorpsCaptionId,
    required this.corps,
    required this.caption,
  });

  final String drumCorpsCaptionId;
  final DrumCorps corps;
  final Caption caption;

  factory DrumCorpsCaption.fromJson(Map<String, dynamic> json, String id) {
    return DrumCorpsCaption(
        drumCorpsCaptionId: id,
        corps: DrumCorps.values.byName(json['corps']),
        caption: Caption.values.byName(json['caption']));
  }

  Map<String, dynamic> toJson() {
    return {
      'drumCorpsCaptionId': drumCorpsCaptionId,
      'corps': corps.name,
      'caption': caption.name,
    };
  }

  DrumCorpsCaption copyWith({DrumCorps? corps, Caption? caption}) {
    return DrumCorpsCaption(
        drumCorpsCaptionId: drumCorpsCaptionId,
        corps: corps ?? this.corps,
        caption: caption ?? this.caption);
  }

  @override
  String toString() =>
      'DrumCorpsCaption(drumCorpsCaptionId: $drumCorpsCaptionId, corps: ${corps.fullName}, caption: ${caption.name})';

  @override
  int get hashCode => hash3(drumCorpsCaptionId, corps, caption);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DrumCorpsCaption &&
        other.drumCorpsCaptionId == drumCorpsCaptionId &&
        other.corps == corps &&
        other.caption == caption;
  }
}
