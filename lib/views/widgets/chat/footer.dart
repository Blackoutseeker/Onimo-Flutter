import 'package:flutter/material.dart';

const int _maxLength = 300;

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  final TextEditingController _textFieldController = TextEditingController();
  final bool _enabled = true;
  String _counter = '0';

  void _setCounter(String text) {
    setState(() {
      _counter = text.length.toString();
    });
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
              enabled: _enabled,
              onChanged: _setCounter,
              maxLength: _maxLength,
              minLines: 1,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                filled: _enabled,
                fillColor: const Color(0xFF1E1E1E),
                counterText: '',
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  borderSide: BorderSide(
                    color: Color(0xFF1E1E1E),
                    width: 2,
                  ),
                ),
                hintText: 'Mensagem',
                hintStyle: const TextStyle(
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
                    '$_counter/$_maxLength',
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
              onPressed: _enabled ? () => {} : null,
              elevation: 0,
              backgroundColor:
                  _enabled ? const Color(0xFF166CED) : const Color(0xFF111111),
              child: const Icon(Icons.send, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}
