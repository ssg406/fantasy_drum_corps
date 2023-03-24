import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/common_widgets/titled_section_card.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TourDetail extends ConsumerWidget {
  const TourDetail({Key? key, required this.tourId}) : super(key: key);

  final String tourId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(tourStreamProvider(tourId)),
      data: (Tour? tour) {
        final currentUser = ref.watch(authRepositoryProvider).currentUser;
        return TourDetailContainer(tour: tour!, user: currentUser!);
      },
    );
  }
}

class TourDetailContainer extends StatelessWidget {
  const TourDetailContainer({Key? key, required this.tour, required this.user})
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
                title: 'Tour Detail',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Visibility',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    gapH16,
                    Row(
                      children: [
                        Icon(
                          isPublic ? Icons.lock_open : Icons.lock,
                          color: isPublic ? Colors.green[300] : Colors.red[300],
                        ),
                        gapW16,
                        Text(
                          isPublic ? 'Public' : 'Private',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: isPublic
                                      ? Colors.green[300]
                                      : Colors.red[300]),
                        )
                      ],
                    ),
                    gapH32,
                    Text(
                      'Tour Name',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    gapH8,
                    Text(
                      name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    gapH32,
                    Text(
                      'Tour Description',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    gapH8,
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    gapH32,
                    Text(
                      'Slots Available',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    gapH8,
                    Text(
                      _getSlotsText(slots),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: _getSlotsColor(slots)),
                    ),
                    gapH32,
                    Text(
                      'Members',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    gapH8,
                    Text(
                      members.join(', '),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    gapH32,
                    Text(
                      'Draft Date + Time',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    gapH8,
                    Text(
                      DateFormat.yMMMMd('en_US').add_jm().format(draftDateTime),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    gapH32,
                    const Divider(thickness: 0.5),
                    gapH24,
                    ButtonBar(
                      children: _getTourActions(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getSlotsText(int openSlots) {
    if (openSlots == 0) {
      return 'Tour Full';
    }
    return '$openSlots ${openSlots == 1 ? 'slot' : 'slots'}';
  }

  Color _getSlotsColor(int openSlots) {
    if (openSlots > 0) {
      return Colors.red[300]!;
    }
    return Colors.green[300]!;
  }

  List<Widget> _getTourActions(BuildContext context) {
    List<Widget> buttons = [
      TextButton.icon(
        icon: const Icon(Icons.arrow_back_outlined),
        onPressed: () => context.pop(),
        label: const Text('Back to Tours'),
      ),
    ];
    if (tour.owner != user.uid) {
      if (!tour.members.contains(user.uid)) {
        buttons.add(TextButton.icon(
          icon: const Icon(Icons.add),
          onPressed: () => debugPrint('join tour'),
          label: const Text('Jour Tour'),
        ));
      } else {
        buttons.add(TextButton.icon(
          icon: const Icon(Icons.play_circle_outline_outlined),
          onPressed: () =>
              context.goNamed(AppRoutes.draft.name, params: {'tid': tour.id!}),
          label: const Text('Go to Draft'),
        ));
        buttons.add(TextButton.icon(
          icon: const Icon(Icons.remove),
          onPressed: () => debugPrint('leave tour'),
          label: const Text('Leave Tour'),
        ));
      }
    } else {
      buttons.add(TextButton.icon(
        icon: const Icon(Icons.play_circle_outline_outlined),
        onPressed: () =>
            context.goNamed(AppRoutes.draft.name, params: {'tid': tour.id!}),
        label: const Text('Go to Draft'),
      ));
      buttons.add(TextButton.icon(
        icon: const Icon(Icons.edit),
        onPressed: () => debugPrint('edit tour'),
        label: const Text('Edit Tour'),
      ));
    }
    return buttons;
  }
}
