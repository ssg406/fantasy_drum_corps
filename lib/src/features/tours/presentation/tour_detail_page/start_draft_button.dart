import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/app_routes.dart';

class DraftButton extends StatefulWidget {
  const DraftButton(
      {Key? key,
      required this.tourId,
      required this.draftComplete,
      required this.isOwner})
      : super(key: key);

  final String tourId;
  final bool draftComplete;
  final bool isOwner;

  @override
  State<DraftButton> createState() => _DraftButtonState();
}

class _DraftButtonState extends State<DraftButton> {
  String get tourId => widget.tourId;

  bool get draftComplete => widget.draftComplete;

  bool get isOwner => widget.isOwner;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      icon: const Icon(Icons.play_circle_outline_outlined),
      onPressed: () {
        _navigateToDraftLobby(context);
      },
      label: const Text('Go to Draft'),
    );
  }

  void _navigateToDraftLobby(BuildContext context) => context
      .pushNamed(AppRoutes.draftLobby.name, pathParameters: {'tid': tourId});
}
