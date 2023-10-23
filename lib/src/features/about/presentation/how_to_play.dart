import 'package:fantasy_drum_corps/src/common_widgets/common_buttons.dart';
import 'package:fantasy_drum_corps/src/common_widgets/page_scaffold.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class HowToPlay extends StatelessWidget {
  const HowToPlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageScaffolding(
      pageTitle: 'How to Play',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Complete Your Profile',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          gapH16,
          Text(
            'After you create an account, set a display '
            'name and verify your email. Your display name will help '
            'other players more easily identify you in the tour '
            'and during the draft.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          gapH24,
          Text(
            'Create or Join a Tour',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          gapH16,
          Text(
            'A tour consists of anywhere between 1 and 22 players and can be '
            'created at any point in the season. Players can create private '
            'tours accessible only to those with a password, or public tours that'
            ' can be found by anyone with an account. If you would like to '
            'join a tour, use the menu to go to the \'Join Tour\' page. Tour '
            'owners can delete tours, but this will also delete all associated '
            'fantasy corps in the tour. ',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          gapH16,
          Align(
            alignment: Alignment.bottomRight,
            child: PrimaryTextButton(
                onPressed: () => context.pushNamed(AppRoutes.searchTours.name),
                labelText: 'Join a Tour',
                icon: Icons.group_add),
          ),
          gapH24,
          Text(
            'Get Ready to Draft',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          gapH16,
          Text(
            'When creating a tour, the tour owner selects the draft date and time. '
            'Any changes to this date should '
            'be communicated on the tour message board so all players know '
            'when to login. When the tour owner and members are ready, '
            'login and click \'Go to Draft\' on the tour detail '
            'page. This will create a room for this tour\'s draft and '
            'start accepting new players. Each player can see who is in the '
            'room, but only the tour owner will be able to start the draft. '
            'When the tour owner is satisfied with the players in attendance, '
            'they click \'Start Draft\', beginning a five second count down.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          gapH24,
          Text(
            'Draft Your Fantasy Corps',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          gapH16,
          Text(
            'Once the draft has started, you will be notified when it is your '
            'turn to pick. Choose a caption from the left and click \'Draft\''
            ' when it is your turn. A particular corps can only appear '
            'in your lineup once, so choose wisely. Each turn lasts 45 '
            'seconds. If time runs out, you will be assigned a caption randomly '
            'from the list of available choices. When your fantasy corps lineup '
            'on the right is full, you will be automatically directed to finalize '
            'your corps with a name, show title, and repertoire (if you choose).',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          gapH24,
          Text(
            'Missed the Draft?',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          gapH16,
          Text(
            'If you happen to miss your tour\'s draft, we still have you covered. '
            'Any tour member who did not participate in the initial draft '
            'can return to the draft page where they will be presented with the opportunity '
            'to create a random lineup from the picks left over from the main draft. '
            'These picks are available on a first come, first serve basis. '
            'Random lineups can be created at any point in the season so long '
            'as picks still remain in the pool.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          gapH24,
          Text(
            'The Leaderboard',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          gapH16,
          Text(
            'Your fantasy corps will have a score immediately after you create it. At '
            'the beginning of the season, scores are based on DCI scores '
            'from the beginning of the 2022 or 2019 season. Each time a corps performs in the '
            '2023 season, lineup scores are updated. The leaderboard always '
            'shows the most updated total scores for each fantasy corps in a'
            ' tour. Scores are calculated using the same method as DCI.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          gapH24,
          Text(
            'How we Play',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          gapH16,
          Text(
            'There are several ways to communicate with other users on the site, '
            'such as creating tour names, message boards, and fantasy corps '
            'names and descriptions. Remember to keep all content appropriate'
            ' for all ages. Be respectful of all other users at all times. '
            'Disrespectful behavior or content of any kind will not be '
            'tolerated. Please report any concerns to us immediately.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          gapH16,
          Align(
            alignment: Alignment.bottomRight,
            child: PrimaryTextButton(
              onPressed: () {
                final Uri emailUri = Uri(
                  scheme: 'mailto',
                  path: 'help@fantasydrumcorps.com',
                  query: encodeQueryParameters(<String, String>{
                    'subject': 'Reporting concerns about FantasyDrumCorps',
                  }),
                );
                launchUrl(emailUri);
              },
              labelText: 'Contact Us',
              icon: Icons.mail_outline_outlined,
            ),
          )
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
