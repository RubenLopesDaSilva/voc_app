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

  Map<String, dynamic> toJson() => {
    '_id': id,
    'userName': username,
    'email': email,
  };

  @override
  String toString() {
    return '''
User(
  id: $id,
  username:$username,
  email:$email
)
''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;

    return other is User &&
        other.id == id &&
        other.username == username &&
        other.email == email;
  }

  @override
  int get hashCode => Object.hash(id, username, email);
}
