import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'draft_controller.g.dart';

@riverpod
class DraftController extends _$DraftController {
  @override
  FutureOr<void> build() {}

  Future<void> startDraft({required String tourId}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() =>
        ref.read(toursRepositoryProvider).setDraftActive(
            draftActive: true, tourId: tourId));
  }

}
