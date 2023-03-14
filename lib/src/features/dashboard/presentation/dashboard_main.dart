import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/primary_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
        value: ref.watch(userChangesProvider),
        data: (User? user) {
          return SingleChildScrollView(
            child: ResponsiveCenter(
              child: Padding(
                padding: pagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dashboard',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    gapH8,
                    Text(
                      'Hi, ${user?.displayName}! Welcome to Fantasy Corps.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    gapH32,
                    const NewMemberCard(),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class NewMemberCard extends StatelessWidget {
  const NewMemberCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thanks for joining Fantasy Corps! It looks like you have not created or joined a tour yet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            gapH16,
            const Text(
              'Create a new tour and invite others. Or, search for a public tour to join. You can aprticipate in as many tours as you like.',
            ),
            gapH16,
            ButtonBar(
              children: [
                PrimaryButton(
                  onSurface: true,
                  onPressed: () => context.goNamed(AppRoutes.createTour.name),
                  isLoading: false,
                  label: 'Create Tour',
                ),
                PrimaryButton(
                  onSurface: true,
                  onPressed: () => context.goNamed(AppRoutes.joinTour.name),
                  isLoading: false,
                  label: 'Join Tour',
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
