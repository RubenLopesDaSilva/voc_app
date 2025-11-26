class Word {
  const Word({
    required this.id,
    required this.traductions,
    required this.phonetics,
    required this.userId,
  });

  final String id;
  final Map<String, String> traductions;
  final Map<String, String> phonetics;
  final String userId;
}
