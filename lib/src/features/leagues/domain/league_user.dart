import 'package:fantasy_drum_corps/src/features/authentication/domain/user_model.dart';
import 'package:fantasy_drum_corps/src/features/leagues/domain/league_model.dart';

/// Joins UserID and LeagueID to represent membership in league
class LeagueUser {
  const LeagueUser({required this.userId, required this.leagueId});
  final UserID userId;
  final LeagueID leagueId;

  factory LeagueUser.fromMap(Map<String, dynamic> data) {
    final userId = data['userId'] as UserID;
    final leagueId = data['leagueId'] as LeagueID;
    return LeagueUser(userId: userId, leagueId: leagueId);
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'leagueId': leagueId,
    };
  }
}
