import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';

class CorpsLineup {
  CorpsLineup({
    required this.userId,
    this.generalEffect1,
    this.generalEffect2,
    this.visualProficiency,
    this.visualAnalysis,
    this.colorGuard,
    this.brass,
    this.musicAnalysis1,
    this.musicAnalysis2,
    this.percussion,
  });

  final String userId;
  DrumCorps? generalEffect1;
  DrumCorps? generalEffect2;
  DrumCorps? visualProficiency;
  DrumCorps? visualAnalysis;
  DrumCorps? colorGuard;
  DrumCorps? brass;
  DrumCorps? musicAnalysis1;
  DrumCorps? musicAnalysis2;
  DrumCorps? percussion;

  factory CorpsLineup.fromJson(Map<String, dynamic> json) {
    return CorpsLineup(
      userId: json['userId'] as String,
      generalEffect1: json['generalEffect1'] as DrumCorps?,
      generalEffect2: json['generalEffect2'] as DrumCorps?,
      visualProficiency: json['visualProficiency'] as DrumCorps?,
      visualAnalysis: json['visualAnalysis'] as DrumCorps?,
      colorGuard: json['colorGuard'] as DrumCorps?,
      brass: json['brass'] as DrumCorps?,
      musicAnalysis1: json['musicAnalysis1'] as DrumCorps?,
      musicAnalysis2: json['musicAnalysis2'] as DrumCorps?,
      percussion: json['percussion'] as DrumCorps?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'generalEffect1': generalEffect1,
      'generalEffect2': generalEffect2,
      'visualProficiency': visualProficiency,
      'visualAnalysis': visualAnalysis,
      'colorGuard': colorGuard,
      'brass': brass,
      'musicAnalysis1': musicAnalysis1,
      'musicAnalysis2': musicAnalysis2,
      'percussion': percussion,
    };
  }
}
