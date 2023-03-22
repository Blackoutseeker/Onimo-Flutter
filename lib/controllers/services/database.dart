import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';

import 'package:onimo/models/entities/message.dart';
import 'package:onimo/models/entities/session.dart';
import 'package:onimo/controllers/stores/session.dart';

class Database {
  static Database instance = Database();
  static final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  static Future<void> insertMessageIntoDatabase(
      String roomId, Message message) async {
    await _firebaseDatabase
        .ref('chat_rooms/$roomId/chat/${message.sendTimestamp}')
        .set(message.convertToDatabase());
  }

  static Future<void> connectUserToCurrentChat() async {
    final SessionStore store = GetIt.I.get<SessionStore>();
    final String? roomId = store.session.currentRoomId;
    if (roomId != null) {
      final String userId = store.session.userId;
      final RoomType roomType = store.session.currentRoomType;
      String usersReference = 'available_rooms/';

      if (roomType == RoomType.private) usersReference = 'chat_rooms/';
      usersReference += '$roomId/active_users';

      await _firebaseDatabase.ref(usersReference).update({
        userId: {
          'status': 'connected',
        }
      });
    }
  }

  static Future<void> disconnectUserFromChat() async {
    final SessionStore store = GetIt.I.get<SessionStore>();
    final String? roomId = store.session.currentRoomId;
    if (roomId == null) return;
    final String userId = store.session.userId;
    final RoomType roomType = store.session.currentRoomType;
    String userReference = 'available_rooms/';

    if (roomType == RoomType.private) userReference = 'chat_rooms/';
    userReference += '$roomId/active_users/$userId';

    await _firebaseDatabase.ref(userReference).remove();
  }
}
