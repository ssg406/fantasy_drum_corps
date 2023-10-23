import 'package:fantasy_drum_corps/src/common_widgets/page_scaffold.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common_widgets/common_buttons.dart';

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
            'Contact',
            style: theme.textTheme.headlineSmall,
          ),
          gapH16,
          Text(
            'Reach us at the email below for assistance with Fantasy Drum Corps or with other questions.',
            style: theme.textTheme.bodyLarge,
          ),
          gapH8,
          Align(
            alignment: Alignment.bottomRight,
            child: PrimaryTextButton(
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
              labelText: 'Email Us',
              icon: Icons.email_outlined,
            ),
          ),
          gapH24,
          Text(
            'License',
            style: theme.textTheme.headlineSmall,
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
          Align(
            alignment: Alignment.bottomRight,
            child: PrimaryTextButton(
              onPressed: () async {
                await launchUrl(Uri.parse('https://www.gnu.org/licenses/'));
              },
              labelText: 'GNU Licenses',
              icon: FontAwesomeIcons.fileLines,
            ),
          ),
          gapH24,
          Text(
            'Source',
            style: theme.textTheme.headlineSmall,
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
          ButtonBar(children: [
            PrimaryTextButton(
              onPressed: () async {
                await launchUrl(
                    Uri.parse('https://github.com/ssg406/fantasy_drum_corps'));
              },
              labelText: 'Fantasy Drum Corps App',
              icon: FontAwesomeIcons.github,
            ),
            PrimaryTextButton(
              onPressed: () async {
                await launchUrl(Uri.parse(
                    'https://github.com/ssg406/fantasy_drum_corps_server'));
              },
              labelText: 'Fantasy Drum Corps Server',
              icon: FontAwesomeIcons.github,
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
