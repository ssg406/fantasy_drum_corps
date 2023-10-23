import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/labeled_flex_row.dart';
import 'package:fantasy_drum_corps/src/common_widgets/not_found.dart';
import 'package:fantasy_drum_corps/src/common_widgets/page_scaffold.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/messaging/presentation/messaging_box.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/tour_detail_page/tour_detail_button_bar.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/tour_detail_page/tour_detail_controller.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/tour_detail_page/tour_members.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/tour_detail_page/tour_owner_widget.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

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

class TourDetailContents extends ConsumerWidget {
  const TourDetailContents({Key? key, required this.tour, required this.user})
      : super(key: key);
  final Tour tour;
  final User user;

  String get name => tour.name;

  String get description => tour.description;

  bool get isPublic => tour.isPublic;

  int get slots => tour.slotsAvailable;

  DateTime get draftDateTime => tour.draftDateTime;

  List<String> get members => tour.members;

  String get tourId => tour.id!;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(tourDetailControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
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
            crossAxisAlignment: CrossAxisAlignment.center,
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
          TourDetailButtonBar(tour: tour, userId: user.uid),
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
}
