import 'package:flutter/material.dart';

class BlankChat extends StatelessWidget {
  const BlankChat({super.key});

  @override
  Widget build(BuildContext context) {
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
                  'Sempre mantenha o respeito aos demais usuários. Antes de enviar uma mensagem, pense em suas consequências.',
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
}
