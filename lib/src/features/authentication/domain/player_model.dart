class Player {
  const Player({
    required this.playerId,
    required this.displayName,
    this.about,
    this.selectedCorps,
  });
  final String playerId;
  final String displayName;
  final String? about;
  final String? selectedCorps;

  factory Player.fromJson(Map<String, dynamic> json, String playerId) {
    return Player(
      playerId: playerId,
      displayName: json['displayName'] as String,
      about: json['about'] as String?,
      selectedCorps: json['selectedCorps'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'about': about,
      'selectedCorps': selectedCorps,
    };
  }
}
