import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/custom_tour_tile.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/common_widgets/titled_section_card.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
              TitledSectionCard(
                title: 'Your Tours',
                child: AsyncValueWidget(
                  value: ref.watch(ownedToursStreamProvider),
                  data: (List<Tour> tours) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: ListView(
                        children: [
                          for (final tour in tours)
                            CustomTourTile(
                              tour: tour,
                            )
                        ],
                      ),
                    );
                  },
                ),
              ),
              gapH16,
              TitledSectionCard(
                title: 'Joined Tours',
                child: AsyncValueWidget(
                  value: ref.watch(
                      ownedToursStreamProvider), // joinedToursStreamProvider,
                  data: (List<Tour> tours) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: ListView(
                        children: [
                          for (final tour in tours)
                            CustomTourTile(
                              tour: tour,
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
