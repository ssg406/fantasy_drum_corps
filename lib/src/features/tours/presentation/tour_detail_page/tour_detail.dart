import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/not_found.dart';
import 'package:fantasy_drum_corps/src/common_widgets/page_scaffold.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/presentation/tour_corps/tour_fantasy_corps.dart';
import 'package:fantasy_drum_corps/src/features/messaging/presentation/messaging_box.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/leaderboard/tour_leaderboard.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/tour_detail_page/basic_tour_details.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/tour_detail_page/detail_page_expansion_tile.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/tour_detail_page/tour_action_bar.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/tour_detail_page/tour_management.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/tour_detail_page/tour_members.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TourDetail extends ConsumerWidget {
  const TourDetail({Key? key, this.tourId}) : super(key: key);

  final String? tourId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return tourId == null
        ? const NotFound()
        : AsyncValueWidget(
            value: ref.watch(watchTourProvider(tourId ?? '')),
            data: (Tour? tour) {
              final currentUser = ref.watch(authRepositoryProvider).currentUser;
              return tour == null
                  ? const NotFound()
                  : TourDetailContents(tour: tour, user: currentUser!);
            },
          );
  }
}

class TourDetailContents extends ConsumerWidget {
  const TourDetailContents({Key? key, required this.tour, required this.user})
      : super(key: key);
  final Tour tour;
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageScaffolding(
      pageTitle: tour.name.toUpperCase(),
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.primary.withAlpha(10),
        child: Column(
          children: [
            Padding(
              padding: mobileCardPadding,
              child: TourActionBar(
                tour: tour,
                userId: user.uid,
              ),
            ),
            BasicTourDetails(tour: tour),
            DetailPageExpansionTile(
              title: 'Members',
              child: TourMembers(
                members: tour.members,
                owner: tour.owner,
                tourId: tour.id!,
                isOwner: user.uid == tour.owner,
              ),
            ),
            if (tour.members.contains(user.uid))
              DetailPageExpansionTile(
                title: 'Messaging',
                child: MessagingBox(userId: user.uid, tourId: tour.id!),
              ),
            if (tour.draftComplete)
              DetailPageExpansionTile(
                title: 'Leaderboard',
                child: TourLeaderboard(tourId: tour.id!),
              ),
            if (tour.draftComplete)
              DetailPageExpansionTile(
                title: 'Corps',
                child: FantasyCorpsList.showTourCorps(tourId: tour.id!),
              ),
            if (tour.owner == user.uid)
              DetailPageExpansionTile(
                title: 'Manage',
                child: TourManagement(
                  tour: tour,
                ),
              )
          ],
        ),
      ),
    );
  }
}
