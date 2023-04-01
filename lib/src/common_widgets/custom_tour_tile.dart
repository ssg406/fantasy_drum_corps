import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:round_icon/round_icon.dart';

class CustomTourTile extends ConsumerWidget {
  const CustomTourTile({Key? key, required this.tour}) : super(key: key);
  final Tour tour;

  Widget _getSubtitle(bool isOwner) {
    return Tooltip(
      message: isOwner ? 'You own this tour' : 'You\'re a member of this tour',
      child: Text(isOwner ? 'Owner' : 'Member'),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authRepositoryProvider).currentUser;
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: cardPadding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Tooltip(
                message: tour.isPublic ? 'Public Tour' : 'Private Tour',
                child: RoundIcon(
                    size: 30.0,
                    padding: 13.0,
                    icon: tour.isPublic
                        ? FontAwesomeIcons.lockOpen
                        : FontAwesomeIcons.lock,
                    backgroundColor: theme.colorScheme.tertiary,
                    iconColor: theme.colorScheme.onTertiary)),
            gapW16,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tour.name,
                  style: theme.textTheme.titleMedium!
                      .copyWith(color: theme.colorScheme.tertiary),
                ),
                gapH4,
                Text(tour.description),
                gapH4,
                if (user != null) _getSubtitle(user.uid == tour.owner),
                gapH4,
                Text('Available Slots: ${tour.slotsAvailable}'),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: () => context.pushNamed(AppRoutes.tourDetail.name,
                    params: {'tid': tour.id!}),
                icon: const FaIcon(FontAwesomeIcons.ellipsis),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
