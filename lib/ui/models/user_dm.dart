class UserDm {
  static UserDm? currentUser;
  String id;
  String email;
  String name;
  List<String> favoriteEvents;
  UserDm({
    required this.id,
    required this.name,
    required this.email,
    this.favoriteEvents = const [],
  });
}
