class ActiveUser {
  const ActiveUser({
    required this.id,
    required this.status,
  });

  final String id;
  final String status;
}

class Room {
  const Room({
    required this.id,
    required this.name,
    required this.activeUsers,
  });

  final String id;
  final String name;
  final List<ActiveUser> activeUsers;

  Map<dynamic, dynamic> toDatabase() {
    return {
      'id': id,
      'name': name,
      'active_users': activeUsers.map(
        (user) => {
          user.id: {
            'status': user.status,
          }
        },
      ),
    };
  }

  factory Room.asRoom(Map<dynamic, dynamic> data) {
    final List<ActiveUser> activeUsers = [];

    if (data['active_users'] != null) {
      (data['active_users'] as Map).forEach((key, value) {
        activeUsers.add(
          ActiveUser(
            id: key,
            status: value['status'],
          ),
        );
      });
    }

    return Room(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      activeUsers: activeUsers,
    );
  }
}
