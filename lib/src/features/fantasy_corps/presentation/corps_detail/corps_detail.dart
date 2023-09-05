import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/labeled_flex_row.dart';
import 'package:fantasy_drum_corps/src/common_widgets/not_found.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/data/fantasy_corps_repository.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:fantasy_drum_corps/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

import '../../../../common_widgets/lineup_caption_slot.dart';
import '../../../../common_widgets/page_scaffold.dart';
import '../../../../constants/app_sizes.dart';

/// WHERE YOU LEFT OFF
/// corpsScore need to be added back to the server because the current format
/// doesn't match
/// then test updating scores
/// continue formatting corps detail page

class CorpsDetail extends ConsumerWidget {
  const CorpsDetail({Key? key, this.fantasyCorpsId}) : super(key: key);
  final String? fantasyCorpsId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return fantasyCorpsId == null
        ? const NotFound()
        : AsyncValueWidget(
            value: ref.watch(watchFantasyCorpsProvider(fantasyCorpsId!)),
            data: (FantasyCorps? corps) {
              if (corps == null) {
                return const NotFound();
              }

              final lineup = corps.lineup;

              return PageScaffolding(
                showImage: false,
                pageTitle: corps.name,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DETAILS',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    gapH12,
                    const Divider(thickness: 0.5),
                    gapH24,
                    LabeledFlexRow(
                        label: 'Show Title',
                        item: Text(corps.showTitle ?? 'Untitled')),
                    gapH8,
                    LabeledFlexRow(
                        label: 'Repertoire',
                        item: Text(corps.repertoire ?? 'Not Set')),
                    gapH16,
                    TextButton.icon(
                      icon: const Icon(Icons.edit),
                      onPressed: () => context.pushNamed(
                          AppRoutes.editCorps.name,
                          extra: corps,
                          pathParameters: {'cid': corps.fantasyCorpsId!}),
                      label: const Text('Edit Details'),
                    ),
                    gapH24,
                    Text(
                      'LINEUP',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    gapH12,
                    const Divider(thickness: 0.5),
                    gapH24,
                    GridView.count(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      crossAxisCount:
                          ResponsiveBreakpoints.of(context).largerThan(TABLET)
                              ? 4
                              : 2,
                      childAspectRatio: 2,
                      children: [
                        for (final caption in lineup!.keys)
                          LineupCaptionSlot(
                              pick: lineup[caption], caption: caption)
                      ],
                    ),
                  ],
                ),
              );
            });
  }
}
