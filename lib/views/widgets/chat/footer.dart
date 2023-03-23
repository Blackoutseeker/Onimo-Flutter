import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import 'package:onimo/controllers/stores/session.dart';
import 'package:onimo/models/entities/message.dart';
import 'package:onimo/controllers/services/database.dart';

const int _maxMessageLength = 300;

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  final TextEditingController _textFieldController = TextEditingController();
  final SessionStore _store = GetIt.I.get<SessionStore>();
  String _counter = '0';

  void _setCounter(String text) {
    setState(() {
      _counter = text.length.toString();
    });
  }

  Future<void> _sendMessage() async {
    if (_textFieldController.text.isNotEmpty &&
        _store.session.currentRoomId != null) {
      final String sendTimestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(
        DateTime.now(),
      );
      final String bodyText = _textFieldController.text;

      final Message message = Message(
        senderId: _store.session.userId,
        senderNickname: _store.session.userNickname,
        sendTimestamp: sendTimestamp,
        bodyText: bodyText,
      );

      await Database.insertMessageIntoDatabase(
              _store.session.currentRoomId!, message)
          .then((_) {
        _textFieldController.clear();
        setState(() {
          _counter = '0';
        });
      });
    }
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: _textFieldController,
              onChanged: _setCounter,
              maxLength: _maxMessageLength,
              minLines: 1,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFF1E1E1E),
                counterText: '',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  borderSide: BorderSide(
                    color: Color(0xFF1E1E1E),
                    width: 2,
                  ),
                ),
                hintText: 'Mensagem',
                hintStyle: TextStyle(
                  color: Color(0xFF999999),
                ),
              ),
            ),
          ),
          if (FocusScope.of(context).hasFocus && _counter != '0')
            SizedBox(
              height: 47,
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Text(
                    '$_counter/$_maxMessageLength',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(width: 20),
          SizedBox(
            width: 47,
            height: 47,
            child: FloatingActionButton(
              onPressed: _counter != '0' ? _sendMessage : null,
              elevation: 0,
              backgroundColor: _counter != '0'
                  ? const Color(0xFF166CED)
                  : const Color(0xFF111111),
              child: const Icon(Icons.send, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}
