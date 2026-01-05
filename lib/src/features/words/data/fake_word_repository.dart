import 'package:voc_app/src/common/constants/test_datas.dart';
import 'package:voc_app/src/features/words/data/word_repository.dart';
import 'package:voc_app/src/features/words/domain/word.dart';

class FakeWordRepository implements WordRepository {
  @override
  Future<Word?> addWord(Word word) async {
    testWords.add(word);
    return word;
  }

  @override
  Future<void> delWord(String wordId) async {
    testWords.removeWhere((word) => word.id == wordId);
  }

  @override
  Future<List<Word>> fetchAllWords() async {
    return testWords;
  }

  @override
  Future<List<Word>> fetchWordsByIds(List<String> wordsId) async {
    return testWords.where((word) => wordsId.contains(word.id)).toList();
  }
}
