import 'package:flutter/foundation.dart';

class Word {
  const Word({
    required this.id,
    required this.trad,
    required this.userId,
    this.definitions,
    required this.phonetics,
  });

  final String id;
  final Map<String, dynamic> trad;
  final String userId;
  final Map<String, dynamic>? definitions;
  final Map<String, dynamic>? phonetics;

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      id: json['_id'],
      trad: json['trad'],
      userId: json['userId'],
      definitions: json['definitions'],
      phonetics: json['phonetics'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'trad': trad,
    'userId': userId,
    'definitions': definitions,
    'phonetics': phonetics,
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Word &&
        other.id == id &&
        other.userId == userId &&
        mapEquals(other.trad, trad) &&
        mapEquals(other.definitions, definitions) &&
        mapEquals(other.phonetics, phonetics);
  }

  @override
  int get hashCode => Object.hash(
    id,
    _hashMap(trad),
    userId,
    _hashMap(definitions),
    _hashMap(phonetics),
  );

  int _hashMap(Map? map) {
    if (map == null) return 0;
    return Object.hashAll(map.entries.map((e) => Object.hash(e.key, e.value)));
  }

  @override
  String toString() {
    return '''
Word(
  id: $id,
  userId: $userId,
  trad: $trad,
  definitions: $definitions,
  phonetics: $phonetics,
)
''';
  }

  Word copyWith({
    String? id,
    String? userId,
    Map<String, String>? trad,
    Map<String, String>? definitions,
    Map<String, String>? phonetics,
  }) {
    return Word(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      trad: trad ?? this.trad,
      definitions: definitions ?? this.definitions,
      phonetics: phonetics ?? this.phonetics,
    );
  }
}
