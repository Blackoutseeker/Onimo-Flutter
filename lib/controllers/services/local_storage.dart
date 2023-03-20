import 'package:hive/hive.dart';

import 'package:onimo/models/entities/session.dart';
import 'package:onimo/models/entities/local_storage_data.dart';

const String _sessionBox = 'session_box';
const String _sessionBoxKey = 'session';

class LocalStorage {
  static Future<void> saveCurrentSession(Session session) async {
    final Box<dynamic> sessionBox = await Hive.openBox(_sessionBox);

    final LocalStorageData localStorageData = LocalStorageData(
      userId: session.userId,
      userNickname: session.userNickname,
      lastSessionDate: session.lastSessionDate,
    );

    await sessionBox.put(_sessionBoxKey, localStorageData.toMap());
  }

  static Future<Session?> getLastSession() async {
    final Box<dynamic> sessionBox = await Hive.openBox(_sessionBox);
    final dynamic lastSession = sessionBox.get(_sessionBoxKey);

    if (lastSession != null) {
      final LocalStorageData localStorageData = LocalStorageData.fromStorage(
        lastSession,
      );
      return Session(
        userId: localStorageData.userId,
        userNickname: localStorageData.userNickname,
        lastSessionDate: localStorageData.lastSessionDate,
      );
    }

    return null;
  }
}
