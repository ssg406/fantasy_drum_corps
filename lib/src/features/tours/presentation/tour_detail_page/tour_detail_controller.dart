import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../application/tour_corps_service.dart';
import '../../data/tour_repository.dart';

part 'tour_detail_controller.g.dart';

@riverpod
class TourDetailController extends _$TourDetailController {
  @override
  FutureOr<void> build() async {}

  Future<void> removeMember(
      {required String playerId, required String tourId}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref
        .read(toursRepositoryProvider)
        .removePlayerFromTour(tourId: tourId, playerId: playerId));
  }

  Future<void> deleteTour({required String tourId}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(tourCorpsServiceProvider).deleteTour(tourId));
  }

  Future<void> resetDraft(String tourId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(tourCorpsServiceProvider).resetTourDraft(tourId));
  }

  Future<void> leaveTour(String tourId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () async => ref.read(removeSelfFromTourProvider(tourId)));
  }

  Future<void> joinTour(String tourId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () async => ref.read(addSelfToTourProvider(tourId)));
  }
}
