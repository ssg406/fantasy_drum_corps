import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/not_found.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/draft_controller.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class DraftLobby extends ConsumerWidget {
  const DraftLobby({
    super.key,
    this.tourId,
  });

  final String? tourId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authRepositoryProvider).currentUser;
    return tourId == null
        ? const NotFound()
        : AsyncValueWidget(
            value: ref.watch(watchTourProvider(tourId!)),
            data: (Tour? tour) {
              return tour == null
                  ? const NotFound()
                  : DraftLobbyContents(
                      tour: tour,
                      userId: user?.uid,
                    );
            },
          );
  }
}

class DraftLobbyContents extends StatelessWidget {
  const DraftLobbyContents({super.key, required this.tour, this.userId});

  final Tour tour;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: ResponsiveCenter(
        maxContentWidth: 1200,
        child: Padding(
          padding: pagePadding,
          child: Card(
            child: Padding(
              padding: cardPadding,
              child: Column(
                children: [
                  Text(
                    'Tour Draft',
                    style: theme.textTheme.titleLarge,
                  ),
                  gapH8,
                  const Divider(),
                  gapH8,
                  if (tour.draftActive)
                    ElevatedButton.icon(
                      icon: const FaIcon(
                        FontAwesomeIcons.trophy,
                      ),
                      onPressed: () => context.pushNamed(AppRoutes.draft.name,
                          params: {'tid': tour.id!}),
                      label: const Text('GO TO DRAFT'),
                    ),
                  gapH16,
                  if (!tour.draftActive && tour.owner == userId)
                    Consumer(
                      builder: (context, ref, child) {
                        return ElevatedButton.icon(
                          icon: const FaIcon(FontAwesomeIcons.clock),
                          onPressed: () {
                            final controller =
                                ref.read(draftControllerProvider.notifier);
                            controller.startDraft(tourId: tour.id!);
                          },
                          label: const Text('START DRAFT COUNTDOWN'),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
