import 'dart:async';

import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TourDetailController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> joinTour(String tourId) async {
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() => ref.read(addPlayerToTourProvider(tourId)));
  }
}
