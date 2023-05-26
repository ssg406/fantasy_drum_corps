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
    state = await AsyncValue.guard(() => _removeMember(playerId, tourId));
  }

  Future<void> _removeMember(String playerId, String tourId) {
    final repository = ref.read(toursRepositoryProvider);
    return repository.removePlayerFromTour(tourId: tourId, playerId: playerId);
  }

  Future<void> deleteTour({required String tourId}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _deleteTour(tourId));
  }

  Future<void> _deleteTour(String tourId) async =>
      ref.read(deleteTourProvider(tourId));

  Future<void> resetDraft(String tourId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _resetDraft(tourId));
  }

  Future<void> _resetDraft(String tourId) async {
    ref.read(tourCorpsServiceProvider).resetTourDraft(tourId);
  }
}
