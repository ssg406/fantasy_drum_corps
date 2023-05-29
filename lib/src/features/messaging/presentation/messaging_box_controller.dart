import 'package:fantasy_drum_corps/src/features/messaging/data/messages_repository.dart';
import 'package:fantasy_drum_corps/src/features/messaging/domain/tour_message.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'messaging_box_controller.g.dart';

@riverpod
class MessagingBoxController extends _$MessagingBoxController {
  @override
  FutureOr<void> build() {}

  Future<void> submitMessage(TourMessage message) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(messagesRepositoryProvider).addMessage(message));
  }

  Future<void> deleteMessage(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(messagesRepositoryProvider).deleteMessage(id));
  }
}
