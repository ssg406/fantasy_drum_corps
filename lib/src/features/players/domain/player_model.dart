import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';

class Player {
  Player({
    required this.playerId,
    this.displayName,
    this.about,
    this.selectedCorps,
    this.photoUrl,
  });

  final String playerId;
  String? displayName;
  String? about;
  DrumCorps? selectedCorps;
  String? photoUrl;

  factory Player.fromJson(Map<String, dynamic> json, String playerId) {
    return Player(
      playerId: playerId,
      displayName: json['displayName'] as String?,
      about: json['about'] as String?,
      selectedCorps: json['selectedCorps'] == null
          ? null
          : DrumCorps.values.byName(json['selectedCorps']),
      photoUrl: json['photoUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'playerId': playerId,
      'displayName': displayName,
      'about': about,
      'selectedCorps': selectedCorps?.name,
      'photoUrl': photoUrl,
    };
  }
}
