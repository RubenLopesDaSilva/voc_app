enum RepetitionState { begin, process, end }

class Repetition {
  const Repetition({
    Set<String> allWords = const {},
    Set<String> usingWords = const {},
    Set<String> knownWords = const {},
    Set<String> unknownWords = const {},
    RepetitionState state = RepetitionState.begin,
    int index = 0,
    String listId = '',
    String firstLanguage = '',
    String secondLanguage = '',
  }) : _allWords = allWords,
       _usingWords = usingWords,
       _knownWords = knownWords,
       _unknownWords = unknownWords,
       _state = state,
       _index = index,
       _listId = listId,
       _firstLanguage = firstLanguage,
       _secondLanguage = secondLanguage;

  final Set<String> _allWords;
  final Set<String> _usingWords;
  final Set<String> _knownWords;
  final Set<String> _unknownWords;

  final RepetitionState _state;
  final int _index;
  final String _listId;
  final String _firstLanguage;
  final String _secondLanguage;

  Repetition copyWith({
    Set<String>? allWords,
    Set<String>? usingWords,
    Set<String>? knownWords,
    Set<String>? unknownWords,
    RepetitionState? state,
    int? index,
    String? listId,
    String? firstLanguage,
    String? secondLanguage,
  }) {
    return Repetition(
      allWords: allWords?.toSet() ?? _allWords,
      usingWords: usingWords?.toSet() ?? _usingWords,
      knownWords: knownWords?.toSet() ?? _knownWords,
      unknownWords: unknownWords?.toSet() ?? _unknownWords,
      state: state ?? _state,
      index: index ?? _index,
      listId: listId ?? _listId,
      firstLanguage: firstLanguage ?? _firstLanguage,
      secondLanguage: secondLanguage ?? _secondLanguage,
    );
  }
}

extension GetRepetition on Repetition {
  int get usingCount => _usingWords.length;
  int get knownCount => _knownWords.length;
  int get unknownCount => _unknownWords.length;
  RepetitionState get state => _state;
  int? get index => _index;
  String get listId => _listId;
  String get firstLanguage => _firstLanguage;
  String get secondLanguage => _secondLanguage;

  List<String> get allUsingWords => _usingWords.toList();
}

extension MutableRepetition on Repetition {
  Repetition initialize({
    required Iterable<String> words,
    required int initialIndex,
    required String listId,
    required String firstLanguage,
    required String secondLanguage,
  }) {
    return copyWith(
      allWords: words.toSet(),
      usingWords: words.toSet(),
      state: RepetitionState.begin,
      index: initialIndex,
      listId: listId,
      firstLanguage: firstLanguage,
      secondLanguage: secondLanguage,
    );
  }

  Repetition start() {
    return changeState(RepetitionState.process);
  }

  Repetition restart() {
    return copyWith(
      knownWords: const {},
      unknownWords: const {},
    ).changeState(RepetitionState.process);
  }

  Repetition end() {
    return changeState(RepetitionState.end);
  }

  Repetition repeatWords({required int initialIndex, bool all = true}) {
    return copyWith(
      usingWords: all ? _allWords : _unknownWords,
      index: initialIndex,
    );
  }

  Repetition changeState(RepetitionState state) {
    return copyWith(state: state);
  }

  Repetition changeIndex(int? index) {
    return copyWith(index: index);
  }

  Repetition passWord({required String id, bool? known}) {
    Set<String> knowns = _knownWords.toSet();
    Set<String> unknowns = _unknownWords.toSet();
    if (known == null) {
      knowns.remove(id);
      unknowns.remove(id);
    } else {
      if (known) {
        unknowns.remove(id);
        knowns.add(id);
      } else {
        knowns.remove(id);
        unknowns.add(id);
      }
    }
    return copyWith(knownWords: knowns, unknownWords: unknowns);
  }
}
