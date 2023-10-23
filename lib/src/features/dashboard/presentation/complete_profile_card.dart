import 'package:fantasy_drum_corps/src/common_widgets/common_buttons.dart';
import 'package:fantasy_drum_corps/src/common_widgets/titled_icon_card.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CompleteProfileCard extends StatelessWidget {
  const CompleteProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledIconCard(
      title: 'Complete Your Profile',
      subtitle: 'Choose a display name and sponsored corps',
      iconData: FontAwesomeIcons.user,
      child: Column(
        children: [
          Text(
            'Choose or update your display name to make it easy for other players to find you and your tours! Make sure to select a corps to sponsor as well so we can route your donation correctly.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          gapH16,
          ButtonBar(
            children: [
              PrimaryActionButton(
                onPressed: () => context.goNamed(AppRoutes.profile.name),
                icon: Icons.person,
                labelText: 'Go to Profile',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
