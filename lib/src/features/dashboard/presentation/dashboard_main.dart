import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/dashboard/presentation/complete_profile_card.dart';
import 'package:fantasy_drum_corps/src/features/dashboard/presentation/dashboard_tour_card.dart';
import 'package:fantasy_drum_corps/src/features/dashboard/presentation/greeting_card.dart';
import 'package:fantasy_drum_corps/src/features/dashboard/presentation/new_member_card.dart';
import 'package:fantasy_drum_corps/src/features/dashboard/presentation/verify_email_card.dart';
import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          padding: pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                            gapH16,
                            if (player.displayName == null ||
                                player.selectedCorps == null)
                              const CompleteProfileCard()
                          ],
                        );
                },
              ),
              gapH16,
              if (user != null && !user.emailVerified)
                VerifyEmailCard(user: user),
              gapH16,
              AsyncValueWidget(
                showLoading: false,
                value: ref.watch(watchJoinedToursProvider),
                data: (List<Tour> tours) {
                  if (tours.isEmpty) {
                    return const NewMemberCard();
                  } else {
                    return DashboardTourCard(tours: tours);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
