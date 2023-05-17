import 'package:fantasy_drum_corps/src/features/fantasy_corps/data/fantasy_corps_repository.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_fantasy_corps_controller.g.dart';

@riverpod
class CreateFantasyCorpsController extends _$CreateFantasyCorpsController {
  @override
  FutureOr<void> build() {}

  Future<void> addFantasyCorps(FantasyCorps fantasyCorps,
      {bool isUpdating = false}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      if (isUpdating) {
        return ref
            .read(fantasyCorpsRepositoryProvider)
            .updateFantasyCorps(fantasyCorps);
      } else {
        return ref
            .read(fantasyCorpsRepositoryProvider)
            .addFantasyCorps(fantasyCorps);
      }
    });
  }
}
