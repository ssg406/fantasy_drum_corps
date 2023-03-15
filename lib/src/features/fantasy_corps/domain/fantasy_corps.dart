import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/corps_lineup.dart';

class FantasyCorps {
  const FantasyCorps({
    required this.fantasyCorpsId,
    required this.tourId,
    required this.name,
    required this.userId,
    required this.captions,
  });
  final String fantasyCorpsId;
  final String tourId;
  final String name;
  final String userId;
  final CorpsLineup captions;

  factory FantasyCorps.fromJson(Map<String, dynamic> json, String id) {
    return FantasyCorps(
        fantasyCorpsId: id,
        tourId: json['tourId'],
        name: json['name'] as String,
        userId: json['userId'] as String,
        captions: CorpsLineup.fromJson(json));
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'tourId': tourId,
      'userId': userId,
      'captions': captions.toJson(),
    };
  }
}
