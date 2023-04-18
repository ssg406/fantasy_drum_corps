import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:quiver/core.dart';

const String defaultAvatar =
    '{"topType":15,"accessoriesType":0,"hairColor":1,"facialHairType":0,"facialHairColor":1,"clotheType":0,"eyeType":0,"eyebrowType":0,"mouthType":10,"skinColor":1,"clotheColor":14,"style":0,"graphicType":0}';

class Player {
  const Player({
    this.playerId,
    this.displayName,
    this.about,
    this.selectedCorps,
    this.avatarString = defaultAvatar,
    this.isActive = true,
  });

  final String? playerId;
  final String? displayName;
  final String? about;
  final DrumCorps? selectedCorps;
  final String? avatarString;
  final bool isActive;

  factory Player.fromJson(Map<String, dynamic> json, String playerId) {
    return Player(
      playerId: playerId,
      displayName: json['displayName'] as String?,
      about: json['about'] as String?,
      selectedCorps: json['selectedCorps'] == null
          ? null
          : DrumCorps.values.byName(json['selectedCorps']),
      avatarString: json['avatarString'] as String?,
      isActive: json['isActive'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'playerId': playerId,
      'displayName': displayName,
      'about': about,
      'selectedCorps': selectedCorps?.name,
      'avatarString': avatarString,
      'isActive': isActive,
    };
  }

  Player copyWith({
    String? displayName,
    String? about,
    DrumCorps? selectedCorps,
    String? avatarString,
    bool? isActive,
  }) {
    return Player(
      playerId: playerId,
      displayName: displayName ?? this.displayName,
      about: about ?? this.about,
      selectedCorps: selectedCorps ?? this.selectedCorps,
      avatarString: avatarString ?? this.avatarString,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  String toString() => 'Player(playerId: $playerId, '
      'displayName: $displayName, '
      'about: $about, '
      'selectedCorps: $selectedCorps, '
      'avatarString: $avatarString, '
      'isActive: $isActive)';

  @override
  int get hashCode => hash4(playerId, displayName, selectedCorps, avatarString);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;

    return other is Player &&
        other.playerId == playerId &&
        other.displayName == displayName &&
        other.about == about &&
        other.selectedCorps == selectedCorps &&
        other.avatarString == avatarString &&
        other.isActive == isActive;
  }
}
