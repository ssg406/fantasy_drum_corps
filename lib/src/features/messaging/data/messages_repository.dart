import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasy_drum_corps/src/features/messaging/domain/tour_message.dart';
import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'messages_repository.g.dart';

class MessagesRepository {
  const MessagesRepository(this.db);

  final FirebaseFirestore db;

  String messagePath(String id) => 'tourMessages/$id';

  String get messagesPath => 'tourMessages';

  Future<void> addMessage(TourMessage message) =>
      db.collection(messagesPath).add(message.toJson());

  Future<void> deleteMessage(String id) async {
    final messageRef = db.doc(messagePath(id));
    await messageRef.delete();
  }

  Stream<List<TourMessage>> watchTourMessages(String tourId) {
    return db
        .collection(messagesPath)
        .withConverter(
          fromFirestore: (snapshot, _) =>
              TourMessage.fromJson(snapshot.data()!, snapshot.id),
          toFirestore: (tourMessage, _) => tourMessage.toJson(),
        )
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => doc.data())
            .where((tourMessage) => tourMessage.tourId == tourId)
            .toList());
  }
}

@riverpod
MessagesRepository messagesRepository(MessagesRepositoryRef ref) =>
    MessagesRepository(ref.watch(firebaseFirestoreProvider));

@riverpod
Stream<List<TourMessage>> watchTourMessages(
        WatchTourMessagesRef ref, String tourId) =>
    ref.watch(messagesRepositoryProvider).watchTourMessages(tourId);
