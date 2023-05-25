import 'package:fantasy_drum_corps/src/common_widgets/page_scaffold.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PageScaffolding(
      pageTitle: 'About Fantasy Corps',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'A short blurb about what fantasy corps is, how it started, and what is in store for the future',
            style: theme.textTheme.bodyLarge,
          ),
          gapH16,
          Text(
            'HOW IT WORKS',
            style: theme.textTheme.titleMedium!
                .copyWith(color: theme.colorScheme.primary),
          ),
          gapH8,
          Text(
            'A short blurb about the gameplay describing the process of joining or creating a tour, setting up a draft, drafting a lineup, and then watching the leaderboard.',
            style: theme.textTheme.bodyLarge,
          ),
          gapH16,
          Text(
            'CONTACT',
            style: theme.textTheme.titleMedium!
                .copyWith(color: theme.colorScheme.primary),
          ),
          Text(
            'Reach us at the email below for assistance with Fantasy Drum Corps or with other questions.',
            style: theme.textTheme.bodyLarge,
          ),
          gapH8,
          TextButton(
            onPressed: () {
              final Uri emailUri = Uri(
                scheme: 'mailto',
                path: 'help@fantasydrumcorps.com',
                query: encodeQueryParameters(<String, String>{
                  'subject': 'A question about Fantasy Drum Corps',
                }),
              );
              launchUrl(emailUri);
            },
            child: const Text('Email Us'),
          ),
          gapH16,
          Text(
            'LICENSE',
            style: theme.textTheme.titleMedium!
                .copyWith(color: theme.colorScheme.primary),
          ),
          gapH8,
          Text(
            'This program is free software: you can redistribute it and/or '
            'modify it under the terms of the GNU General Public License as '
            'published by the Free Software Foundation, either version 3 of '
            'the License, or (at your option) any later version.\n\nThis '
            'program is distributed in the hope that it will be useful, but '
            'WITHOUT ANY WARRANTY; without even the implied warranty of '
            'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the '
            'GNU General Public License for more details.',
            style: theme.textTheme.bodyLarge,
          ),
          gapH8,
          TextButton(
            onPressed: () async {
              await launchUrl(Uri.parse('https://www.gnu.org/licenses/'));
            },
            child: const Text('GNU Licenses'),
          ),
        ],
      ),
    );
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
