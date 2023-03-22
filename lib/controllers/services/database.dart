import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';

import 'package:onimo/models/entities/message.dart';
import 'package:onimo/models/entities/session.dart';
import 'package:onimo/controllers/stores/session.dart';

class Database {
  static final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  static Future<void> insertMessageIntoDatabase(
      String roomId, Message message) async {
    await _firebaseDatabase
        .ref('chat_rooms/$roomId/chat/${message.sendTimestamp}')
        .set(message.convertToDatabase());
  }

  static String? _getUserReference() {
    final SessionStore store = GetIt.I.get<SessionStore>();
    final String? roomId = store.session.currentRoomId;
    if (roomId == null) return null;

    final String userId = store.session.userId;
    final RoomType roomType = store.session.currentRoomType;
    String userReference = 'available_rooms/';

    if (roomType == RoomType.private) userReference = 'chat_rooms/';
    userReference += '$roomId/active_users/$userId';
    return userReference;
  }

  static Future<void> connectUserToCurrentChat() async {
    final String? userReference = _getUserReference();
    if (userReference != null) {
      await _firebaseDatabase.ref(userReference).update({
        'status': 'connected',
      });
    }
  }

  static Future<void> disconnectUserFromChat() async {
    final String? userReference = _getUserReference();
    if (userReference != null) {
      await _firebaseDatabase.ref(userReference).remove();
    }
  }
}
