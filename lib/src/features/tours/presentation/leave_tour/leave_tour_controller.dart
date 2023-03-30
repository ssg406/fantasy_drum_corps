import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'leave_tour_controller.g.dart';

@riverpod
class LeaveTourController extends _$LeaveTourController {
  @override
  FutureOr<void> build() {}

  Future<void> leaveTour(String tourId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _leaveTour(tourId));
  }

  Future<void> _leaveTour(String tourId) async {
    return ref.read(removeSelfFromTourProvider(tourId));
  }
}
