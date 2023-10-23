import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/dashboard/presentation/complete_profile_card.dart';
import 'package:fantasy_drum_corps/src/features/dashboard/presentation/dashboard_scores_card.dart';
import 'package:fantasy_drum_corps/src/features/dashboard/presentation/dashboard_tour_card.dart';
import 'package:fantasy_drum_corps/src/features/dashboard/presentation/greeting_card.dart';
import 'package:fantasy_drum_corps/src/features/dashboard/presentation/messages_card.dart';
import 'package:fantasy_drum_corps/src/features/dashboard/presentation/new_member_card.dart';
import 'package:fantasy_drum_corps/src/features/dashboard/presentation/verify_email_card.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/data/fantasy_corps_repository.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authRepositoryProvider).currentUser;
    return SingleChildScrollView(
      child: ResponsiveCenter(
        maxContentWidth: 1200.0,
        child: Padding(
          padding: ResponsiveBreakpoints.of(context).largerOrEqualTo(TABLET)
              ? pagePadding
              : mobilePagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CORPS HALL',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              gapH8,
              AsyncValueWidget(
                showLoading: false,
                value: ref.watch(playerStreamProvider),
                data: (Player? player) {
                  return player == null
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GreetingCard(displayName: player.displayName),
                            if (player.displayName == null ||
                                player.selectedCorps == null) ...[
                              gapW24,
                              Text(
                                'The Corps Hall is your dashboard to keep track of your tours, corps, messages and scores.',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              gapH16,
                              const CompleteProfileCard()
                            ]
                          ],
                        );
                },
              ),
              if (user != null && !user.emailVerified) ...[
                gapH24,
                VerifyEmailCard(user: user),
              ],
              AsyncValueWidget(
                showLoading: false,
                value: ref.watch(watchJoinedToursProvider),
                data: (List<Tour> tours) {
                  return Column(
                    children: [
                      gapH24,
                      tours.isEmpty
                          ? const NewMemberCard()
                          : DashboardTourCard(tours: tours),
                    ],
                  );
                },
              ),
              AsyncValueWidget(
                  value: ref.watch(watchUserFantasyCorpsProvider),
                  data: (List<FantasyCorps> corps) => corps.isEmpty
                      ? Container()
                      : Column(
                          children: [
                            gapH24,
                            DashboardScoresCard(fantasyCorps: corps)
                          ],
                        )),
              gapH24,
              const DashboardMessages(),
            ],
          ),
        ),
      ),
    );
  }
}
