import 'package:fantasy_drum_corps/src/common_widgets/labelled_property.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/tour_detail_page/tour_owner_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BasicTourDetails extends StatelessWidget {
  const BasicTourDetails({super.key, required this.tour});

  final Tour tour;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      childrenPadding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.centerLeft,
      title: Text(
        'DETAILS',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      children: [
        TourOwner(ownerId: tour.owner),
        LabelledProperty(
            label: 'Visibility',
            value: tour.isPublic ? 'Public Tour' : 'Private Tour'),
        LabelledProperty(label: 'Description', value: tour.description),
        LabelledProperty(
            label: 'Slots Available',
            value: _getSlotsText(tour.slotsAvailable)),
        LabelledProperty(
          label: 'Draft Time',
          value: tour.draftComplete
              ? 'Draft Complete'
              : DateFormat.yMMMMd('en_US').add_jm().format(tour.draftDateTime),
        )
      ],
    );
  }

  String _getSlotsText(int openSlots) {
    if (openSlots == 0) {
      return 'Tour Full';
    }
    return '$openSlots ${openSlots == 1 ? 'slot' : 'slots'}';
  }

  Widget _getRichTextRow(String label, String value, BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$label: ',
        style: Theme.of(context).textTheme.bodyLarge,
        children: [
          TextSpan(
            text: value,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
