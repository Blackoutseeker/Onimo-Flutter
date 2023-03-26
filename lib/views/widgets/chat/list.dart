import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';

import 'package:onimo/controllers/stores/session.dart';
import 'package:onimo/models/entities/message.dart';
import 'package:onimo/controllers/services/database.dart';
import './blank_chat.dart';
import './message_card.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({super.key});

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList>
    with WidgetsBindingObserver {
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  final ScrollController _scrollController = ScrollController();
  final SessionStore _store = GetIt.I.get<SessionStore>();

  List<Message> _messages = [];
  late StreamSubscription<DatabaseEvent> _messagesSubscription;
  bool _needToScroll = false;

  void _setMessagesState(List<Message> messages) {
    setState(() {
      _messages = messages;
      _needToScroll = true;
    });
  }

  void _initializeChatListener() {
    if (_store.session.currentRoomId != null) {
      final List<Message> messages = [];

      _messagesSubscription = _firebaseDatabase
          .ref('chat_rooms/${_store.session.currentRoomId}/chat')
          .limitToLast(10)
          .onChildAdded
          .listen((event) {
        final messageFromDatabase =
            Map<String, dynamic>.from(event.snapshot.value as Map);

        messages.add(Message.asMessage(messageFromDatabase));
        messages.sort((a, b) => b.sendTimestamp.compareTo(a.sendTimestamp));

        _setMessagesState(messages);
      });
    }
  }

  void _stopChatListener() {
    _messagesSubscription.cancel();
  }

  void _scrollToEnd() {
    if (_scrollController.positions.isNotEmpty) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeChatListener();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    final bool isInBackground = state != AppLifecycleState.resumed;
    if (isInBackground) {
      Database.disconnectUserFromChat();
    } else {
      Database.connectUserToCurrentChat();
    }
  }

  @override
  void dispose() {
    _stopChatListener();
    _scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_messages.isEmpty) {
      return const BlankChat();
    }

    if (_needToScroll) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _scrollToEnd(),
      );
      _needToScroll = false;
    }

    return Expanded(
      child: ListView.separated(
        controller: _scrollController,
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
