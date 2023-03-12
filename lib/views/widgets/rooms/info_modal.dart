import 'package:flutter/material.dart';

final List<String> _textList = [
  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras id eleifend neque, nec laoreet risus.',
  'The quick brown fox jumps over the lazy dog.'
];

class InfoModal extends StatelessWidget {
  const InfoModal({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      primary: false,
      children: [
        _renderTitle('Regras'),
        const SizedBox(height: 20),
        ..._renderTextList(_textList),
        const Divider(color: Color(0xFF999999)),
        const SizedBox(height: 10),
        _renderTitle('Informações'),
        const SizedBox(height: 20),
        ..._renderTextList(_textList.reversed.toList()),
      ],
    );
  }

  Text _renderTitle(String text) {
    return Text(
      text,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  List<Widget> _renderTextList(List<String> textList) {
    return textList
        .map(
          (text) => Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                    child: Icon(
                      Icons.circle,
                      color: Color(0xFF999999),
                      size: 8,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      text,
                      style: const TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        )
        .toList();
  }
}
