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
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "favorites": favoriteEvents,
    };
  }

  static UserDm fromJson(Map<String, dynamic> json) {
    List<dynamic> favorites= json["favorites"];
    return UserDm(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      favoriteEvents: favorites.map((id)=>id.toString()).toList(),
    );
  }
}
