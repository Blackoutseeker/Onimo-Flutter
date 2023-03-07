import 'package:flutter/material.dart';

class RoomsList extends StatefulWidget {
  const RoomsList({super.key});

  @override
  State<RoomsList> createState() => _RoomsListState();
}

class _RoomsListState extends State<RoomsList> {
  final List<Map<String, dynamic>> _availableRooms = [
    {
      "id": "ALkfam24msxcvlsdg",
      "name": "Room 01",
      "type": "public",
      "active_users": 1,
    },
    {
      "id": "Fasfwa24xcvxca",
      "name": "Room 02",
      "type": "public",
      "active_users": 2,
    }
  ];

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_availableRooms.isEmpty) {
      return const Center(
        heightFactor: 8,
        child: Text(
          'Nenhuma sala disponível.',
          style: TextStyle(
            color: Color(0xFF999999),
            fontSize: 16,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemCount: _availableRooms.length,
      itemBuilder: (_, index) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: const BorderSide(
            color: Color(0xFF1E1E1E),
            width: 2,
          ),
        ),
        color: const Color(0xFF111111),
        child: ListTile(
          onTap: () => {},
          title: Text(
            _availableRooms[index]['name'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: SizedBox(
            width: 62,
            child: Row(
              children: [
                Text(
                  '${_availableRooms[index]['active_users']}/5',
                  style: const TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.person,
                  color: Color(0xFF999999),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
