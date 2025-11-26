import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:voc_app/src/common/constants/test_datas.dart';
import 'package:voc_app/src/features/words/models/word.dart';

enum Etat { begin, process, end }

//TODO repetition entité ceux repo sert pour tous les repetitions
class RepetitionRepository {
  final List<Word> _allWords = <Word>[];
  final Set<String> _usingWords = <String>{};
  final Set<String> _knownWords = <String>{};
  final Set<String> _unknownWords = <String>{};
  final _swipeController = CardSwiperController();
  Etat _state = Etat.begin;
  int? _actualIndex = 0;
  String _firstLanguage = '';
  String _secondLanguage = '';

  Set<String> get knownWords => _knownWords;
  Set<String> get unknownWords => _unknownWords;
  CardSwiperController get swipeController => _swipeController;
  Etat get state => _state;
  int? get actualIndex => _actualIndex;
  String get firstLanguage => _firstLanguage;
  String get secondLanguage => _secondLanguage;

  void fetchWords() {
    _allWords.clear();
    for (var word in testWords) {
      _allWords.add(word);
    }
  }

  void repeatAllWords() {
    _usingWords.clear();
    for (Word word in _allWords) {
      _usingWords.add(word.id);
    }
  }

  void repeatUnknownWords() {
    _usingWords.clear();
    for (String id in _unknownWords) {
      _usingWords.add(id);
    }
  }

  List<Word> getUsingWords() {
    return _allWords.where((word) => _usingWords.contains(word.id)).toList();
  }

  void passWord({required String id, bool? known}) {
    if (known == null) {
      knownWords.remove(id);
      unknownWords.remove(id);
    } else {
      if (known) {
        unknownWords.remove(id);
        knownWords.add(id);
      } else {
        knownWords.remove(id);
        unknownWords.add(id);
      }
    }
  }

  void changeState(Etat state) {
    _state = state;
  }
}
