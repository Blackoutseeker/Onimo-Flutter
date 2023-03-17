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

  Map<dynamic, dynamic> convertToDatabase() {
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
}
