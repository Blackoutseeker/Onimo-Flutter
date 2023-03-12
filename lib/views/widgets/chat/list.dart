import 'package:flutter/material.dart';

import 'package:onimo/controllers/services/database.dart';
import './message_card.dart';
import 'package:onimo/models/entities/message.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({super.key, required this.roomId});

  final String roomId;

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  List<Message> _messages = [];

  Future<void> _getMessages() async {
    await Database.instance
        .getChatMessagesByRoomId(widget.roomId)
        .then((messages) {
      setState(() {
        _messages = messages;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getMessages();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_messages.isEmpty) {
      return Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 10,
          ),
          child: Column(
            children: const [
              Card(
                color: Color(0xFF1E1E1E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(14),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor...',
                    style: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
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
