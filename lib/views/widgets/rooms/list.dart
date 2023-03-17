import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:onimo/models/entities/room.dart';
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
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  List<Room> _rooms = [];
  late StreamSubscription _roomsSubscription;

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

  void _setRoomsState(List<Room> rooms) {
    setState(() {
      _rooms = rooms;
    });
  }

  void _initializeRoomsListener() {
    _roomsSubscription =
        _firebaseDatabase.ref('available_rooms').onValue.listen((event) {
      final List<Room> rooms = [];
      final roomsFromDatabase =
          Map<String, dynamic>.from(event.snapshot.value as Map);

      roomsFromDatabase.forEach((key, room) {
        rooms.add(Room.convertFromDatabase(room));
      });

      rooms.sort(
        (a, b) => a.activeUsers.length.compareTo(b.activeUsers.length),
      );

      _setRoomsState(rooms);
    });
  }

  void _stopRoomsListener() {
    _roomsSubscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    _initializeRoomsListener();
  }

  @override
  void dispose() {
    _stopRoomsListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_rooms.isEmpty) {
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
      itemCount: _rooms.length,
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
            _rooms[index].id,
            _rooms[index].name,
          ),
          title: Text(
            _rooms[index].name,
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
                  '${_rooms[index].activeUsers.length}/5',
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
