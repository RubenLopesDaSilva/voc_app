class Word {
  const Word({
    required this.id,
    required this.trad,
    required this.userId,
    this.definitions,
    required this.phonetics,
  });

  final String id;
  final Map<String, String> trad;
  final String userId;
  final Map<String, String>? definitions;
  final Map<String, String>? phonetics;

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      id: json['_id'],
      trad: json['trad'],
      userId: json['userId'],
      definitions: json['definitions'],
      phonetics: json['phonetic'],
    );
  }
}
