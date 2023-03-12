import 'package:flutter/material.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:intl/intl.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
    required this.senderId,
    required this.senderNickname,
    required this.sendTimestamp,
    required this.bodyText,
  });

  final String senderId;
  final String senderNickname;
  final String sendTimestamp;
  final String bodyText;

  final String _localUserId = 'uid_temp';
  final String _localUserNickname = 'john_doe7';

  @override
  Widget build(BuildContext context) {
    final bool isLocalUser = (senderId == _localUserId);

    return Padding(
      padding: EdgeInsets.only(
        left: isLocalUser ? MediaQuery.of(context).size.width / 6 : 0,
        right: !isLocalUser ? MediaQuery.of(context).size.width / 6 : 0,
      ),
      child: Card(
        color: isLocalUser ? const Color(0xFF1E1E1E) : Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: isLocalUser ? const Radius.circular(10) : Radius.zero,
            topRight: !isLocalUser ? const Radius.circular(10) : Radius.zero,
            bottomLeft: const Radius.circular(10),
            bottomRight: const Radius.circular(10),
          ),
          side: const BorderSide(color: Color(0xFF1E1E1E), width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isLocalUser)
                Text(
                  senderNickname,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (!isLocalUser) const SizedBox(height: 12),
              if (!isLocalUser)
                SubstringHighlight(
                  text: bodyText,
                  caseSensitive: true,
                  term: '@$_localUserNickname',
                  textStyleHighlight: const TextStyle(
                    color: Color(0xFF166CED),
                  ),
                  textStyle: const TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 14,
                  ),
                ),
              if (isLocalUser)
                Text(
                  bodyText,
                  style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 14,
                  ),
                ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: Text(
                  DateFormat('HH:mm').format(DateTime.parse(sendTimestamp)),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: isLocalUser
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF999999),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
