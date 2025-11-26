class User {
  const User({required this.id, required this.username, required this.email});

  final String id;
  final String username;
  final String email;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['userName'],
      email: json['email'],
    );
  }
}
