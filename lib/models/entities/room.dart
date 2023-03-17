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
}
