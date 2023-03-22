import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';

import 'package:onimo/controllers/stores/session.dart';
import 'package:onimo/models/entities/session.dart';
import 'package:onimo/controllers/services/database.dart';

class ActiveUsersLabel extends StatefulWidget {
  const ActiveUsersLabel({
    super.key,
    required this.initialUsersLength,
  });

  final int initialUsersLength;

  @override
  State<ActiveUsersLabel> createState() => _ActiveUsersLabelState();
}

class _ActiveUsersLabelState extends State<ActiveUsersLabel> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final SessionStore _store = GetIt.I.get<SessionStore>();
  String? get _roomId => _store.session.currentRoomId;
  RoomType get _roomType => _store.session.currentRoomType;
  int get _maxLengthAllowedUsers {
    if (_roomType == RoomType.private) return 10;
    return 5;
  }

  int _activeUsersLength = 1;
  late StreamSubscription _usersSubscription;

  void _setActiveUsersLengthState(int usersLength) {
    setState(() {
      _activeUsersLength = usersLength;
    });
  }

  void _initializeActiveUsersListener() {
    if (_roomId != null) {
      String usersReference = 'available_rooms/';
      if (_roomType == RoomType.private) usersReference = 'chat_rooms/';
      usersReference += '$_roomId/active_users';

      _usersSubscription =
          _database.ref(usersReference).onValue.listen((event) {
        final Object? users = event.snapshot.value;
        if (users != null) {
          _setActiveUsersLengthState((users as Map).length);
        }
      });
    }
  }

  void _stopActiveUsersListener() {
    _usersSubscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    _setActiveUsersLengthState(widget.initialUsersLength);
    Database.connectUserToCurrentChat();
    _initializeActiveUsersListener();
  }

  @override
  void dispose() {
    _stopActiveUsersListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: Row(
        children: [
          Text(
            '$_activeUsersLength/$_maxLengthAllowedUsers',
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
    );
  }
}
