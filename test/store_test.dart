import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import 'package:onimo/models/entities/session.dart';
import 'package:onimo/controllers/stores/session.dart';

void main() {
  group('Testing SessionStore class.', () {
    final String currentDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(
      DateTime.now(),
    );

    final Session customSession = Session(
      userId: 'fake_uid',
      userNickname: 'fake_nickname0',
      currentRoomId: 'fake_room_id',
      currentRoomType: RoomType.private,
      lastSessionDate: currentDate,
    );

    final SessionStore sessionStore = SessionStore();
    test('SessionStore should accept custom values to be set.', () {
      sessionStore.setSession(customSession);

      expect(sessionStore.session.userId, customSession.userId);
      expect(sessionStore.session.userNickname, customSession.userNickname);
      expect(sessionStore.session.currentRoomId, customSession.currentRoomId);
      expect(
        sessionStore.session.currentRoomType,
        customSession.currentRoomType,
      );
      expect(
        sessionStore.session.lastSessionDate,
        customSession.lastSessionDate,
      );
    });

    test('SessionStore should update current rooms correctly.', () {
      final List<Map<dynamic, dynamic>> rooms = [
        {
          'id': null,
          'type': RoomType.public,
        },
        {
          'id': 'first_room_id',
          'type': RoomType.private,
        },
        {
          'id': 'second_room_id',
          'type': RoomType.public,
        },
      ];

      for (var room in rooms) {
        sessionStore.updateCurrentSessionRoom(room['id'], room['type']);
        expect(sessionStore.session.currentRoomId, room['id']);
        expect(sessionStore.session.currentRoomType, room['type']);
      }
    });
  });
}
