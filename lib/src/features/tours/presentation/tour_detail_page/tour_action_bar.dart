import 'package:fantasy_drum_corps/src/common_widgets/common_buttons.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/tour_detail_page/start_draft_button.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/tour_detail_page/tour_detail_controller.dart';
import 'package:fantasy_drum_corps/src/utils/alert_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TourActionBar extends ConsumerStatefulWidget {
  const TourActionBar({super.key, required this.tour, required this.userId});

  final Tour tour;
  final String userId;

  @override
  ConsumerState<TourActionBar> createState() => _TourActionBarState();
}

class _TourActionBarState extends ConsumerState<TourActionBar> {
  final _passwordTextController = TextEditingController();

  bool get isMember => widget.tour.members.contains(widget.userId);

  bool get isOwner => widget.tour.owner == widget.userId;

  String get userId => widget.userId;

  String get tourId => widget.tour.id!;

  Tour get tour => widget.tour;

  @override
  Widget build(BuildContext context) {
    return OverflowBar(
      alignment: MainAxisAlignment.end,
      children: [
        if (isMember && !isOwner)
          PrimaryTextButton(
            onPressed: _handleLeaveTour,
            labelText: 'Leave',
            icon: Icons.remove_circle_outline_outlined,
            isDestructive: true,
          ),
        if (!isMember)
          PrimaryActionButton(
            onPressed: _handleJoinTour,
            labelText: 'Join',
            icon: Icons.add_circle_outline_outlined,
          ),
        if (isMember)
          DraftButton(
              tourId: tourId,
              draftComplete: tour.draftComplete,
              isOwner: isOwner,
              playerId: userId),
      ],
    );
  }

  void _handleJoinTour() {
    if (tour.isPublic) {
      ref.read(tourDetailControllerProvider.notifier).joinTour(tourId);
      return;
    }
    _showPasswordDialog();
  }

  Future<void> _handleLeaveTour() async {
    final confirmLeave = await showAlertDialog(
        context: context,
        title: 'Are you sure you want to leave?',
        defaultActionText: 'Leave',
        cancelActionText: 'Cancel');
    if (confirmLeave ?? false) {
      ref.read(tourDetailControllerProvider.notifier).leaveTour(tourId);
    }
  }

  Future<void> _showPasswordDialog() async => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Password'),
          content: TextField(
            controller: _passwordTextController,
            decoration:
                const InputDecoration(hintText: 'Enter private tour password'),
          ),
          actions: [
            TextButton(
                onPressed: () => context.pop(), child: const Text('Cancel')),
            TextButton(
              onPressed: () => _joinPrivateTour(),
              child: const Text('Join'),
            )
          ],
        );
      });

  void _joinPrivateTour() {
    final enteredPassword = _passwordTextController.text;
    print('entered password: $enteredPassword');
    print('tour passsword: ${tour.password}');
    if (tour.password != enteredPassword) {
      showAlertDialog(context: context, title: 'Incorrect Password');
      return;
    }
    ref.read(tourDetailControllerProvider.notifier).joinTour(tourId);
  }
}
