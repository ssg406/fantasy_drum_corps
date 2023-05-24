import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasy_drum_corps/src/features/admin/domain/message.dart';
import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_repository.g.dart';

class MessageRepository {
  const MessageRepository(this.db);

  final FirebaseFirestore db;

  static String messagesPath = 'messages';

  Future<void> addMessage(AdminMessage message) =>
      db.collection(messagesPath).add(message.toJson());

  Future<void> deleteMessage(String id) async {
    final messageRef = db.doc('$messagesPath/$id');
    await messageRef.delete();
  }

  Stream<List<AdminMessage>> watchAllMessages() => db
      .collection(messagesPath)
      .withConverter(
        fromFirestore: (snapshot, _) =>
            AdminMessage.fromJson(snapshot.data()!, snapshot.id),
        toFirestore: (adminMessage, _) => adminMessage.toJson(),
      )
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
}

@riverpod
MessageRepository messageRepository(MessageRepositoryRef ref) =>
    MessageRepository(ref.watch(firebaseFirestoreProvider));

@riverpod
Stream<List<AdminMessage>> watchAllMessages(WatchAllMessagesRef ref) =>
    ref.watch(messageRepositoryProvider).watchAllMessages();
