import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/labeled_flex_row.dart';
import 'package:fantasy_drum_corps/src/common_widgets/not_found.dart';
import 'package:fantasy_drum_corps/src/common_widgets/page_scaffold.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/messaging/presentation/messaging_box.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/tour_detail_page/tour_members.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/tour_detail_page/tour_owner_widget.dart';
import 'package:fantasy_drum_corps/src/routing/app_routes.dart';
import 'package:fantasy_drum_corps/src/utils/alert_dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

import '../../../draft/presentation/main_draft/draft_lobby.dart';

class TourDetail extends ConsumerWidget {
  const TourDetail({Key? key, this.tourId}) : super(key: key);

  final String? tourId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return tourId == null
        ? const NotFound()
        : AsyncValueWidget(
            value: ref.watch(watchTourProvider(tourId!)),
            data: (Tour? tour) {
              final currentUser = ref.watch(authRepositoryProvider).currentUser;
              return tour == null
                  ? const NotFound()
                  : TourDetailContents(tour: tour, user: currentUser!);
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

    return PageScaffolding(
      showImage: false,
      pageTitle: 'Tour Detail',
      child: Column(
        children: [
          Flex(
            direction: ResponsiveBreakpoints.of(context).screenWidth > 1024
                ? Axis.horizontal
                : Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabeledFlexRow(
                    label: 'Tour Name',
                    item: Text(
                      name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  gapH24,
                  TourOwner(ownerId: tour.owner),
                  gapH24,
                  LabeledFlexRow(
                    label: 'Visibility',
                    item: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Icon(
                            isPublic ? Icons.lock_open : Icons.lock,
                            color:
                                isPublic ? Colors.green[300] : Colors.red[300],
                          ),
                        ),
                        gapW8,
                        Text(
                          isPublic ? 'Public' : 'Private',
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ],
                    ),
                  ),
                  gapH24,
                  LabeledFlexRow(
                    label: 'Tour Description',
                    item: Text(
                      description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  gapH24,
                  LabeledFlexRow(
                    label: 'Slots Available',
                    item: Text(_getSlotsText(slots),
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                  gapH24,
                  TourMembers(members: members),
                  gapH24,
                  LabeledFlexRow(
                    label: 'Draft Time',
                    item: tour.draftComplete
                        ? Text(
                            'Draft Complete',
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        : Text(
                            DateFormat.yMMMMd('en_US')
                                .add_jm()
                                .format(draftDateTime),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                  ),
                  gapH24,
                  const Divider(thickness: 0.5),
                  gapH24,
                ],
              ),
              if (tour.members.contains(user.uid))
                MessagingBox(
                  tourId: tour.id!,
                  userId: user.uid,
                ),
            ],
          ),
          gapH32,
          _getButtonBar(context),
        ],
      ),
    );
  }

  String _getSlotsText(int openSlots) {
    if (openSlots == 0) {
      return 'Tour Full';
    }
    return '$openSlots ${openSlots == 1 ? 'slot' : 'slots'}';
  }

  Widget _getButtonBar(BuildContext context) {
    return ButtonBar(
      children: [
        if (tour.owner != user.uid &&
            !tour.members.contains(user.uid) &&
            tour.slotsAvailable > 0)
          TextButton.icon(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.pushNamed(AppRoutes.joinTour.name,
                  params: {'tid': tour.id!}, extra: tour);
            },
            label: const Text('Join Tour'),
          ),
        if (tour.owner == user.uid)
          TextButton.icon(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.pushNamed(AppRoutes.manageTour.name,
                  params: {'tid': tour.id!}, extra: tour);
            },
            label: const Text('ManageTour'),
          ),
        if (tour.owner == user.uid)
          TextButton.icon(
            icon: const Icon(Icons.edit),
            onPressed: () {
              context.pushNamed(AppRoutes.editTour.name,
                  params: {'tid': tour.id!}, extra: tour);
            },
            label: const Text('Edit Tour'),
          ),
        if (tour.members.contains(user.uid) && tour.owner != user.uid)
          TextButton.icon(
            icon: const Icon(Icons.remove),
            onPressed: () => context.pushNamed(AppRoutes.leaveTour.name,
                params: {'tid': tour.id!}, extra: tour),
            label: const Text('Leave Tour'),
          ),
        if (tour.members.contains(user.uid))
          FilledButton.icon(
            icon: const Icon(Icons.play_circle_outline_outlined),
            onPressed: () {
              _startDraft().then((isReady) {
                if (isReady) {
                  Future.delayed(const Duration(seconds: 2)).then((_) => context
                      .pushNamed(AppRoutes.draftLobby.name,
                          params: {'tid': tour.id!}));
                  // context.pushNamed(AppRoutes.draftLobby.name,
                  //     params: {'tid': tour.id!});
                } else {
                  showAlertDialog(
                      context: context,
                      title: 'Draft Error',
                      content:
                          'There was an error setting up the draft server. Try'
                          ' again later or contact us if the problem persists.');
                }
              });
            },
            label: const Text('Go to Draft'),
          ),
      ],
    );
  }

  Future<bool> _startDraft() async {
    final server = Uri.http(rootServerUrl, '/createNamespace');
    debugPrint('Server URI is $server');
    final response = await http.patch(server, body: {'tourId': tour.id!});
    debugPrint(
        'Got response from server: ${response.body} with code ${response.statusCode}');
    return response.statusCode == 200;
  }
}
