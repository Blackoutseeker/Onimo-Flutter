import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:onimo/controllers/stores/session.dart';
import '../widgets/rooms/info_modal.dart';
import '../widgets/rooms/add_modal.dart';
import '../widgets/rooms/list.dart';

class RoomsScreen extends StatelessWidget {
  RoomsScreen({super.key});

  final SessionStore _store = GetIt.I.get<SessionStore>();

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
            _store.session.userNickname,
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
        body: const RoomsList(),
      ),
    );
  }
}
