import 'package:flutter/material.dart';

import './rooms.dart';
import '../widgets/chat/list.dart';
import '../widgets/chat/footer.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
    required this.roomId,
    required this.roomName,
    required this.userId,
    required this.userNickname,
  });

  final String userId;
  final String userNickname;
  final String roomId;
  final String roomName;

  final int _activeUsers = 3;
  final int _maxUsersAllowed = 5;

  Future<bool> _navigateToPreviousScreen(BuildContext context) async {
    await Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => RoomsScreen(userId: userId, userNickname: userNickname),
    ));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => await _navigateToPreviousScreen(context),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              leading: IconButton(
                onPressed: () async => await _navigateToPreviousScreen(context),
                icon: const Icon(Icons.arrow_back),
              ),
              title: Text(
                roomName,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              actions: [
                SizedBox(
                  width: 90,
                  child: Row(
                    children: [
                      Text(
                        '$_activeUsers/$_maxUsersAllowed',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                MessagesList(roomId: roomId),
                const Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
