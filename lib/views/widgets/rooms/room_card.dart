import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:onimo/controllers/stores/session.dart';
import 'package:onimo/models/entities/room.dart';
import 'package:onimo/views/screens/chat.dart';

class RoomCard extends StatelessWidget {
  RoomCard({super.key, required this.room});

  final Room room;
  final SessionStore _store = GetIt.I.get<SessionStore>();

  Future<void> _navigateToChatRoom(
    BuildContext context,
    String roomId,
    String roomName,
  ) async {
    _store.updateCurrentSessionRoom(roomId: roomId);

    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ChatScreen(
          roomName: roomName,
        ),
      ),
    );
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
