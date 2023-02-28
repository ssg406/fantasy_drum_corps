import 'package:uuid/uuid.dart';

import '../../authentication/domain/user_model.dart';

typedef LeagueID = String;

/// Model class which represents a FantasyDC league
class League {
  League({
    required this.leagueId,
    required this.leagueName,
    required this.isPublic,
    required this.owner,
  });
  final LeagueID leagueId;
  final String leagueName;
  final bool isPublic;
  final UserID owner;

  String get id => leagueId;
  String get name => leagueName;

  factory League.fromMap(Map<String, dynamic> data, LeagueID id) {
    final leagueName = data['leagueName'] as String;
    final isPublic = data['isPublic'] as bool;
    final owner = data['owner'] as UserID;
    return League(
        leagueId: id, leagueName: leagueName, isPublic: isPublic, owner: owner);
  }

  Map<String, dynamic> toMap() {
    return {
      'leagueName': leagueName,
      'isPublic': isPublic,
      'owner': owner,
    };
  }
}
