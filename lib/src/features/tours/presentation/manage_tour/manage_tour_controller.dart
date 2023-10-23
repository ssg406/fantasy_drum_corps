import 'package:fantasy_drum_corps/src/features/tours/application/tour_corps_service.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'manage_tour_controller.g.dart';

@riverpod
class ManageTourController extends _$ManageTourController {
  @override
  FutureOr<void> build() {}

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
}
