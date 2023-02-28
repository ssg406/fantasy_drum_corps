import 'package:fantasy_drum_corps/src/common_widgets/logo_text.dart';
import 'package:fantasy_drum_corps/src/common_widgets/primary_text_button.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/onboarding/presentation/onboarding_controller.dart';
import 'package:fantasy_drum_corps/src/localization/string_hardcoded.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    return Container(
      color: Colors.grey[900],
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const LogoText(size: 50.0),
            gapH12,
            PrimaryTextButton(
                onPressed: state.isLoading
                    ? null
                    : () async {
                        await ref
                            .read(onboardingControllerProvider.notifier)
                            .completeOnboarding();
                        if (context.mounted) {
                          context.goNamed(AppRoutes.signIn.name);
                        }
                      },
                label: 'REGISTER'.hardcoded,
                isLoading: state.isLoading)
          ],
        ),
      ),
    );
  }
}
