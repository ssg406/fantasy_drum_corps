import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/not_found.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/common_widgets/titled_section_card.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/manage_tour/delete_tour.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/manage_tour/manage_draft.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/manage_tour/manage_members.dart';
import 'package:fantasy_drum_corps/src/utils/app_color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageTour extends ConsumerWidget {
  const ManageTour({Key? key, required this.tourId}) : super(key: key);

  final String tourId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(fetchTourProvider(tourId)),
      data: (Tour? tour) {
        return tour == null ? const NotFound() : ManageTourContents(tour: tour);
      },
    );
  }
}

class ManageTourContents extends StatelessWidget {
  const ManageTourContents({Key? key, required this.tour}) : super(key: key);

  final Tour tour;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ResponsiveCenter(
        maxContentWidth: 1200,
        child: Padding(
          padding: pagePadding,
          child: TitledSectionCard(
            title: 'Manage Your Tour',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Tour: ',
                    style: Theme.of(context).textTheme.titleLarge,
                    children: [
                      TextSpan(
                        text: tour.name,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: AppColors.customGreen),
                      )
                    ],
                  ),
                ),
                gapH16,
                ManageMembers(
                  members: tour.members,
                  tourId: tour.id!,
                  owner: tour.owner,
                ),
                gapH32,
                ManageDraft(tourId: tour.id!, tour: tour),
                gapH32,
                DeleteTour(tour: tour),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
