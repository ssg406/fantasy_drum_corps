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

class MessagingBox extends ConsumerWidget {
  const MessagingBox({Key? key, required this.userId, required this.tourId})
      : super(key: key);

  final String userId;
  final String tourId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(messagingBoxControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(messagingBoxControllerProvider);
    final textController = TextEditingController();
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
                  controller: textController,
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
                onPressed: () async {
                  final controller =
                      ref.read(messagingBoxControllerProvider.notifier);
                  final displayName = await ref
                      .read(playerServiceProvider)
                      .fetchDisplayName(userId);
                  final message = TourMessage(
                      user: displayName ?? '',
                      userId: userId,
                      tourId: tourId,
                      message: textController.text,
                      dateTime: DateTime.now());
                  controller.submitMessage(message);
                },
              )
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
              data: (List<TourMessage> messages) => messages.isEmpty
                  ? const Center(child: Text('No Messages'))
                  : ListView(
                      children: [
                        for (final message in messages)
                          MessageTile(
                            message: message.message,
                            date: message.dateTime,
                            displayName: message.user,
                            isOwnMessage: message.userId == userId,
                          )
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class MessageTile extends StatelessWidget {
  const MessageTile(
      {Key? key,
      required this.message,
      required this.date,
      required this.displayName,
      this.isOwnMessage = false})
      : super(key: key);
  final String message;
  final DateTime date;
  final String displayName;
  final bool isOwnMessage;

  @override
  Widget build(BuildContext context) {
    final textAlign = isOwnMessage ? TextAlign.right : TextAlign.left;
    final formattedDate = DateTimeUtils.shortFormattedDate(date);
    return ListTile(
      leading: isOwnMessage ? null : const Icon(Icons.message_rounded),
      title: Text(
        'This is a new message',
        textAlign: textAlign,
      ),
      subtitle: Text(
        '@$displayName at $formattedDate',
        textAlign: textAlign,
      ),
      trailing: isOwnMessage ? const Icon(Icons.message_rounded) : null,
    );
  }
}
