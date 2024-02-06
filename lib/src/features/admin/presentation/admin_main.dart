import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/common_buttons.dart';
import 'package:fantasy_drum_corps/src/common_widgets/page_scaffold.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/admin/data/message_repository.dart';
import 'package:fantasy_drum_corps/src/features/admin/data/score_repository.dart';
import 'package:fantasy_drum_corps/src/features/admin/domain/corps_score.dart';
import 'package:fantasy_drum_corps/src/features/admin/domain/message.dart';
import 'package:fantasy_drum_corps/src/features/admin/presentation/admin_messaging_controller.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:fantasy_drum_corps/src/routing/app_routes.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:fantasy_drum_corps/src/utils/datetime_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class AdminMain extends StatelessWidget {
  const AdminMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageScaffolding(
      pageTitle: 'Admin Dashboard',
      child: Column(
        children: [
          ScoresCard(),
          gapH24,
          Divider(thickness: 1.0),
          gapH24,
          NewMessageForm(),
          gapH24,
          Divider(thickness: 1.0),
          gapH24,
          MessagesCard(),
        ],
      ),
    );
  }
}

class ScoresCard extends ConsumerWidget {
  const ScoresCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(watchAllCorpsScoreProvider),
      data: (List<CorpsScore> corpsScores) {
        corpsScores.sort((a, b) => a.corps.name.compareTo(b.corps.name));
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Update Drum Corps Scores',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            gapH16,
            corpsScores.isEmpty
                ? Center(
                    child: Text(
                      'No Scores',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  )
                : ScoresList(scoresList: corpsScores),
          ],
        );
      },
    );
  }
}

class ScoresList extends StatelessWidget {
  const ScoresList({Key? key, required this.scoresList}) : super(key: key);
  final List<CorpsScore> scoresList;

  @override
  Widget build(BuildContext context) {
    scoresList.sort((a, b) => a.lastUpdate.compareTo(b.lastUpdate));
    return SizedBox(
      height: 400,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          for (final score in scoresList)
            ListTile(
              title: Text(
                score.corps.fullName,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                  'Last updated ${DateTimeUtils.formattedDate(score.lastUpdate)}'),
              trailing: const FaIcon(FontAwesomeIcons.ellipsis),
              onTap: () =>
                  context.pushNamed(AppRoutes.adminAddScore.name, extra: score),
            )
        ],
      ),
    );
  }
}

class MessagesCard extends ConsumerWidget {
  const MessagesCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(watchAllMessagesProvider),
      data: (List<AdminMessage> messages) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Existing Messages',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            gapH16,
            messages.isEmpty
                ? Center(
                    child: Text(
                      'No Messages',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  )
                : MessagesList(messages: messages),
          ],
        );
      },
    );
  }
}

class NewMessageForm extends ConsumerWidget {
  const NewMessageForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final textController = TextEditingController();
    ref.listen<AsyncValue>(adminMessagingControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(adminMessagingControllerProvider);
    final formKey = GlobalKey<FormState>();
    final node = FocusScopeNode();
    return FocusScope(
      node: node,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add New Message',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            gapH16,
            TextFormField(
              controller: titleController,
              validator: validateText,
              onEditingComplete: () => node.nextFocus(),
              decoration: const InputDecoration(
                  labelText: 'Message Title',
                  hintText: 'New scores up on 6/30!'),
            ),
            gapH16,
            TextFormField(
              controller: textController,
              validator: validateText,
              onEditingComplete: () => node.nextFocus(),
              maxLines: 3,
              decoration: const InputDecoration(
                  labelText: 'Message Contents',
                  hintText:
                      'New scores added for The Cadets, Blue Knights, and Phantom Regiment from their show in Atlanta!'),
            ),
            gapH16,
            Center(
              child: PrimaryActionButton(
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) return;
                    final message = AdminMessage(
                        title: titleController.text,
                        text: textController.text,
                        date: DateTime.now());
                    final controller =
                        ref.read(adminMessagingControllerProvider.notifier);
                    await controller.addMessage(message);
                    titleController.clear();
                    textController.clear();
                  },
                  labelText: 'Submit Message',
                  isLoading: state.isLoading),
            )
          ],
        ),
      ),
    );
  }

  String? validateText(String? input) {
    if (input == null) {
      return 'Enter text';
    }
    return input.isEmpty ? 'Enter text' : null;
  }
}

class MessagesList extends ConsumerWidget {
  const MessagesList({Key? key, required this.messages}) : super(key: key);
  final List<AdminMessage> messages;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 400,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          for (final message in messages)
            ListTile(
              title: Text(
                message.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                  '${message.text}\nPosted ${DateTimeUtils.formattedDate(message.date)}'),
              trailing: IconButton(
                icon: const FaIcon(FontAwesomeIcons.trash),
                onPressed: () async {
                  final controller =
                      ref.read(adminMessagingControllerProvider.notifier);
                  controller.deleteMessage(message.id!);
                },
              ),
            )
        ],
      ),
    );
  }
}
