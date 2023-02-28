import 'package:fantasy_drum_corps/src/features/leagues/domain/league_model.dart';
import 'package:flutter/material.dart';

/// [ListTile] which displays league data
class LeagueListTile extends StatelessWidget {
  const LeagueListTile({Key? key, required this.league}) : super(key: key);
  final League league;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // TODO navigate to /leagues/:id
      onTap: () => debugPrint('tapped'),
      title: Text(league.name, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(
        'members',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: const Icon(Icons.arrow_circle_right_outlined),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      iconColor: Theme.of(context).colorScheme.tertiary,
    );
  }
}
