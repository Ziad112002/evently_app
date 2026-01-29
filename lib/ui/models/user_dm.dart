class UserDm {
  static UserDm? currentUser;
  String id;
  String email;
  String name;
  List favoriteEvents;
  UserDm({
    required this.id,
    required this.name,
    required this.email,
    this.favoriteEvents = const [],
  });
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "favorites": favoriteEvents,
    };
  }

  static UserDm fromJson(Map<String, dynamic> json) {
    return UserDm(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      favoriteEvents: json["favorites"],
    );
  }
}
