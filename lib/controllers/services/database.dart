import 'package:firebase_database/firebase_database.dart';

import 'package:onimo/models/entities/message.dart';

class Database {
  static Database instance = Database();
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  Future<List<Message>> getChatMessagesByRoomId(
    String roomId, {
    int limitToLast = 10,
  }) async {
    final List<Message> messages = [];

    final chat = await _firebaseDatabase
        .ref('chat_rooms/$roomId/chat')
        .limitToLast(limitToLast)
        .get();

    if (chat.exists) {
      final messagesFromDatabase = Map<String, dynamic>.from(chat.value as Map);
      messagesFromDatabase.forEach((_, message) {
        messages.add(Message.convertFromDatabase(message));
      });
      messages.sort((a, b) => b.sendTimestamp.compareTo(a.sendTimestamp));
    }

    return messages;
  }
}
