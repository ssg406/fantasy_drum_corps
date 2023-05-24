import 'package:fantasy_drum_corps/src/common_widgets/not_found.dart';
import 'package:fantasy_drum_corps/src/common_widgets/page_scaffold.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:flutter/material.dart';

/// WHERE YOU LEFT OFF
/// corpsScore need to be added back to the server because the current format
/// doesn't match
/// then test updating scores
/// continue formatting corps detail page

class CorpsDetail extends StatelessWidget {
  const CorpsDetail({Key? key, this.fantasyCorps}) : super(key: key);
  final FantasyCorps? fantasyCorps;

  @override
  Widget build(BuildContext context) {
    return fantasyCorps == null
        ? const NotFound()
        : PageScaffolding(
            showImage: false,
            pageTitle: fantasyCorps!.name,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LINEUP',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                gapH12,
                const Divider(thickness: 0.5),
                gapH12,
                for (final lineupKey in fantasyCorps!.lineup!.keys)
                  LineupRow(
                      caption: lineupKey,
                      corps: fantasyCorps!.lineup![lineupKey]!)
              ],
            ),
          );
  }
}

class LineupRow extends StatelessWidget {
  const LineupRow({Key? key, required this.caption, required this.corps})
      : super(key: key);

  final Caption caption;
  final DrumCorps corps;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          caption.fullName,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white54),
        ),
        gapW24,
        Text(
          corps.fullName,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.primary),
        )
      ],
    );
  }
}
