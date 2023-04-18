import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:round_icon/round_icon.dart';

class TourSearchTile extends StatelessWidget {
  const TourSearchTile({Key? key, required this.tour}) : super(key: key);
  final Tour tour;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      isThreeLine: true,
      onTap: () => context
          .pushNamed(AppRoutes.tourDetail.name, params: {'tid': tour.id!}),
      leading: Tooltip(
        message: tour.isPublic ? 'Public Tour' : 'Private Tour',
        child: RoundIcon(
          size: 30.0,
          padding: 13.0,
          icon:
              tour.isPublic ? FontAwesomeIcons.lockOpen : FontAwesomeIcons.lock,
          backgroundColor: theme.colorScheme.tertiary,
          iconColor: theme.colorScheme.onTertiary,
        ),
      ),
      title: Text(tour.name),
      subtitle:
          Text('${tour.description}\n${tour.slotsAvailable} slots available'),
      trailing: Column(
        children: [
          IconButton(
            onPressed: () => context.pushNamed(AppRoutes.tourDetail.name,
                params: {'tid': tour.id!}),
            icon: const FaIcon(FontAwesomeIcons.ellipsis),
          ),
        ],
      ),
    );
  }
}
