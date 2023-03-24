import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/back_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/common_widgets/titled_section_card.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/tour_detail_page/draft_date_time.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/tour_detail_page/draft_slots.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/tour_detail_page/tour_description.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/tour_detail_page/tour_members.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/tour_detail_page/tour_visibility.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TourDetail extends ConsumerWidget {
  const TourDetail({Key? key, required this.tourId}) : super(key: key);

  final String tourId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(tourStreamProvider(tourId)),
      data: (Tour tour) {
        final currentUser = ref.watch(authRepositoryProvider).currentUser;
        return TourDetailContents(tour: tour, user: currentUser!);
      },
    );
  }
}

class TourDetailContents extends StatelessWidget {
  const TourDetailContents({Key? key, required this.tour, required this.user})
      : super(key: key);
  final Tour tour;
  final User user;

  @override
  Widget build(BuildContext context) {
    final name = tour.name;
    final description = tour.description;
    final isPublic = tour.isPublic;
    final slots = tour.slotsAvailable;
    final draftDateTime = tour.draftDateTime;
    final members = tour.members;

    return SingleChildScrollView(
      child: ResponsiveCenter(
        child: Padding(
          padding: pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitledSectionCard(
                title: name,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TourVisibility(isPublic: isPublic),
                    gapH24,
                    TourDescription(description: description),
                    gapH24,
                    DraftSlots(slots: slots),
                    gapH24,
                    TourMembers(members: members),
                    gapH24,
                    DraftDateTime(draftDateTime: draftDateTime),
                    gapH24,
                    const Divider(thickness: 0.5),
                    gapH24,
                    _getButtonBar(context),
                  ],
                ),
              ),
              gapH16,
              const CustomBackButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getButtonBar(BuildContext context) {
    return ButtonBar(
      children: [
        if (tour.owner != user.uid && !tour.members.contains(user.uid))
          TextButton.icon(
            icon: const Icon(Icons.add),
            onPressed: () => debugPrint('join tour'),
            label: const Text('Jour Tour'),
          ),
        if (tour.owner == user.uid)
          TextButton.icon(
            icon: const Icon(Icons.edit),
            onPressed: () => debugPrint('edit tour'),
            label: const Text('Edit Tour'),
          ),
        if (tour.members.contains(user.uid))
          TextButton.icon(
            icon: const Icon(Icons.play_circle_outline_outlined),
            onPressed: () => context
                .goNamed(AppRoutes.draft.name, params: {'tid': tour.id!}),
            label: const Text('Go to Draft'),
          ),
        if (tour.members.contains(user.uid) && tour.owner != user.uid)
          TextButton.icon(
            icon: const Icon(Icons.remove),
            onPressed: () => debugPrint('leave tour'),
            label: const Text('Leave Tour'),
          )
      ],
    );
  }
}
