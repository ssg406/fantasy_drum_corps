import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiver/core.dart';

@immutable
class DrumCorpsCaption {
  const DrumCorpsCaption({
    required this.id,
    required this.corps,
    required this.caption,
  });

  final String id;
  final DrumCorps corps;
  final Caption caption;

  factory DrumCorpsCaption.fromJson(Map<String, dynamic> json, String id) {
    return DrumCorpsCaption(
        id: id,
        corps: DrumCorps.values.byName(json['corps']),
        caption: Caption.values.byName(json['caption']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'corps': corps.name,
      'caption': caption.name,
    };
  }

  DrumCorpsCaption copyWith({DrumCorps? corps, Caption? caption}) {
    return DrumCorpsCaption(
        id: id, corps: corps ?? this.corps, caption: caption ?? this.caption);
  }

  String get displayString => '${corps.fullName} ${caption.fullName}';

  @override
  String toString() =>
      'DrumCorpsCaption(id: $id, corps: ${corps.fullName}, caption: ${caption.name})';

  @override
  int get hashCode => hash3(id, corps, caption);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DrumCorpsCaption &&
        other.id == id &&
        other.corps == corps &&
        other.caption == caption;
  }
}
