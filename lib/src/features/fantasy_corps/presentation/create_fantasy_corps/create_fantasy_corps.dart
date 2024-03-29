import 'package:fantasy_drum_corps/src/common_widgets/not_found.dart';
import 'package:fantasy_drum_corps/src/common_widgets/page_scaffold.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/admin/application/score_service.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/presentation/create_fantasy_corps/create_fantasy_corps_controller.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/presentation/create_fantasy_corps/fantasy_corps_validators.dart';
import 'package:fantasy_drum_corps/src/routing/app_routes.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widgets/common_buttons.dart';

class CreateFantasyCorps extends StatelessWidget {
  const CreateFantasyCorps({
    super.key,
    this.fantasyCorps,
    this.isEditing = false,
  });

  final FantasyCorps? fantasyCorps;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    return fantasyCorps == null
        ? const NotFound()
        : CreateFantasyCorpsContents(
            corps: fantasyCorps!,
            isEditing: isEditing,
          );
  }
}

class CreateFantasyCorpsContents extends ConsumerStatefulWidget {
  const CreateFantasyCorpsContents(
      {Key? key, required this.corps, required this.isEditing})
      : super(key: key);
  final FantasyCorps corps;
  final bool isEditing;

  @override
  ConsumerState createState() => _CreateFantasyCorpsContentsState();
}

class _CreateFantasyCorpsContentsState
    extends ConsumerState<CreateFantasyCorpsContents>
    with FantasyCorpsValidators {
  final _formKey = GlobalKey<FormState>();
  late FantasyCorps _fantasyCorps;
  late bool _isEditing;
  String? _corpsName;
  String? _showTitle;
  String? _repertoire;
  final _focusNode = FocusScopeNode();

  @override
  void initState() {
    super.initState();
    _fantasyCorps = widget.corps;
    _isEditing = widget.isEditing;
    if (_isEditing) {
      _corpsName = _fantasyCorps.name;
      _showTitle = _fantasyCorps.showTitle;
      _repertoire = _fantasyCorps.repertoire;
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(createFantasyCorpsControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(createFantasyCorpsControllerProvider);

    return PageScaffolding(
      pageTitle: _isEditing
          ? 'Edit Your Fantasy Corps'
          : 'Complete Your Fantasy Corps',
      onBackPressed: () => context.goNamed(AppRoutes.myCorps.name),
      child: FocusScope(
        node: _focusNode,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: cardPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                gapH16,
                TextFormField(
                  initialValue: _corpsName,
                  onChanged: (value) => _corpsName = value,
                  validator: validateCorpsName,
                  decoration: const InputDecoration(
                    labelText: 'Fantasy Corps Name',
                    hintText: 'Crimson Devils',
                  ),
                  onEditingComplete: () => _focusNode.nextFocus(),
                ),
                gapH32,
                TextFormField(
                  initialValue: _showTitle,
                  onChanged: (value) => _showTitle = value,
                  validator: validateShowTitleAndRepertoire,
                  decoration: const InputDecoration(
                    labelText: 'Show Title',
                    hintText: 'Backseat Driver',
                  ),
                  onEditingComplete: () => _focusNode.nextFocus(),
                ),
                gapH32,
                TextFormField(
                  initialValue: _repertoire,
                  onChanged: (value) => _repertoire = value,
                  validator: validateShowTitleAndRepertoire,
                  decoration: const InputDecoration(
                    labelText: 'Repertoire',
                    hintText:
                        'Carnival of Venice by Niccolo Paganini\nHands and Feet by Michel Camilo\nTank! by Yoko Kanno',
                  ),
                  maxLines: 4,
                  onEditingComplete: _submitForm,
                ),
                gapH32,
                Center(
                  child: PrimaryActionButton(
                    onPressed: _submitForm,
                    labelText: _isEditing ? 'UPDATE' : 'FINISH',
                    isLoading: state.isLoading,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _saveFantasyCorps();
    }
  }

  Future<void> _saveFantasyCorps() async {
    final controller = ref.read(createFantasyCorpsControllerProvider.notifier);
    LineupScore lineupScore = await ref
        .read(scoreServiceProvider)
        .getCurrentScore(_fantasyCorps.lineup!);
    final newCorps = _fantasyCorps.copyWith(
        name: _corpsName,
        showTitle: _showTitle,
        repertoire: _repertoire,
        lineupScore: lineupScore);
    await controller.addFantasyCorps(newCorps, isUpdating: _isEditing);
    if (mounted) {
      context.goNamed(AppRoutes.dashboard.name);
    }
  }
}
