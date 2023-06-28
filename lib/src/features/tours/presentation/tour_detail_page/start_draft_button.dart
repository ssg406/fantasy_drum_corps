import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import '../../../../routing/app_routes.dart';
import '../../../../utils/alert_dialogs.dart';
import '../../../draft/presentation/main_draft/draft_lobby.dart';

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

  bool _waitingForServer = false;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      icon: const Icon(Icons.play_circle_outline_outlined),
      onPressed: () {
        if (draftComplete || !isOwner) {
          _navigateToDraftLobby(context);
        } else {
          _requestDraftSetup().then((draftIsSetup) {
            if (!draftIsSetup) {
              showAlertDialog(
                  context: context,
                  title: 'Draft Setup Error',
                  content: 'There was an error setting up the draft '
                      'server. Try again in a few minutes or contact '
                      'us if the problem persists.');
              return;
            }
            setState(() => _waitingForServer = true);
            Future.delayed(const Duration(milliseconds: 1500)).then((_) {
              setState(() => _waitingForServer = false);
              _navigateToDraftLobby(context);
            });
          });
        }
      },
      label: _waitingForServer
          ? CircularProgressIndicator(
              color: Theme.of(context).colorScheme.onPrimary,
            )
          : const Text('Go to Draft'),
    );
  }

  void _navigateToDraftLobby(BuildContext context) =>
      context.pushNamed(AppRoutes.draftLobby.name, params: {'tid': tourId});

  Future<bool> _requestDraftSetup() async {
    final server = Uri.https(rootServerUrl, '/createNamespace');
    try {
      final response = await http.patch(server, body: {'tourId': tourId});
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
