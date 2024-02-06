import 'package:fantasy_drum_corps/src/common_widgets/labelled_property.dart';
import 'package:fantasy_drum_corps/src/common_widgets/lineup_caption_slot.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:fantasy_drum_corps/src/features/players/application/player_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FantasyCorpsTile extends ConsumerWidget {
  const FantasyCorpsTile({super.key, required this.corps});

  final FantasyCorps corps;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.watch(playerServiceProvider).fetchDisplayName(corps.userId),
      initialData: '',
      builder: (context, snapshot) {
        final userName = snapshot.data ?? '';
        return ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          expandedAlignment: Alignment.centerLeft,
          childrenPadding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
          title: Text(
            '${corps.name} ${userName.isEmpty ? '' : 'by $userName'}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          children: [
            if (corps.showTitle != null)
              LabelledProperty(label: 'Show Title', value: corps.showTitle!),
            if (corps.repertoire != null)
              LabelledProperty(label: 'Repertoire', value: corps.repertoire!),
            if (corps.lineup != null)
              Wrap(
                children: [
                  for (final caption in corps.lineup!.keys)
                    LineupCaptionSlot(
                      caption: caption,
                      pick: corps.lineup![caption],
                    )
                ],
              )
          ],
        );
      },
    );
  }
}
