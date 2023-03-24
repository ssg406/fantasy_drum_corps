import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/details_card/details_card.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/email_card/email_card.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/password_card/password_card.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/sponsored_corps_card/sponsored_corps_card.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
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
