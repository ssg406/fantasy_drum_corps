import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_model.dart';
import 'package:flutter/material.dart';

@immutable
class RemainingPicks {
  const RemainingPicks({
    this.id,
    required this.tourId,
    required this.leftOverPicks,
  });

  final String? id;
  final String tourId;
  final List<DrumCorpsCaption> leftOverPicks;

  factory RemainingPicks.fromJson(Map<String, dynamic> json, String id) =>
      RemainingPicks(
          id: id,
          tourId: json['tourId'],
          leftOverPicks: (json['leftOverPicks'] as List<dynamic>)
              .map((item) => DrumCorpsCaption.fromJson(item, item['id']))
              .toList());

  Map<String, dynamic> toJson() => {
        'tourId': tourId,
        'leftOverPicks': leftOverPicks.map((item) => item.toJson()).toList(),
      };

  RemainingPicks copyWith({List<DrumCorpsCaption>? leftOverPicks}) =>
      RemainingPicks(
          tourId: tourId, leftOverPicks: leftOverPicks ?? this.leftOverPicks);
}
