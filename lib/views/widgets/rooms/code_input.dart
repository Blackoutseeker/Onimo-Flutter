import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:onimo/controllers/stores/session.dart';
import 'package:onimo/models/entities/session.dart';
import 'package:onimo/views/screens/chat.dart';
import 'package:onimo/controllers/services/database.dart';

class CodeInput extends StatefulWidget {
  const CodeInput({super.key});

  @override
  State<CodeInput> createState() => _CodeInputState();
}

class _CodeInputState extends State<CodeInput> {
  final TextEditingController _field1 = TextEditingController();
  final TextEditingController _field2 = TextEditingController();
  final TextEditingController _field3 = TextEditingController();
  final TextEditingController _field4 = TextEditingController();

  bool _enabled = true;
  bool _isErrorMessageVisible = false;

  void _hideErrorMessage() {
    setState(() {
      _isErrorMessageVisible = false;
    });
  }

  void _changeEnabledState() {
    setState(() {
      _enabled = !_enabled;
    });
  }

  void _navigateToPrivateChatRoom(String roomId) async {
    final SessionStore store = GetIt.I.get<SessionStore>();
    store.updateCurrentSessionRoom(roomId: roomId, roomType: RoomType.private);
    await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => ChatScreen(
          roomName: roomId,
          initialUsersLength: 1,
        ),
      ),
      (route) => false,
    );
  }

  void _showErrorMessage() {
    setState(() {
      _isErrorMessageVisible = true;
    });
  }

  void _clearAllTextFields() {
    _field1.clear();
    _field2.clear();
    _field3.clear();
    _field4.clear();
  }

  void _enterPrivateRoom() async {
    _hideErrorMessage();
    _changeEnabledState();

    String roomId = '';
    roomId += _field1.text;
    roomId += _field2.text;
    roomId += _field3.text;
    roomId += _field4.text;
    roomId = roomId.toUpperCase();

    final bool privateRoomExists =
        await Database.checkIfPrivateRoomExists(roomId);
    if (privateRoomExists) {
      _navigateToPrivateChatRoom(roomId);
    } else {
      _showErrorMessage();
    }

    _clearAllTextFields();
    _changeEnabledState();
  }

  void _focusNextFocusNode(
    String text,
    TextEditingController textFieldController,
  ) {
    if (text.isNotEmpty && textFieldController != _field4) {
      _hideErrorMessage();
      FocusScope.of(context).nextFocus();
    }

    final bool canEnterPrivateRoom = (textFieldController == _field4 &&
        _field1.text.isNotEmpty &&
        _field2.text.isNotEmpty &&
        _field3.text.isNotEmpty &&
        _field4.text.isNotEmpty);

    if (canEnterPrivateRoom) {
      _enterPrivateRoom();
    }
  }

  @override
  void dispose() {
    _field1.dispose();
    _field2.dispose();
    _field3.dispose();
    _field4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _renderTextField(_field1),
            const SizedBox(width: 14),
            _renderTextField(_field2),
            const SizedBox(width: 14),
            _renderTextField(_field3),
            const SizedBox(width: 14),
            _renderTextField(_field4),
          ],
        ),
        if (_isErrorMessageVisible) const SizedBox(height: 20),
        if (_isErrorMessageVisible)
          const Text(
            'Sala privada inexistente, tente outro código.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
            ),
          ),
      ],
    );
  }

  Widget _renderTextField(TextEditingController textFieldController) {
    return Flexible(
      child: TextField(
        enabled: _enabled,
        controller: textFieldController,
        maxLength: 1,
        maxLines: 1,
        textCapitalization: TextCapitalization.characters,
        enableSuggestions: false,
        textAlign: TextAlign.center,
        onChanged: (text) => _focusNextFocusNode(text, textFieldController),
        onEditingComplete: () => _focusNextFocusNode(
          textFieldController.text,
          textFieldController,
        ),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        decoration: const InputDecoration(
          counterText: '',
          hintText: '_',
          hintStyle: TextStyle(
            color: Color(0xFF999999),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF999999),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF999999),
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF111111),
            ),
          ),
        ),
      ),
    );
  }
}
