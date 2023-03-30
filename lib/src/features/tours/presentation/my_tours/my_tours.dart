import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/custom_tour_tile.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/common_widgets/titled_section_card.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class MyTours extends ConsumerStatefulWidget {
  const MyTours({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _MyToursState();
}

class _MyToursState extends ConsumerState<MyTours> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ResponsiveCenter(
        maxContentWidth: 1200,
        child: Padding(
          padding: pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AsyncValueWidget(
                value: ref.watch(watchOwnedToursProvider),
                data: (List<Tour> tours) => MyToursContents(
                  myTours: tours,
                  title: 'My Tours',
                ),
              ),
              gapH16,
              AsyncValueWidget(
                value: ref.watch(watchJoinedToursProvider),
                data: (List<Tour> tours) => MyToursContents(
                  myTours: tours,
                  title: 'Joined Tours',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyToursContents extends ConsumerStatefulWidget {
  const MyToursContents({
    Key? key,
    required this.myTours,
    required this.title,
  }) : super(key: key);

  final List<Tour> myTours;
  final String title;

  @override
  ConsumerState createState() => _MyToursContentsState();
}

class _MyToursContentsState extends ConsumerState<MyToursContents> {
  @override
  Widget build(BuildContext context) {
    return TitledSectionCard(
        title: widget.title,
        child: SizedBox(
          height: widget.myTours.isEmpty
              ? MediaQuery.of(context).size.height * 0.2
              : MediaQuery.of(context).size.height * 0.4,
          child: widget.myTours.isEmpty
              ? const EmptyTourContainerActions()
              : ListView(
                  children: [
                    for (final tour in widget.myTours)
                      CustomTourTile(
                        tour: tour,
                      )
                  ],
                ),
        ));
  }
}

class EmptyTourContainerActions extends StatelessWidget {
  const EmptyTourContainerActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No Tours yet!',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          gapH16,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                icon: const FaIcon(FontAwesomeIcons.circlePlus),
                label: const Text('Create Tour'),
                onPressed: () => context.goNamed(AppRoutes.createTour.name),
              ),
              gapW8,
              TextButton.icon(
                icon: const FaIcon(FontAwesomeIcons.userGroup),
                label: const Text('Join Tour'),
                onPressed: () => context.goNamed(AppRoutes.searchTours.name),
              )
            ],
          )
        ],
      ),
    );
  }
}
