import './local_storage_data.dart';

enum RoomType { public, private }

class Session extends LocalStorageData {
  Session({
    required super.userId,
    required super.userNickname,
    required super.lastSessionDate,
    this.currentRoomId,
    this.currentRoomType = RoomType.public,
  });

  String? currentRoomId;
  RoomType currentRoomType;

  int get maxUsersLength {
    if (currentRoomType == RoomType.private) {
      return 10;
    }
    return 5;
  }
}
