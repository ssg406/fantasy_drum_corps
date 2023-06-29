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
          // Text(
          //   'The idea for Fantasy Drum Corps was developed by Kenny Dahill and '
          //       'Ben Jones. Both have been drum c',
          //   style: theme.textTheme.bodyLarge,
          // ),
          // gapH16,
          Text(
            'CONTACT',
            style: theme.textTheme.titleLarge,
          ),
          gapH16,
          Text(
            'Reach us at the email below for assistance with Fantasy Drum Corps or with other questions.',
            style: theme.textTheme.bodyLarge,
          ),
          gapH8,
          FilledButton(
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
          gapH24,
          Text(
            'LICENSE',
            style: theme.textTheme.titleLarge,
          ),
          gapH16,
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
          FilledButton(
            onPressed: () async {
              await launchUrl(Uri.parse('https://www.gnu.org/licenses/'));
            },
            child: const Text('GNU Licenses'),
          ),
          gapH24,
          Text(
            'SOURCE',
            style: theme.textTheme.titleLarge,
          ),
          gapH16,
          Text(
            'Fantasy Drum Corps was created using Flutter and compiled for Web, '
            'Android, and iOS. The draft server was created using Socket.io '
            'and and NodeJS and is written in Typescript. The application '
            ' and server source are available on GitHub and the author '
            'encourages feedback and collaboration.',
            style: theme.textTheme.bodyLarge,
          ),
          gapH8,
          ButtonBar(alignment: MainAxisAlignment.start, children: [
            FilledButton(
              onPressed: () async {
                await launchUrl(
                    Uri.parse('http://github.com/ssg406/fantasy_drum_corps'));
              },
              child: const Text('Fantasy Drum Corps App'),
            ),
            FilledButton(
              onPressed: () async {
                await launchUrl(Uri.parse(
                    'http://github.com/ssg406/fantasy_drum_corps_server'));
              },
              child: const Text('Fantasy Drum Corps Server'),
            ),
          ]),
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
