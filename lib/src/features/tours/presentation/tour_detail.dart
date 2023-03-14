import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/common_widgets/titled_section_card.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

// TODO tour detail page must link to draft page
// TODO tour detail page must have tour image upload

class TourDetail extends ConsumerStatefulWidget {
  const TourDetail({Key? key, required this.tourId, required this.tour})
      : super(key: key);
  final Tour tour;
  final String? tourId;

  @override
  ConsumerState<TourDetail> createState() => _TourDetailState();
}

class _TourDetailState extends ConsumerState<TourDetail> {
  @override
  Widget build(BuildContext context) {
    final name = widget.tour.name;
    final description = widget.tour.description;
    final isPublic = widget.tour.isPublic;
    final members = widget.tour.members;
    final draftDateTime = widget.tour.draftDateTime;

    return SingleChildScrollView(
      child: ResponsiveCenter(
        child: Padding(
          padding: pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitledSectionCard(
                title: 'Tour Detail',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Visibility',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    gapH16,
                    Row(
                      children: [
                        Icon(
                          isPublic ? Icons.lock_open : Icons.lock,
                          color: isPublic ? Colors.green[300] : Colors.red[300],
                        ),
                        gapW16,
                        Text(
                          isPublic ? 'Public' : 'Private',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.green[300]),
                        )
                      ],
                    ),
                    gapH32,
                    Text(
                      'Tour Name',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    gapH8,
                    Text(
                      name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    gapH32,
                    Text(
                      'Tour Description',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    gapH8,
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    gapH32,
                    Text(
                      'Slots Available',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    gapH8,
                    Text(
                      _getSlotsText(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: _getSlotsColor()),
                    ),
                    gapH32,
                    Text(
                      'Members',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    gapH8,
                    Text(
                      members.join(', '),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    gapH32,
                    Text(
                      'Draft Date + Time',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    gapH8,
                    Text(
                      DateFormat.yMMMMd('en_US').format(draftDateTime),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    gapH32,
                    const Divider(thickness: 0.5),
                    gapH24,
                    TextButton.icon(
                      icon: const Icon(Icons.arrow_back_outlined),
                      onPressed: () => context.pop(),
                      label: const Text('Back to Tours'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getSlotsText() {
    final openSlots = widget.tour.slotsAvailable;
    if (openSlots == 0) {
      return 'Tour Full';
    }
    return '$openSlots ${openSlots == 1 ? 'slot' : 'slots'}';
  }

  Color _getSlotsColor() {
    final openSlots = widget.tour.slotsAvailable;
    if (openSlots > 0) {
      return Colors.red[300]!;
    }
    return Colors.green[300]!;
  }
}
