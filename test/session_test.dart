import 'package:flutter_test/flutter_test.dart';

import 'package:onimo/models/entities/session.dart';
import 'package:onimo/controllers/services/session_manager.dart';

void main() {
  group('Testing SessionManager methods.', () {
    Session generateLastSessionWithCustomDate(String lastSessionDate) {
      return Session(
        userId: 'random_uid',
        userNickname: 'john_doe7',
        lastSessionDate: lastSessionDate,
      );
    }

    test('Check if it\'s outdated for yesterday.', () {
      final DateTime currentDate = DateTime.now();
      final String yesterdaysDate =
          currentDate.subtract(const Duration(days: 1)).toString();
      final Session lastSession =
          generateLastSessionWithCustomDate(yesterdaysDate);

      final bool isLastSessionOutdated =
          SessionManager.checkIfLastSessionIsOutdated(lastSession);
      expect(isLastSessionOutdated, true);
    });

    test('Check if it\'s outdated for today.', () {
      final DateTime currentDate = DateTime.now();
      final Session lastSession =
          generateLastSessionWithCustomDate(currentDate.toString());

      final bool isLastSessionOutdated =
          SessionManager.checkIfLastSessionIsOutdated(lastSession);
      expect(isLastSessionOutdated, false);
    });

    test('Check if it\'s outdated for tomorrow.', () {
      final DateTime currentDate = DateTime.now();
      final String tomorrowsDate =
          currentDate.add(const Duration(days: 1)).toString();

      final Session lastSession =
          generateLastSessionWithCustomDate(tomorrowsDate);

      final bool isLastSessionOutdated =
          SessionManager.checkIfLastSessionIsOutdated(lastSession);
      expect(isLastSessionOutdated, true);
    });

    test('Check if it\'s outdated with null session.', () {
      final bool isLastSessionOutdated =
          SessionManager.checkIfLastSessionIsOutdated(null);
      expect(isLastSessionOutdated, true);
    });
  });
}
