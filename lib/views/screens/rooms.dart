import 'package:flutter/material.dart';

import '../widgets/rooms/info_modal.dart';
import '../widgets/rooms/add_modal.dart';
import '../widgets/rooms/list.dart';

class RoomsScreen extends StatelessWidget {
  const RoomsScreen({
    super.key,
    required this.userId,
    required this.userNickname,
  });

  final String userId;
  final String userNickname;

  Future<void> _openInfoModal(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        content: InfoModal(),
      ),
    );
  }

  Future<void> _openAddModal(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (dialogContext) => GestureDetector(
        onTap: FocusScope.of(dialogContext).unfocus,
        child: const AlertDialog(
          content: AddModal(),
        ),
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
              onPressed: () async => await _openInfoModal(context),
              icon: const Icon(
                Icons.info_outline,
                color: Color(0xFF999999),
                size: 26,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async => await _openAddModal(context),
          child: const Icon(Icons.add),
        ),
        body: RoomsList(userId: userId, userNickname: userNickname),
      ),
    );
  }
}
