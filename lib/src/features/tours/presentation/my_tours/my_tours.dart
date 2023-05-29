import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/page_scaffold.dart';
import 'package:fantasy_drum_corps/src/common_widgets/tour_search_tile.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class MyTours extends ConsumerWidget {
  const MyTours({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(watchJoinedToursProvider),
      data: (List<Tour> tours) => MyToursContents(myTours: tours),
    );
  }
}

class MyToursContents extends StatelessWidget {
  const MyToursContents({
    Key? key,
    required this.myTours,
  }) : super(key: key);

  final List<Tour> myTours;

  @override
  Widget build(BuildContext context) {
    return PageScaffolding(
      pageTitle: 'My Tours',
      child: SizedBox(
          height: 400,
          child: myTours.isEmpty
              ? const EmptyTourContainerActions()
              : _getListView()),
    );
  }

  Widget _getListView() {
    return ListView(
      children: [
        for (final tour in myTours) TourSearchTile(tour: tour),
      ],
    );
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
