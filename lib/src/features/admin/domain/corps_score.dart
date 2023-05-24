import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:flutter/material.dart';

@immutable
class CorpsScore {
  const CorpsScore({
    this.id,
    required this.corps,
    required this.scores,
    required this.lastUpdate,
  });

  final String? id;
  final DrumCorps corps;
  final LineupScore scores;
  final DateTime lastUpdate;

  factory CorpsScore.fromJson(Map<String, dynamic> json, String id) {
    return CorpsScore(
        id: id,
        corps: DrumCorps.values.byName(json['corps']),
        scores: LineupScoreFromJson.call(json['scores']),
        lastUpdate: (json['lastUpdate'] as Timestamp).toDate());
  }

  Map<String, dynamic> toJson() {
    return {
      'corps': corps.name,
      'scores': lineupScoreToJson(),
      'lastUpdate': lastUpdate,
    };
  }

  Map<String, dynamic> lineupScoreToJson() {
    final Map<String, dynamic> jsonMap = {};
    for (final caption in scores.keys) {
      jsonMap.addAll({caption.name: scores[caption]});
    }
    return jsonMap;
  }

  CorpsScore copyWith({
    LineupScore? scores,
    DateTime? lastUpdate,
  }) {
    return CorpsScore(
      id: id,
      corps: corps,
      scores: scores ?? this.scores,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }
}

class LineupScoreFromJson {
  static LineupScore call(Map<String, dynamic> json) {
    final LineupScore lineupScore = {};
    for (final captionKey in json.keys) {
      final caption = Caption.values.byName(captionKey);
      final score = json[captionKey] as double;
      lineupScore.addAll({caption: score});
    }
    return lineupScore;
  }
}
