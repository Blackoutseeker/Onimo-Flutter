import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:onimo/models/entities/room.dart';
import './room_card.dart';

class RoomsList extends StatefulWidget {
  const RoomsList({super.key});

  @override
  State<RoomsList> createState() => _RoomsListState();
}

class _RoomsListState extends State<RoomsList> {
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  List<Room> _rooms = [];
  late StreamSubscription _roomsSubscription;

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
        rooms.add(Room.asRoom(room));
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
      itemBuilder: (_, index) => RoomCard(
        key: UniqueKey(),
        room: _rooms[index],
      ),
    );
  }
}
