import 'dart:math';

import './constants.dart';

class Utils {
  static String generateRandomId({int length = 8}) {
    String randomId = '';

    final List<String> chars = [...Constants.letters, ...Constants.digits];

    for (int index = 0; index < length; index++) {
      final int randomCharIndex = Random().nextInt(chars.length);
      randomId += chars[randomCharIndex];
    }

    return randomId;
  }

  static String generateNickname() {
    String nickname = '';

    final int randomUnit = Random().nextInt(9) + 1; // [1-9]
    final int randomNicknameIndex = Random().nextInt(
      Constants.nicknames.length,
    );
    final String randomNickname = Constants.nicknames[randomNicknameIndex];
    nickname = randomNickname + randomUnit.toString();

    return nickname;
  }
}
