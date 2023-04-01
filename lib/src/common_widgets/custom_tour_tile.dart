import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

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
    return SizedBox(
      width: 250,
      height: 250,
      child: ListTile(
        mouseCursor: SystemMouseCursors.click,
        onTap: () => context
            .pushNamed(AppRoutes.tourDetail.name, params: {'tid': tour.id!}),
        leading: Tooltip(
          message: tour.isPublic ? 'Public Tour' : 'Private Tour',
          child: tour.isPublic
              ? const FaIcon(FontAwesomeIcons.lock)
              : const FaIcon(FontAwesomeIcons.lockOpen),
        ),
        title: Text(
          tour.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: user != null ? _getSubtitle(user.uid == tour.owner) : null,
        trailing: const FaIcon(FontAwesomeIcons.ellipsis),
      ),
    );
  }
}
