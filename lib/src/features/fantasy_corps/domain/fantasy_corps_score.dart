import 'package:flutter/material.dart';

@immutable
class FantasyCorpsScore {
  const FantasyCorpsScore({
    this.fantasyCorpsScoreId,
    required this.fantasyCorpsId,
    this.generalEffect1First = 0,
    this.generalEffect1Second = 0,
    this.generalEffect2First = 0,
    this.generalEffect2Second = 0,
    this.visualProficiencyFirst = 0,
    this.visualProficiencySecond = 0,
    this.visualAnalysisFirst = 0,
    this.visualAnalysisSecond = 0,
    this.colorGuardFirst = 0,
    this.colorGuardSecond = 0,
    this.brassFirst = 0,
    this.brassSecond = 0,
    this.musicAnalysisFirst = 0,
    this.musicAnalysisSecond = 0,
    this.percussionFirst = 0,
    this.percussionSecond = 0,
  });

  final String? fantasyCorpsScoreId;
  final String fantasyCorpsId;
  final double generalEffect1First;
  final double generalEffect1Second;
  final double generalEffect2First;
  final double generalEffect2Second;
  final double visualProficiencyFirst;
  final double visualProficiencySecond;
  final double visualAnalysisFirst;
  final double visualAnalysisSecond;
  final double colorGuardFirst;
  final double colorGuardSecond;
  final double brassFirst;
  final double brassSecond;
  final double musicAnalysisFirst;
  final double musicAnalysisSecond;
  final double percussionFirst;
  final double percussionSecond;

  String get ge1 =>
      ((generalEffect1First + generalEffect1Second) / 2.0).toStringAsFixed(2);

  String get ge2 =>
      ((generalEffect2First + generalEffect2Second) / 2.0).toStringAsFixed(2);

  String get visualProficiency =>
      ((visualProficiencyFirst + visualProficiencySecond) / 2.0)
          .toStringAsFixed(2);

  String get visualAnalysis =>
      ((visualAnalysisFirst + visualAnalysisSecond) / 2.0).toStringAsFixed(2);

  String get colorGuard =>
      ((colorGuardFirst + colorGuardSecond) / 2.0).toStringAsFixed(2);

  String get brass => ((brassFirst + brassSecond) / 2.0).toStringAsFixed(2);

  String get musicAnalysis =>
      ((musicAnalysisFirst + musicAnalysisSecond) / 2.0).toStringAsFixed(2);

  String get percussion =>
      ((percussionFirst + percussionSecond) / 2.0).toStringAsFixed(2);

  factory FantasyCorpsScore.fromJson(
      Map<String, dynamic> json, String fantasyCorpsScoreId) {
    return FantasyCorpsScore(
      fantasyCorpsScoreId: fantasyCorpsScoreId,
      fantasyCorpsId: json['fantasyCorpsId'] as String,
      generalEffect1First: json['generalEffect1First'] as double,
      generalEffect1Second: json['generalEffect1Second'] as double,
      generalEffect2First: json['generalEffect2First'] as double,
      generalEffect2Second: json['generalEffect2Second'] as double,
      visualProficiencyFirst: json['visualProficiencyFirst'] as double,
      visualProficiencySecond: json['visualProficiencySecond'] as double,
      visualAnalysisFirst: json['visualAnalysisFirst'] as double,
      visualAnalysisSecond: json['visualAnalysisSecond'] as double,
      colorGuardFirst: json['colorGuardFirst'] as double,
      colorGuardSecond: json['colorGuardSecond'] as double,
      brassFirst: json['brassFirst'] as double,
      brassSecond: json['brassSecond'] as double,
      musicAnalysisFirst: json['musicAnalysisFirst'] as double,
      musicAnalysisSecond: json['musicAnalysisSecond'] as double,
      percussionFirst: json['percussionFirst'] as double,
      percussionSecond: json['percussionSecond'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fantasyCorpsScoreId': fantasyCorpsScoreId,
      'fantasyCorpsId': fantasyCorpsId,
      'generalEffect1First': generalEffect1First,
      'generalEffect1Second': generalEffect1Second,
      'generalEffect2First': generalEffect2First,
      'generalEffect2Second': generalEffect2Second,
      'visualProficiencyFirst': visualProficiencyFirst,
      'visualProficiencySecond': visualProficiencySecond,
      'visualAnalysisFirst': visualAnalysisFirst,
      'visualAnalysisSecond': visualAnalysisSecond,
      'colorGuardFirst': colorGuardFirst,
      'colorGuardSecond': colorGuardSecond,
      'brassFirst': brassFirst,
      'brassSecond': brassSecond,
      'musicAnalysisFirst': musicAnalysisFirst,
      'musicAnalysisSecond': musicAnalysisSecond,
      'percussionFirst': percussionFirst,
      'percussionSecond': percussionSecond,
    };
  }

  FantasyCorpsScore copyWith({
    double? generalEffect1First,
    double? generalEffect1Second,
    double? generalEffect2First,
    double? generalEffect2Second,
    double? visualProficiencyFirst,
    double? visualProficiencySecond,
    double? visualAnalysisFirst,
    double? visualAnalysisSecond,
    double? colorGuardFirst,
    double? colorGuardSecond,
    double? brassFirst,
    double? brassSecond,
    double? musicAnalysisFirst,
    double? musicAnalysisSecond,
    double? percussionFirst,
    double? percussionSecond,
  }) =>
      FantasyCorpsScore(
        fantasyCorpsScoreId: fantasyCorpsScoreId,
        fantasyCorpsId: fantasyCorpsId,
        generalEffect1First: generalEffect1First ?? this.generalEffect1First,
        generalEffect1Second: generalEffect1Second ?? this.generalEffect1Second,
        generalEffect2First: generalEffect2First ?? this.generalEffect2First,
        generalEffect2Second: generalEffect2Second ?? this.generalEffect2Second,
        visualProficiencyFirst:
            visualProficiencyFirst ?? this.visualProficiencyFirst,
        visualProficiencySecond:
            visualProficiencySecond ?? this.visualProficiencySecond,
        visualAnalysisFirst: visualAnalysisFirst ?? this.visualAnalysisFirst,
        visualAnalysisSecond: visualAnalysisSecond ?? this.visualAnalysisSecond,
        colorGuardFirst: colorGuardFirst ?? this.colorGuardFirst,
        colorGuardSecond: colorGuardSecond ?? this.colorGuardSecond,
        brassFirst: brassFirst ?? this.brassFirst,
        brassSecond: brassSecond ?? this.brassSecond,
        musicAnalysisFirst: musicAnalysisFirst ?? this.musicAnalysisFirst,
        musicAnalysisSecond: musicAnalysisSecond ?? this.musicAnalysisSecond,
        percussionFirst: percussionFirst ?? this.percussionFirst,
        percussionSecond: percussionSecond ?? this.percussionSecond,
      );
}
