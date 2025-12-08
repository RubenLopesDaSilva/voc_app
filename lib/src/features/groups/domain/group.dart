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
    final List<String> words = [];
    for (String word in json['words']) {
      words.add(word);
    }
    return Group(
      id: json['_id'],
      name: json['name'],
      words: words,
      userId: json['userId'],
    );
  }
}
