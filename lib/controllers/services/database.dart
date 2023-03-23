import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';

import 'package:onimo/models/entities/message.dart';
import 'package:onimo/models/entities/session.dart';
import 'package:onimo/controllers/stores/session.dart';
import 'package:onimo/utils/utils.dart';
import 'package:onimo/views/screens/chat.dart';

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

  static Future<int> _getAvailableRoomsLength() async {
    final DataSnapshot availableRooms =
        await _firebaseDatabase.ref('available_rooms').get();
    if (availableRooms.value == null) return 0;
    return (availableRooms.value as Map).length;
  }

  static void _showWarning(BuildContext context) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'A quantidade de salas públicas chegou em seu limite. Não é possível criar mais salas.',
        ),
        duration: Duration(seconds: 8),
      ),
    );
  }

  static void _navigateToNewChatRoom(
    BuildContext context,
    String roomName,
  ) async {
    await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => ChatScreen(
          roomName: roomName,
          initialUsersLength: 1,
        ),
      ),
      (route) => false,
    );
  }

  static Future<void> insertPublicRoomIntoDatabase(BuildContext context) async {
    final int availableRoomsLength = await _getAvailableRoomsLength();
    if (availableRoomsLength >= 10) {
      if (context.mounted) _showWarning(context);
      return;
    }

    final String roomId = Utils.generateRandomId(length: 12);
    final int roomUnit = availableRoomsLength + 1;
    final String roomName = 'Sala $roomUnit';
    final SessionStore store = GetIt.I.get<SessionStore>();

    await _firebaseDatabase.ref('available_rooms/$roomId').update({
      'id': roomId,
      'name': roomName,
      'active_users': {
        store.session.userId: {
          'status': 'connected',
        },
      },
    });

    if (context.mounted) {
      store.updateCurrentSessionRoom(roomId: roomId);
      _navigateToNewChatRoom(context, roomName);
    }
  }
}
