import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:voc_app/src/common/constants/test_datas.dart';
import 'package:voc_app/src/features/words/models/word.dart';

class RepetitionRepository {
  final List<Word> _words = <Word>[];
  final _swipeController = CardSwiperController();
  final Set<String> _knownWords = <String>{};
  final Set<String> _unknownWords = <String>{};

  int? actualIndex = 0;

  List<Word> get words => _words;
  CardSwiperController get swipeController => _swipeController;
  Set<String> get knownWords => _knownWords;
  Set<String> get unknownWords => _unknownWords;

  void fetchWords() {
    _words.clear();
    for (var word in test_words) {
      _words.add(word);
    }
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
}
