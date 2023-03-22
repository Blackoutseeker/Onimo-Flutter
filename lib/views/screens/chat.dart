import 'package:flutter/material.dart';

import 'package:onimo/controllers/services/database.dart';
import './rooms.dart';
import '../widgets/chat/users_label.dart';
import '../widgets/chat/list.dart';
import '../widgets/chat/footer.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
    required this.roomName,
    required this.initialUsersLength,
  });

  final String roomName;
  final int initialUsersLength;

  Future<bool> _navigateToPreviousScreen(BuildContext context) async {
    Database.disconnectUserFromChat();

    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => RoomsScreen(),
      ),
    );
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
                ActiveUsersLabel(initialUsersLength: initialUsersLength),
              ],
            ),
            body: Column(
              children: const [
                MessagesList(),
                Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
