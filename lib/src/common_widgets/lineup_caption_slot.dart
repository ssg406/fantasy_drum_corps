import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class LineupCaptionSlot extends StatelessWidget {
  const LineupCaptionSlot({super.key, this.pick, required this.caption});

  final Caption caption;
  final DrumCorps? pick;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _getLeading(context),
      title: Text(
        caption.fullName,
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: ResponsiveBreakpoints.of(context).smallerThan(TABLET)
            ? TextAlign.center
            : null,
      ),
      subtitle: pick == null
          ? Text('OPEN SLOT',
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: ResponsiveBreakpoints.of(context).smallerThan(TABLET)
                  ? TextAlign.center
                  : null)
          : Text(pick!.fullName,
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: ResponsiveBreakpoints.of(context).smallerThan(TABLET)
                  ? TextAlign.center
                  : null),
    );
  }

  Widget? _getLeading(BuildContext context) {
    String pathPrefix = kDebugMode ? '' : 'assets/';

    if (ResponsiveBreakpoints.of(context).smallerThan(TABLET)) {
      return null;
    }
    return pick != null
        ? Image.asset(
            '${pathPrefix}corps_logos/${pick!.name}.png',
            height: 25,
          )
        : const Icon(
            Icons.circle_outlined,
            size: 25,
          );
  }
}
