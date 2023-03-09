import 'package:flutter/material.dart';

import '/views/screens/chat.dart';

class RoomsList extends StatefulWidget {
  const RoomsList({
    super.key,
    required this.userId,
    required this.userNickname,
  });

  final String userId;
  final String userNickname;

  @override
  State<RoomsList> createState() => _RoomsListState();
}

class _RoomsListState extends State<RoomsList> {
  final List<Map<String, dynamic>> _availableRooms = [
    {
      "id": "ALkfam24msxcvlsdg",
      "name": "Room 01",
      "type": "public",
      "active_users": 1,
    },
    {
      "id": "Fasfwa24xcvxca",
      "name": "Room 02",
      "type": "public",
      "active_users": 2,
    }
  ];

  Future<void> _navigateToChatRoom(
    BuildContext context,
    String roomId,
    String roomName,
  ) async {
    await Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => ChatScreen(
        userId: widget.userId,
        userNickname: widget.userNickname,
        roomId: roomId,
        roomName: roomName,
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_availableRooms.isEmpty) {
      return const Center(
        heightFactor: 8,
        child: Text(
          'Nenhuma sala disponível.',
          style: TextStyle(
            color: Color(0xFF999999),
            fontSize: 16,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemCount: _availableRooms.length,
      itemBuilder: (_, index) => Card(
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
            _availableRooms[index]['id'],
            _availableRooms[index]['name'],
          ),
          title: Text(
            _availableRooms[index]['name'],
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
                  '${_availableRooms[index]['active_users']}/5',
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
      ),
    );
  }
}
