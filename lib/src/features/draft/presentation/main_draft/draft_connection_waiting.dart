import 'package:fantasy_drum_corps/src/common_widgets/page_scaffold.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class DraftConnectionWaiting extends StatelessWidget {
  const DraftConnectionWaiting({Key? key, this.onBackPressed})
      : super(key: key);

  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return PageScaffolding(
      pageTitle: 'Draft',
      child: Column(
        children: [
          Text('Waiting for response from server...',
              style: Theme.of(context).textTheme.titleMedium),
          gapH16,
          const LinearProgressIndicator(),
        ],
      ),
    );
  }
}
