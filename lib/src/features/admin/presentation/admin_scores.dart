import 'package:fantasy_drum_corps/src/common_widgets/not_found.dart';
import 'package:fantasy_drum_corps/src/common_widgets/page_scaffold.dart';
import 'package:fantasy_drum_corps/src/common_widgets/primary_button.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/admin/domain/corps_score.dart';
import 'package:fantasy_drum_corps/src/features/admin/presentation/admin_scores_controller.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:fantasy_drum_corps/src/routing/app_routes.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AdminScores extends ConsumerStatefulWidget {
  const AdminScores({
    super.key,
    this.corpsScore,
  });

  final CorpsScore? corpsScore;

  @override
  ConsumerState<AdminScores> createState() => _AdminScoresState();
}

class _AdminScoresState extends ConsumerState<AdminScores> {
  final formKey = GlobalKey<FormState>();
  final ge1 = TextEditingController();
  final ge2 = TextEditingController();
  final visualProficiency = TextEditingController();
  final visualAnalysis = TextEditingController();
  final colorGuard = TextEditingController();
  final brass = TextEditingController();
  final musicAnalysis = TextEditingController();
  final percussion = TextEditingController();
  final _node = FocusScopeNode();

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(adminScoresControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(adminScoresControllerProvider);
    return widget.corpsScore == null
        ? const NotFound()
        : PageScaffolding(
            pageTitle: 'Enter Scores',
            showImage: false,
            child: FocusScope(
              node: _node,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Text(
                      'Enter Scores for ${widget.corpsScore!.corps.fullName}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    gapH16,
                    TextFormField(
                      controller: ge1,
                      decoration: const InputDecoration(
                        labelText: 'General Effect 1',
                      ),
                      validator: scoreValidator,
                      onEditingComplete: () => _node.nextFocus(),
                      autocorrect: false,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      keyboardAppearance: Brightness.light,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    gapH16,
                    TextFormField(
                      controller: ge2,
                      decoration: const InputDecoration(
                        labelText: 'General Effect 2',
                      ),
                      validator: scoreValidator,
                      onEditingComplete: () => _node.nextFocus(),
                      autocorrect: false,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      keyboardAppearance: Brightness.light,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    gapH16,
                    TextFormField(
                      controller: visualProficiency,
                      decoration: const InputDecoration(
                        labelText: 'Visual Proficiency',
                      ),
                      validator: scoreValidator,
                      onEditingComplete: () => _node.nextFocus(),
                      autocorrect: false,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      keyboardAppearance: Brightness.light,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    gapH16,
                    TextFormField(
                      controller: visualAnalysis,
                      decoration: const InputDecoration(
                        labelText: 'Visual Analysis',
                      ),
                      validator: scoreValidator,
                      onEditingComplete: () => _node.nextFocus(),
                      autocorrect: false,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      keyboardAppearance: Brightness.light,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    gapH16,
                    TextFormField(
                      controller: colorGuard,
                      decoration: const InputDecoration(
                        labelText: 'Color Guard',
                      ),
                      validator: scoreValidator,
                      onEditingComplete: () => _node.nextFocus(),
                      autocorrect: false,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      keyboardAppearance: Brightness.light,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    gapH16,
                    TextFormField(
                      controller: brass,
                      decoration: const InputDecoration(
                        labelText: 'Brass',
                      ),
                      validator: scoreValidator,
                      onEditingComplete: () => _node.nextFocus(),
                      autocorrect: false,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      keyboardAppearance: Brightness.light,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    gapH16,
                    TextFormField(
                      controller: musicAnalysis,
                      decoration: const InputDecoration(
                        labelText: 'Music Analysis',
                      ),
                      validator: scoreValidator,
                      onEditingComplete: () => _node.nextFocus(),
                      autocorrect: false,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      keyboardAppearance: Brightness.light,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    gapH16,
                    TextFormField(
                      controller: percussion,
                      decoration: const InputDecoration(
                        labelText: 'Percussion',
                      ),
                      validator: scoreValidator,
                      onEditingComplete: () => _submitForm(),
                      autocorrect: false,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      keyboardAppearance: Brightness.light,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    gapH32,
                    PrimaryButton(
                        onPressed: _submitForm,
                        label: 'Submit Scores',
                        isLoading: state.isLoading)
                  ],
                ),
              ),
            ),
          );
  }

  Future<void> _submitForm() async {
    if (!formKey.currentState!.validate()) return;
    final controller = ref.read(adminScoresControllerProvider.notifier);
    final updatedScore = widget.corpsScore!.copyWith(
      scores: getLineupScore(),
      lastUpdate: DateTime.now(),
    );
    await controller.updateScores(updatedScore);
    if (mounted) context.goNamed(AppRoutes.adminMain.name);
  }

  LineupScore getLineupScore() => {
        Caption.percussion: double.parse(percussion.text),
        Caption.musicAnalysis: double.parse(musicAnalysis.text),
        Caption.colorGuard: double.parse(colorGuard.text),
        Caption.visualAnalysis: double.parse(visualAnalysis.text),
        Caption.visualProficiency: double.parse(visualAnalysis.text),
        Caption.brass: double.parse(brass.text),
        Caption.ge1: double.parse(ge1.text),
        Caption.ge2: double.parse(ge2.text),
      };

  String? scoreValidator(String? input) {
    if (input == null) {
      return 'Enter a score';
    } else {
      if (input.isEmpty) {
        return 'Enter a score';
      }
      try {
        double.parse(input);
      } on FormatException {
        return 'Enter a valid floating point number';
      }
    }
    return null;
  }
}
