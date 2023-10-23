import 'package:fantasy_drum_corps/src/common_widgets/titled_icon_card.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:fantasy_drum_corps/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class DashboardScoresCard extends StatelessWidget {
  const DashboardScoresCard({Key? key, required this.fantasyCorps})
      : super(key: key);

  final List<FantasyCorps> fantasyCorps;

  @override
  Widget build(BuildContext context) {
    return TitledIconCard(
      title: 'Your Scores',
      iconData: FontAwesomeIcons.trophy,
      child: Column(
        children: [
          for (final corps in fantasyCorps)
            ListTile(
              title: Text(
                corps.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(
                'Last Score: ${_getScore(corps)}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () => context.pushNamed(AppRoutes.leaderboard.name),
            )
        ],
      ),
    );
  }

  String _getScore(FantasyCorps corps) => corps.totalScore.toStringAsFixed(2);
}
