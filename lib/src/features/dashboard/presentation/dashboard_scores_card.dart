import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:fantasy_drum_corps/src/utils/app_color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class DashboardScoresCard extends StatelessWidget {
  const DashboardScoresCard({Key? key, required this.fantasyCorps})
      : super(key: key);

  final List<FantasyCorps> fantasyCorps;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: cardPadding,
        child: Column(
          children: [
            Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.trophy,
                  color: AppColors.customBlue,
                ),
                gapW16,
                Text('Your Scores',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            gapH24,
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (final corps in fantasyCorps)
                    SizedBox(
                      width: 200,
                      height: 100,
                      child: ListTile(
                        isThreeLine: true,
                        title: Text(
                          corps.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                        ),
                        subtitle: Text(
                          'Last Score: ${_getScore(corps)}',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.white),
                        ),
                        onTap: () =>
                            context.pushNamed(AppRoutes.leaderboard.name),
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getScore(FantasyCorps corps) => corps.totalScore.toStringAsFixed(2);
}
