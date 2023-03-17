import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:onimo/models/entities/message.dart';
import './blank_chat.dart';
import './message_card.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({super.key, required this.roomId});

  final String roomId;

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  List<Message> _messages = [];
  late StreamSubscription<DatabaseEvent> _messagesSubscription;

  void _setMessagesState(List<Message> messages) {
    setState(() {
      _messages = messages;
    });
  }

  void _initializeChatListener() {
    final List<Message> messages = [];

    _messagesSubscription = _firebaseDatabase
        .ref('chat_rooms/${widget.roomId}/chat')
        .limitToLast(10)
        .onChildAdded
        .listen((event) {
      final messageFromDatabase =
          Map<String, dynamic>.from(event.snapshot.value as Map);
      messages.add(Message.convertFromDatabase(messageFromDatabase));
      messages.sort((a, b) => b.sendTimestamp.compareTo(a.sendTimestamp));
      _setMessagesState(messages);
    });
  }

  void _stopChatListener() {
    _messagesSubscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    _initializeChatListener();
  }

  @override
  void dispose() {
    _stopChatListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_messages.isEmpty) {
      return const BlankChat();
    }

    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemCount: _messages.length,
        itemBuilder: (_, index) => MessageCard(
          key: UniqueKey(),
          message: _messages[index],
        ),
      ),
    );
  }
}
