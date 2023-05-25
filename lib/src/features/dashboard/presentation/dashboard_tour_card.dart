import 'package:fantasy_drum_corps/src/common_widgets/titled_icon_card.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:fantasy_drum_corps/src/utils/app_color_schemes.dart';
import 'package:fantasy_drum_corps/src/utils/datetime_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class DashboardTourCard extends StatelessWidget {
  const DashboardTourCard({Key? key, required this.tours}) : super(key: key);

  final List<Tour> tours;

  // Show next draft, quick links to tours
  @override
  Widget build(BuildContext context) {
    return TitledIconCard(
      icon: const FaIcon(
        FontAwesomeIcons.users,
        color: AppColors.customBlue,
      ),
      title: 'Tours Quick Access',
      child: SizedBox(
        height: 150,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            for (final tour in tours)
              SizedBox(
                width: 200,
                height: 150,
                child: ListTile(
                  isThreeLine: true,
                  title: Text(
                    tour.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  subtitle: Text(
                    '${tour.description}\n${_getDraftDateText(tour.draftDateTime)}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                  onTap: () => context.pushNamed(AppRoutes.tourDetail.name,
                      params: {'tid': tour.id!}),
                ),
              )
          ],
        ),
      ),
    );
  }

  String _getDraftDateText(DateTime draftDateTime) {
    if (draftDateTime.isBefore(DateTime.now())) {
      return 'Draft Completed';
    } else {
      final formattedDate = DateTimeUtils.formattedDate(draftDateTime);
      return 'Drafting on $formattedDate';
    }
  }
}
