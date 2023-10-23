import 'package:fantasy_drum_corps/src/common_widgets/common_tour_tile.dart';
import 'package:fantasy_drum_corps/src/common_widgets/titled_icon_card.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/utils/datetime_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardTourCard extends StatelessWidget {
  const DashboardTourCard({Key? key, required this.tours}) : super(key: key);

  final List<Tour> tours;

  // Show next draft, quick links to tours
  @override
  Widget build(BuildContext context) {
    return TitledIconCard(
      iconData: FontAwesomeIcons.users,
      title: 'Tours Quick Access',
      child: Column(
        children: [
          for (final tour in tours) CommonTourTile(tour: tour),
        ],
      ),
    );
  }

  String _getDraftDateText(DateTime draftDateTime, bool draftComplete) {
    if (draftDateTime.isBefore(DateTime.now())) {
      return draftComplete ? 'Draft Complete' : 'Draft Pending';
    } else {
      final formattedDate = DateTimeUtils.formattedDate(draftDateTime);
      return 'Drafting on $formattedDate';
    }
  }
}
