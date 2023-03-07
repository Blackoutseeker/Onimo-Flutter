import 'package:flutter/material.dart';

import 'package:onimo/views/widgets/rooms/list.dart';

class RoomsScreen extends StatelessWidget {
  const RoomsScreen({super.key, required this.userNickname});

  final String userNickname;

  void _openInfoModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        content: SizedBox(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            userNickname,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
          actions: <IconButton>[
            IconButton(
              onPressed: () => _openInfoModal(context),
              icon: const Icon(
                Icons.info_outline,
                color: Color(0xFF999999),
                size: 26,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openInfoModal(context),
          child: const Icon(Icons.add),
        ),
        body: const RoomsList(),
      ),
    );
  }
}
