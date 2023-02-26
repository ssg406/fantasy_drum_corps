import 'dart:async';
import 'package:fantasy_drum_corps/src/features/onboarding/data/onboarding_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> completeOnboarding() async {
    final onboardingRepository = ref.watch(onboardingRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => onboardingRepository.setOnboardingComplete());
  }
}

final onboardingControllerProvider =
    AutoDisposeAsyncNotifierProvider<OnboardingController, void>(
        OnboardingController.new);
