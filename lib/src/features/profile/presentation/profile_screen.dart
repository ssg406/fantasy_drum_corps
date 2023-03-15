import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/details_card/details_card.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/email_card/email_card.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/password_card/password_card.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/profile_screen_controller.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/sponsored_corps_card/sponsored_corps_card.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Profile screen used to view and adjust user details
class UserProfile extends ConsumerStatefulWidget {
  const UserProfile({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _UserProfileState();
}

class _UserProfileState extends ConsumerState<UserProfile> {
  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(profileScreenControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final user = ref.watch(authDatabaseProvider).currentUser;
    if (user == null) {
      return const CircularProgressIndicator();
    } else {
      return SingleChildScrollView(
        child: ResponsiveCenter(
          child: Padding(
            padding: pagePadding,
            child: Column(
              children: const [
                DetailsCard(),
                gapH24,
                SponsoredCorpsCard(),
                gapH24,
                EmailCard(),
                gapH24,
                PasswordCard(),
              ],
            ),
          ),
        ),
      );
    }
  }
}
