import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/common_widgets/titled_section_card.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditTour extends StatelessWidget {
  const EditTour({super.key, required this.tourId});

  final String tourId;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ResponsiveCenter(
        maxContentWidth: 1200,
        child: Padding(
            padding: pagePadding,
            child: TitledSectionCard(
              title: 'Edit Tour',
              child: Consumer(
                builder: (context, ref, child) {
                  return AsyncValueWidget(
                    value: ref.watch(fetchTourProvider(tourId)),
                    data: (Tour? tour) {
                      return Placeholder();
                    },
                  );
                },
              ),
            )),
      ),
    );
  }
}

class EditTourContents extends StatelessWidget {
  const EditTourContents({
    super.key,
    required this.name,
    required this.description,
    required this.isPublic,
    required this.owner,
    required this.members,
    required this.draftDateTime,
    this.password,
  });

  final String name;
  final String description;
  final bool isPublic;
  final String owner;
  final List<String> members;
  final DateTime draftDateTime;
  final String? password;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
