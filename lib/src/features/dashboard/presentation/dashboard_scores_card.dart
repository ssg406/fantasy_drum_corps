import 'package:fantasy_drum_corps/src/common_widgets/fantasy_corps_tile.dart';
import 'package:fantasy_drum_corps/src/common_widgets/titled_icon_card.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardCorpsCard extends StatelessWidget {
  const DashboardCorpsCard({Key? key, required this.userCorps})
      : super(key: key);

  final List<FantasyCorps> userCorps;

  @override
  Widget build(BuildContext context) {
    return TitledIconCard(
      title: 'My Corps',
      iconData: FontAwesomeIcons.trophy,
      child: Column(
        children: [
          for (final corps in userCorps) FantasyCorpsTile(corps: corps),
        ],
      ),
    );
  }

  String _getScore(FantasyCorps corps) => corps.totalScore.toStringAsFixed(2);
}
