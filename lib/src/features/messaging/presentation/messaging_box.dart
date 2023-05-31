import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/messaging/data/messages_repository.dart';
import 'package:fantasy_drum_corps/src/features/messaging/domain/tour_message.dart';
import 'package:fantasy_drum_corps/src/features/messaging/presentation/messaging_box_controller.dart';
import 'package:fantasy_drum_corps/src/features/players/application/player_service.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:fantasy_drum_corps/src/utils/datetime_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MessagingBox extends ConsumerStatefulWidget {
  const MessagingBox({Key? key, required this.userId, required this.tourId})
      : super(key: key);

  final String userId;
  final String tourId;

  @override
  ConsumerState<MessagingBox> createState() => _MessagingBoxState();
}

class _MessagingBoxState extends ConsumerState<MessagingBox> {
  String get userId => widget.userId;

  String get tourId => widget.tourId;
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(messagingBoxControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(messagingBoxControllerProvider);
    return Column(
      children: [
        Text(
          'Messaging',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        gapH16,
        SizedBox(
          width: 450,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  onEditingComplete: _submitMessage,
                  decoration: const InputDecoration(
                    hintText: 'Enter new message...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              gapW12,
              IconButton.filled(
                  icon: state.isLoading
                      ? const CircularProgressIndicator()
                      : const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: FaIcon(FontAwesomeIcons.paperPlane),
                        ),
                  onPressed: _submitMessage)
            ],
          ),
        ),
        gapH16,
        Card(
          child: SizedBox(
            width: 450,
            height: 400,
            child: AsyncValueWidget(
              value: ref.watch(watchTourMessagesProvider(tourId)),
              data: (List<TourMessage> messages) {
                messages.sort((a, b) => b.dateTime.compareTo(a.dateTime));
                return messages.isEmpty
                    ? const Center(child: Text('No Messages'))
                    : ListView.builder(
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) => MessageTile(
                          id: messages[index].id!,
                          message: messages[index].message,
                          date: messages[index].dateTime,
                          displayName: messages[index].user,
                          isOwnMessage: messages[index].userId == userId,
                          onDeleteMessage: _deleteMessage,
                        ),
                      );
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _deleteMessage(String id) async {
    final controller = ref.read(messagingBoxControllerProvider.notifier);
    await controller.deleteMessage(id);
  }

  Future<void> _submitMessage() async {
    if (_textController.text.isEmpty) return;
    final controller = ref.read(messagingBoxControllerProvider.notifier);
    final displayName =
        await ref.read(playerServiceProvider).fetchDisplayName(userId);
    final message = TourMessage(
        user: displayName ?? '',
        userId: userId,
        tourId: tourId,
        message: _textController.text,
        dateTime: DateTime.now());
    await controller.submitMessage(message);
  }
}

class MessageTile extends StatelessWidget {
  const MessageTile(
      {Key? key,
      required this.id,
      required this.message,
      required this.date,
      required this.displayName,
      this.isOwnMessage = false,
      required this.onDeleteMessage})
      : super(key: key);

  final String id;
  final String message;
  final DateTime date;
  final String displayName;
  final bool isOwnMessage;
  final void Function(String) onDeleteMessage;

  @override
  Widget build(BuildContext context) {
    final textAlign = isOwnMessage ? TextAlign.right : TextAlign.left;
    final formattedDate = DateTimeUtils.shortFormattedDate(date);
    return ListTile(
      leading: isOwnMessage
          ? null
          : PopupMenuButton(
              itemBuilder: popupMenuBuilder,
            ),
      title: Text(
        message,
        textAlign: textAlign,
      ),
      subtitle: Text(
        '@$displayName at $formattedDate',
        textAlign: textAlign,
      ),
      trailing: isOwnMessage
          ? PopupMenuButton(
              itemBuilder: popupMenuBuilder,
            )
          : null,
    );
  }

  List<PopupMenuEntry<dynamic>> popupMenuBuilder(BuildContext context) {
    return [
      PopupMenuItem(
        onTap: () => onDeleteMessage(id),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.delete_outline_rounded),
            Text('Delete Message'),
          ],
        ),
      ),
    ];
  }
}
