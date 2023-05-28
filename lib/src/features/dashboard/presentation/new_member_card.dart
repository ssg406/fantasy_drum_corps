import 'package:fantasy_drum_corps/src/common_widgets/titled_icon_card.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:fantasy_drum_corps/src/utils/app_color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class NewMemberCard extends StatelessWidget {
  const NewMemberCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledIconCard(
      icon: const FaIcon(
        FontAwesomeIcons.shieldHalved,
        color: AppColors.customBlue,
      ),
      title: 'Find Tours',
      subtitle:
          'Find tours to join to participate in the draft and create your Fantasy Corps',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'It looks like you have not created or joined a tour yet. Create a new tour and invite others. Or, search for a public tour to join. You can participate in as many tours as you like.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          gapH16,
          ButtonBar(
            children: [
              TextButton.icon(
                onPressed: () => context.goNamed(AppRoutes.createTour.name),
                icon: const Icon(Icons.add_circle_outline_rounded),
                label: const Text('Create Tour'),
              ),
              FilledButton.icon(
                onPressed: () => context.goNamed(AppRoutes.searchTours.name),
                icon: const Icon(Icons.people_alt_rounded),
                label: const Text('Join Tour'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
