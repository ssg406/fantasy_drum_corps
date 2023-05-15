import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:flutter/material.dart';

typedef Lineup = Map<Caption, List<DrumCorps>>;

@immutable
class FantasyCorps {
  const FantasyCorps({
    this.fantasyCorpsId,
    required this.tourId,
    required this.name,
    required this.userId,
    this.showTitle,
    this.repertoire,
    this.lineup,
  });

  final String? fantasyCorpsId;
  final String tourId;
  final String name;
  final String userId;
  final String? showTitle;
  final String? repertoire;
  final Lineup? lineup;

  factory FantasyCorps.fromJson(Map<String, dynamic> json, String id) {
    return FantasyCorps(
      fantasyCorpsId: id,
      tourId: json['tourId'],
      name: json['name'] as String,
      userId: json['userId'] as String,
      showTitle: json['showTitle'] as String?,
      repertoire: json['repertoire'] as String?,
      lineup: json['lineup'] as Lineup?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'tourId': tourId,
      'userId': userId,
      'showTitle': showTitle,
      'repertoire': repertoire,
      'lineup': lineup,
    };
  }

  FantasyCorps copyWith({
    String? name,
    String? tourId,
    String? userId,
    String? lineupId,
    String? showTitle,
    String? repertoire,
    Lineup? lineup,
  }) {
    return FantasyCorps(
      fantasyCorpsId: fantasyCorpsId,
      name: name ?? this.name,
      tourId: tourId ?? this.tourId,
      userId: userId ?? this.userId,
      showTitle: showTitle ?? this.showTitle,
      repertoire: repertoire ?? this.repertoire,
      lineup: lineup ?? this.lineup,
    );
  }
}
