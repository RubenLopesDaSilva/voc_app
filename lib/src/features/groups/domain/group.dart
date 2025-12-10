import 'package:flutter/foundation.dart';

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

  Map<String, dynamic> toJson() {
    return {'_id': id, 'name': name, 'words': words, 'userId': userId};
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Group &&
        other.id == id &&
        other.userId == userId &&
        other.name == name &&
        listEquals(other.words, words);
  }

  @override
  String toString() {
    return '''
Group(
  id: $id,
  name: $name,
  words: $words,
  userId: $userId,
)
''';
  }

  Group copyWith({
    String? id,
    String? name,
    List<String>? words,
    String? userId,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      words: words ?? this.words,
      userId: userId ?? this.userId,
    );
  }

  @override
  int get hashCode => Object.hash(id, name, _hashList(words), userId);

  int _hashList(List? list) {
    if (list == null) return 0;
    return Object.hashAll(list.map((e) => e.hashCode));
  }
}
