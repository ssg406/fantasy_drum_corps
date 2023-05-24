import 'package:fantasy_drum_corps/src/features/admin/data/message_repository.dart';
import 'package:fantasy_drum_corps/src/features/admin/domain/message.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_messaging_controller.g.dart';

@riverpod
class AdminMessagingController extends _$AdminMessagingController {
  @override
  FutureOr<void> build() {}

  Future<void> addMessage(AdminMessage message) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() =>
        ref.read(messageRepositoryProvider).addMessage(message));
  }

  Future<void> deleteMessage(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() =>
        ref.read(messageRepositoryProvider).deleteMessage(id));
  }
}
