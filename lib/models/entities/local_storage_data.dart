class LocalStorageData {
  LocalStorageData({
    required this.userId,
    required this.userNickname,
    required this.lastSessionDate,
  });

  String userId;
  String userNickname;
  String lastSessionDate;

  Map<dynamic, dynamic> toMap() {
    return {
      'user_id': userId,
      'user_nickname': userNickname,
      'last_session_date': lastSessionDate,
    };
  }
}
