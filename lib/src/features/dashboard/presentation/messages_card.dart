import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/admin/data/message_repository.dart';
import 'package:fantasy_drum_corps/src/features/admin/domain/message.dart';
import 'package:fantasy_drum_corps/src/utils/app_color_schemes.dart';
import 'package:fantasy_drum_corps/src/utils/datetime_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardMessages extends ConsumerWidget {
  const DashboardMessages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: cardPadding,
        child: Column(
          children: [
            Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.message,
                  color: AppColors.customBlue,
                ),
                gapW16,
                Text('Messages from Fantasy Drum Corps',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            gapH16,
            AsyncValueWidget(
              value: ref.watch(watchAllMessagesProvider),
              data: (List<AdminMessage> messages) =>
                  AllMessageList(messages: messages),
            ),
          ],
        ),
      ),
    );
  }
}

class AllMessageList extends StatelessWidget {
  const AllMessageList({Key? key, required this.messages}) : super(key: key);
  final List<AdminMessage> messages;

  @override
  Widget build(BuildContext context) {
    messages.sort((a, b) => b.date.compareTo(a.date));
    return SizedBox(
      height: 300,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          for (final message in messages)
            ListTile(
              leading: const FaIcon(
                FontAwesomeIcons.asterisk,
                color: AppColors.customBlue,
              ),
              title: Text(
                '${message.title} - ${DateTimeUtils.formattedDate(message.date)}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(
                message.text,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 20.0),
              ),
              isThreeLine: true,
            )
        ],
      ),
    );
  }
}
