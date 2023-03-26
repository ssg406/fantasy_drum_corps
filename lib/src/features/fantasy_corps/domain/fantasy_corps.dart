import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/corps_lineup.dart';
import 'package:flutter/cupertino.dart';

@immutable
class FantasyCorps {
  const FantasyCorps({
    required this.fantasyCorpsId,
    required this.tourId,
    required this.name,
    required this.userId,
    required this.captions,
    this.showTitle,
    this.repertoire,
  });

  final String fantasyCorpsId;
  final String tourId;
  final String name;
  final String userId;
  final CorpsLineup captions;
  final String? showTitle;
  final String? repertoire;

  factory FantasyCorps.fromJson(Map<String, dynamic> json, String id) {
    return FantasyCorps(
      fantasyCorpsId: id,
      tourId: json['tourId'],
      name: json['name'] as String,
      userId: json['userId'] as String,
      captions: CorpsLineup.fromJson(json),
      showTitle: json['showtitle'] as String?,
      repertoire: json['repertoire'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'tourId': tourId,
      'userId': userId,
      'captions': captions.toJson(),
      'showTitle': showTitle,
      'repertoire': repertoire,
    };
  }

  FantasyCorps copyWith({
    String? name,
    String? tourId,
    String? userId,
    CorpsLineup? captions,
    String? showTitle,
    String? repertoire,
  }) {
    return FantasyCorps(
      fantasyCorpsId: fantasyCorpsId,
      name: name ?? this.name,
      tourId: tourId ?? this.tourId,
      userId: userId ?? this.userId,
      captions: captions ?? this.captions,
      showTitle: showTitle ?? this.showTitle,
      repertoire: repertoire ?? this.repertoire,
    );
  }
}
