class Message {
  const Message({
    required this.senderId,
    required this.senderNickname,
    required this.sendTimestamp,
    required this.bodyText,
  });

  final String senderId;
  final String senderNickname;
  final String sendTimestamp;
  final String bodyText;

  Map<dynamic, dynamic> toDatabase() {
    return {
      'sender_id': senderId,
      'sender_nickname': senderNickname,
      'send_timestamp': sendTimestamp,
      'body_text': bodyText,
    };
  }

  factory Message.asMessage(Map<dynamic, dynamic> data) {
    return Message(
      senderId: data['sender_id'],
      senderNickname: data['sender_nickname'],
      sendTimestamp: data['send_timestamp'],
      bodyText: data['body_text'],
    );
  }
}
