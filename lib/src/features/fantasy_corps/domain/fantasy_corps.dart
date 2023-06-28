import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:flutter/material.dart';

typedef Lineup = Map<Caption, DrumCorps?>;
typedef LineupScore = Map<Caption, double>;

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
    this.lineupScore,
  });

  final String? fantasyCorpsId;
  final String tourId;
  final String name;
  final String userId;
  final String? showTitle;
  final String? repertoire;
  final Lineup? lineup;
  final LineupScore? lineupScore;

  factory FantasyCorps.fromJson(Map<String, dynamic> json, String id) {
    return FantasyCorps(
      fantasyCorpsId: id,
      tourId: json['tourId'] as String,
      name: json['name'] as String,
      userId: json['userId'] as String,
      showTitle: json['showTitle'] as String?,
      repertoire: json['repertoire'] as String?,
      lineup:
          json['lineup'] != null ? LineupFromJson.call(json['lineup']) : null,
      lineupScore: json['lineupScore'] != null
          ? LineupFromJson.lineupScoreFromJson(json['lineupScore'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'tourId': tourId,
      'userId': userId,
      'showTitle': showTitle,
      'repertoire': repertoire,
      'lineup': lineupToJson(),
      'lineupScore': lineupScoreToJson(),
    };
  }

  Map<String, dynamic>? lineupToJson() {
    if (lineup == null) return null;
    final Map<String, dynamic> jsonMap = {};
    for (final caption in lineup!.keys) {
      jsonMap.addAll({caption.name: lineup?[caption]?.name});
    }
    return jsonMap;
  }

  Map<String, dynamic>? lineupScoreToJson() {
    if (lineupScore == null) return null;
    final Map<String, dynamic> jsonMap = {};
    for (final caption in lineupScore!.keys) {
      jsonMap.addAll({caption.name: lineupScore?[caption]});
    }
    return jsonMap;
  }

  FantasyCorps copyWith({
    String? name,
    String? tourId,
    String? userId,
    String? lineupId,
    String? showTitle,
    String? repertoire,
    Lineup? lineup,
    LineupScore? lineupScore,
  }) {
    return FantasyCorps(
      fantasyCorpsId: fantasyCorpsId,
      name: name ?? this.name,
      tourId: tourId ?? this.tourId,
      userId: userId ?? this.userId,
      showTitle: showTitle ?? this.showTitle,
      repertoire: repertoire ?? this.repertoire,
      lineup: lineup ?? this.lineup,
      lineupScore: lineupScore ?? this.lineupScore,
    );
  }

  double get totalScore {
    double totalScore = 0;
    if (lineupScore == null) return totalScore;
    for (final caption in lineupScore!.keys) {
      if (caption == Caption.ge1 || caption == Caption.ge2) {
        totalScore += lineupScore![caption] ?? 0;
      } else {
        totalScore += (lineupScore![caption] ?? 0) / 2;
      }
    }
    return totalScore;
  }
}

class LineupFromJson {
  static Lineup call(Map<String, dynamic> json) {
    final Lineup lineup = {};
    for (final captionKey in json.keys) {
      final caption = Caption.values.byName(captionKey);
      lineup.addAll({caption: DrumCorps.values.byName(json[captionKey])});
    }
    return lineup;
  }

  static LineupScore lineupScoreFromJson(Map<String, dynamic> json) {
    final LineupScore lineupScore = {};
    for (final captionKey in json.keys) {
      final caption = Caption.values.byName(captionKey);
      final score = json[captionKey] as num;
      lineupScore.addAll({caption: score.toDouble()});
    }
    return lineupScore;
  }
}
