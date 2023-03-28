import 'dart:async';

import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tour_detail_controller.g.dart';

@riverpod
class TourDetailController extends _$TourDetailController {
  @override
  FutureOr<void> build() {}

  Future<void> joinTour(String tourId) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User cannot be null when joining a tour');
    }
    final repository = ref.read(toursRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => repository.addPlayerToTour(tourId: tourId, playerId: currentUser.uid));
  }
}
