import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'join_tour_controller.g.dart';

@riverpod
class JoinTourController extends _$JoinTourController {
  @override
  FutureOr<void> build() {}

  Future<void> joinTour({required String tourId}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _joinTour(tourId));
  }

  Future<void> _joinTour(String tourId) async {
    return ref.read(addSelfToTourProvider(tourId));
  }
}
