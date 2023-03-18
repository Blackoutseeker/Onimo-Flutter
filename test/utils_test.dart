import 'package:flutter_test/flutter_test.dart';

import 'package:onimo/utils/utils.dart';

void main() {
  group('Testing generateRandomId method from Utils class.', () {
    test('Should return a String with length 8 by default.', () {
      final String randomId = Utils.generateRandomId();
      expect(randomId.length, 8);
    });

    test('Should return a String with the same length as passed by argument.',
        () {
      const int expectedLength = 12;
      final String randomId = Utils.generateRandomId(length: expectedLength);
      expect(randomId.length, expectedLength);
    });
  });

  group('Testing generateNickname method from Utils class.', () {
    test(
        'Should return a String formatted with "^[a-z]+_[a-z]+[1-9]\$" RegExp.',
        () {
      final RegExp nicknamePattern = RegExp(r'^[a-z]+_[a-z]+[1-9]$');
      final String nickname = Utils.generateNickname();
      expect(nicknamePattern.hasMatch(nickname), true);
    });
  });
}
