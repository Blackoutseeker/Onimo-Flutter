import 'package:mobx/mobx.dart';

import 'package:onimo/models/entities/session.dart';

part 'session.g.dart';

class SessionStore = SessionStoreModel with _$SessionStore;

abstract class SessionStoreModel with Store {
  @observable
  Session session = Session(
    userId: 'temp_uid',
    userNickname: 'john_doe7',
    lastSessionDate: '2021-05-01 19:00:00',
  );

  @action
  void setSession(Session session) {
    this.session = session;
  }

  @action
  void updateCurrentSessionRoom({
    String? roomId,
    RoomType roomType = RoomType.public,
  }) {
    session.currentRoomId = roomId;
    session.currentRoomType = roomType;
  }
}
