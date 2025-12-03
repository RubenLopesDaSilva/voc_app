class Group {
  const Group({
    required this.id,
    required this.name,
    required this.words,
    required this.userId,
  });

  final String id;
  final String name;
  final List<String> words;
  final String userId;

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['_id'],
      name: json['name'],
      words: json['words'],
      userId: json['userId'],
    );
  }
}
