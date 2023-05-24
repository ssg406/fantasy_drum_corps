import 'package:fantasy_drum_corps/src/common_widgets/page_scaffold.dart';
import 'package:fantasy_drum_corps/src/common_widgets/primary_button.dart';
import 'package:fantasy_drum_corps/src/features/admin/domain/corps_score.dart';
import 'package:fantasy_drum_corps/src/features/admin/presentation/admin_scores_controller.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestPage extends ConsumerWidget {
  const TestPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageScaffolding(
      pageTitle: 'Testing',
      showImage: false,
      child: Column(
        children: [
          PrimaryButton(
            isLoading: false,
            label: 'Add Bae Scores',
            onPressed: () {
              final controller =
                  ref.read(adminScoresControllerProvider.notifier);
              final scores = <Caption, double>{};
              for (final caption in Caption.values) {
                scores.addAll({caption: 0});
              }
              for (final corps in DrumCorps.values) {
                final corpsScore = CorpsScore(
                    corps: corps, scores: scores, lastUpdate: DateTime.now());
                controller.addSCore(corpsScore);
              }
            },
          )
        ],
      ),
    );
  }
}
