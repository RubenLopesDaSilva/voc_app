class Word {
  const Word({
    required this.id,
    required this.traductions,
    required this.phonetics,
    required this.definitions,
    required this.userId,
  });

  final String id;
  final Map<String, String> traductions;
  final Map<String, String> phonetics;
  final Map<String, String> definitions;
  final String userId;
}
