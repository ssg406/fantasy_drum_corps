import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';

class CorpsLineup {
  const CorpsLineup({
    this.lineupId,
    required this.userId,
    required this.tourId,
    this.generalEffect1First,
    this.generalEffect1Second,
    this.generalEffect2First,
    this.generalEffect2Second,
    this.visualProficiencyFirst,
    this.visualProficiencySecond,
    this.visualAnalysisFirst,
    this.visualAnalysisSecond,
    this.colorGuardFirst,
    this.colorGuardSecond,
    this.brassFirst,
    this.brassSecond,
    this.musicAnalysisFirst,
    this.musicAnalysisSecond,
    this.percussionFirst,
    this.percussionSecond,
  });

  final String? lineupId;
  final String userId;
  final String tourId;
  final DrumCorps? generalEffect1First;
  final DrumCorps? generalEffect1Second;
  final DrumCorps? generalEffect2First;
  final DrumCorps? generalEffect2Second;
  final DrumCorps? visualProficiencyFirst;
  final DrumCorps? visualProficiencySecond;
  final DrumCorps? visualAnalysisFirst;
  final DrumCorps? visualAnalysisSecond;
  final DrumCorps? colorGuardFirst;
  final DrumCorps? colorGuardSecond;
  final DrumCorps? brassFirst;
  final DrumCorps? brassSecond;
  final DrumCorps? musicAnalysisFirst;
  final DrumCorps? musicAnalysisSecond;
  final DrumCorps? percussionFirst;
  final DrumCorps? percussionSecond;

  factory CorpsLineup.fromJson(Map<String, dynamic> json, String lineupId) {
    return CorpsLineup(
      lineupId: lineupId,
      userId: json['userId'] as String,
      tourId: json['tourId'] as String,
      generalEffect1First: json['generalEffect1First'] as DrumCorps?,
      generalEffect1Second: json['generalEffect1Second'] as DrumCorps?,
      generalEffect2First: json['generalEffect2First'] as DrumCorps?,
      generalEffect2Second: json['generalEffect2Second'] as DrumCorps?,
      visualProficiencyFirst: json['visualProficiencyFirst'] as DrumCorps?,
      visualProficiencySecond: json['visualProficiencySecond'] as DrumCorps?,
      visualAnalysisFirst: json['visualAnalysisFirst'] as DrumCorps?,
      visualAnalysisSecond: json['visualAnalysisSecond'] as DrumCorps?,
      colorGuardFirst: json['colorGuardFirst'] as DrumCorps?,
      colorGuardSecond: json['colorGuardSecond'] as DrumCorps?,
      brassFirst: json['brassFirst'] as DrumCorps?,
      brassSecond: json['brassSecond'] as DrumCorps?,
      musicAnalysisFirst: json['musicAnalysisFirst'] as DrumCorps?,
      musicAnalysisSecond: json['musicAnalysisSecond'] as DrumCorps?,
      percussionFirst: json['percussionFirst'] as DrumCorps?,
      percussionSecond: json['percussionSecond'] as DrumCorps?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lineupId': lineupId,
      'userId': userId,
      'tourId': tourId,
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

  CorpsLineup copyWith({
    DrumCorps? generalEffect1First,
    DrumCorps? generalEffect1Second,
    DrumCorps? generalEffect2First,
    DrumCorps? generalEffect2Second,
    DrumCorps? visualProficiencyFirst,
    DrumCorps? visualProficiencySecond,
    DrumCorps? visualAnalysisFirst,
    DrumCorps? visualAnalysisSecond,
    DrumCorps? colorGuardFirst,
    DrumCorps? colorGuardSecond,
    DrumCorps? brassFirst,
    DrumCorps? brassSecond,
    DrumCorps? musicAnalysisFirst,
    DrumCorps? musicAnalysisSecond,
    DrumCorps? percussionFirst,
    DrumCorps? percussionSecond,
  }) =>
      CorpsLineup(
        lineupId: lineupId,
        userId: userId,
        tourId: tourId,
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
