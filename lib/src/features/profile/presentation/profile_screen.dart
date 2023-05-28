import 'package:fantasy_drum_corps/src/common_widgets/page_scaffold.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/delete_account_card.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/details_card/details_card.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/email_card/email_card.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/password_card/password_card.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/profile_screen_controller.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/sponsored_corps_card/sponsored_corps_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfile extends ConsumerWidget {
  const UserProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(profileScreenControllerProvider.notifier);
    final isGoogleAuth = controller.getIsOAuthAccount();
    return PageScaffolding(
      pageTitle: 'My Profile',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DetailsCard(),
          gapH24,
          const SponsoredCorpsCard(),
          gapH24,
          if (!isGoogleAuth) ...[
            const EmailCard(),
            gapH24,
            const PasswordCard(),
            gapH24
          ],
          const DeleteAccountCard(),
        ],
      ),
    );
  }
}
