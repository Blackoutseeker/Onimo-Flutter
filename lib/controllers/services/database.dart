import 'package:firebase_database/firebase_database.dart';

import 'package:onimo/models/entities/message.dart';

class Database {
  static Database instance = Database();
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  Future<void> insertMessageIntoDatabase(String roomId, Message message) async {
    await _firebaseDatabase
        .ref('chat_rooms/$roomId/chat/${message.sendTimestamp}')
        .set(message.convertToDatabase());
  }
}
