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
}
