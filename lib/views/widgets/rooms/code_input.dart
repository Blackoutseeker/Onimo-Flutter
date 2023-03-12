import 'package:flutter/material.dart';

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

  final bool _enabled = true;

  void _focusNextFocusNode(
    String text,
    TextEditingController textFieldController,
  ) {
    if (text.isNotEmpty && textFieldController != _field4) {
      FocusScope.of(context).nextFocus();
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
    return Row(
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
