import 'package:flutter/material.dart';

import 'code_input.dart';

class AddModal extends StatelessWidget {
  const AddModal({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      primary: false,
      reverse: true,
      children: [
        _renderTitle('Criar nova sala'),
        const SizedBox(height: 20),
        _renderButton(() async => {}, 'Pública', Icons.public),
        const SizedBox(height: 10),
        _renderButton(() async => {}, 'Privada', Icons.lock),
        const SizedBox(height: 10),
        const Divider(color: Color(0xFF999999)),
        const SizedBox(height: 10),
        _renderTitle('Entrar em uma sala'),
        const SizedBox(height: 20),
        const CodeInput(),
      ].reversed.toList(),
    );
  }

  Text _renderTitle(String title) {
    return Text(
      title,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  OutlinedButton _renderButton(
    void Function() onPressed,
    String textLabel,
    IconData icon,
  ) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Text(
            textLabel,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ],
      ),
    );
  }
}
