import 'package:flutter/material.dart';

import './message_card.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({super.key});

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  final List<Map<String, String>> _messages = [
    {
      "sender_id": "uid_Fasf3wgfbvn",
      "sender_nickname": "johnny84",
      "send_timestamp": "2023-03-06 22:27:19",
      "body_text": "The quick brown fox jumps over the lazy dog.",
    },
    {
      "sender_id": "uid_9msdgdmJFGsgsdg",
      "sender_nickname": "agent47",
      "send_timestamp": "2023-03-06 22:30:42",
      "body_text": "@john_doe7 It's done.",
    },
    {
      "sender_id": "uid_temp",
      "sender_nickname": "john_doe7",
      "send_timestamp": "2023-03-06 22:31:43",
      "body_text":
          "Good work 47, the payment has already been made to your account.",
    },
    {
      "sender_id": "uid_9msdgdmJFGsgsdg",
      "sender_nickname": "agent47",
      "send_timestamp": "2023-03-06 22:34:48",
      "body_text": "Thanks, Mr. John.",
    }
  ].reversed.toList();

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
          senderId: _messages[index]['sender_id'] ?? 'undef',
          senderNickname: _messages[index]['sender_nickname'] ?? 'undef',
          sendTimestamp: _messages[index]['send_timestamp'] ?? 'undef',
          bodyText: _messages[index]['body_text'] ?? 'undef',
        ),
      ),
    );
  }
}
