import 'package:flutter/material.dart';

import 'package:onimo/models/entities/room.dart';
import 'package:onimo/views/screens/chat.dart';

class RoomCard extends StatelessWidget {
  const RoomCard({
    super.key,
    required this.userId,
    required this.userNickname,
    required this.room,
  });

  final String userId;
  final String userNickname;
  final Room room;

  Future<void> _navigateToChatRoom(
    BuildContext context,
    String roomId,
    String roomName,
  ) async {
    await Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => ChatScreen(
        userId: userId,
        userNickname: userNickname,
        roomId: roomId,
        roomName: roomName,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: const BorderSide(
          color: Color(0xFF1E1E1E),
          width: 2,
        ),
      ),
      child: ListTile(
        onTap: () async => await _navigateToChatRoom(
          context,
          room.id,
          room.name,
        ),
        title: Text(
          room.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: SizedBox(
          width: 62,
          child: Row(
            children: [
              Text(
                '${room.activeUsers.length}/5',
                style: const TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.person,
                color: Color(0xFF999999),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
