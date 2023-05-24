import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:flutter/material.dart';

@immutable
class CorpsScore {
  const CorpsScore({
    this.id,
    required this.corps,
    required this.ge1,
    required this.ge2,
    required this.visualProficiency,
    required this.visualAnalysis,
    required this.colorGuard,
    required this.brass,
    required this.musicAnalysis,
    required this.percussion,
    required this.lastUpdate,
  });

  final String? id;
  final DrumCorps corps;
  final double ge1;
  final double ge2;
  final double visualProficiency;
  final double visualAnalysis;
  final double colorGuard;
  final double brass;
  final double musicAnalysis;
  final double percussion;
  final DateTime lastUpdate;

  factory CorpsScore.fromJson(Map<String, dynamic> json, String id) {
    return CorpsScore(
        id: id,
        corps: DrumCorps.values.byName(json['corps'] as String),
        ge1: json['ge1'] as double,
        ge2: json['ge2'] as double,
        visualProficiency: json['visualProficiency'] as double,
        visualAnalysis: json['visualAnalysis'] as double,
        colorGuard: json['colorGuard'] as double,
        brass: json['brass'] as double,
        musicAnalysis: json['musicAnalysis'] as double,
        percussion: json['percussion'] as double,
        lastUpdate: (json['lastUpdate'] as Timestamp).toDate());
  }

  Map<String, dynamic> toJson() {
    return {
      'corps': corps.name,
      'ge1': ge1,
      'ge2': ge2,
      'visualProficiency': visualProficiency,
      'visualAnalysis': visualAnalysis,
      'colorGuard': colorGuard,
      'brass': brass,
      'musicAnalysis': musicAnalysis,
      'percussion': percussion,
      'lastUpdate': lastUpdate,
    };
  }

  CorpsScore copyWith({
    double? ge1,
    double? ge2,
    double? visualProficiency,
    double? visualAnalysis,
    double? colorGuard,
    double? brass,
    double? musicAnalysis,
    double? percussion,
    DateTime? lastUpdate,
  }) {
    return CorpsScore(
        corps: corps,
        ge1: ge1 ?? this.ge1,
        ge2: ge2 ?? this.ge2,
        visualProficiency: visualProficiency ?? this.visualProficiency,
        visualAnalysis: visualAnalysis ?? this.visualAnalysis,
        colorGuard: colorGuard ?? this.colorGuard,
        brass: brass ?? this.brass,
        musicAnalysis: musicAnalysis ?? this.musicAnalysis,
        percussion: percussion ?? this.percussion,
        lastUpdate: lastUpdate ?? this.lastUpdate);
  }
}
