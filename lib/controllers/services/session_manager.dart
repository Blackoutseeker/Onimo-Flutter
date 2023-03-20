import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import 'package:onimo/models/entities/session.dart';
import './local_storage.dart';
import 'package:onimo/utils/utils.dart';
import '../stores/session.dart';

class SessionManager {
  static Future<bool> _checkIfLastSessionIsOutdated() async {
    final Session? lastSession = await LocalStorage.getLastSession();
    if (lastSession == null) return true;

    final DateTime currentDate = DateTime.now();
    final DateTime lastSessionDate = DateTime.parse(
      lastSession.lastSessionDate,
    );
    final bool isTheSameDay =
        lastSessionDate.difference(currentDate).inDays == 0;

    if (isTheSameDay) {
      return false;
    }

    return true;
  }

  static Future<void> _createNewSession() async {
    final String newUserId = Utils.generateRandomId();
    final String newUserNickname = Utils.generateNickname();
    final String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(
      DateTime.now(),
    );

    final Session newSession = Session(
      userId: newUserId,
      userNickname: newUserNickname,
      lastSessionDate: formattedDate,
    );

    await LocalStorage.saveCurrentSession(newSession);
  }

  static Future<void> initialize() async {
    final bool isSessionOutdated = await _checkIfLastSessionIsOutdated();
    if (isSessionOutdated) {
      await _createNewSession();
    }

    final Session? lastSession = await LocalStorage.getLastSession();
    final SessionStore sessionStore = GetIt.I.get<SessionStore>();
    if (lastSession != null) {
      sessionStore.setSession(lastSession);
    }
  }
}
