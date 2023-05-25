import 'package:fantasy_drum_corps/src/common_widgets/titled_icon_card.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:fantasy_drum_corps/src/utils/app_color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CompleteProfileCard extends StatelessWidget {
  const CompleteProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledIconCard(
      title: 'Complete Your Profile',
      subtitle:
          'Choose or update your display name to make it easy for other players to find you and your tours! Make sure to select a corps to sponsor as well so we can route your donation correctly.',
      icon: const FaIcon(
        FontAwesomeIcons.user,
        color: AppColors.customBlue,
      ),
      child: ButtonBar(
        children: [
          TextButton.icon(
            onPressed: () => context.goNamed(AppRoutes.profile.name),
            icon: const Icon(Icons.arrow_circle_right_outlined),
            label: const Text('Go to Profile'),
          ),
        ],
      ),
    );
  }
}
