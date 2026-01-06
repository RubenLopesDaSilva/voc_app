import 'package:voc_app/src/common/constants/test_datas.dart';
import 'package:voc_app/src/features/words/data/word_repository.dart';
import 'package:voc_app/src/features/words/domain/word.dart';

class FakeWordRepository implements WordRepository {
  @override
  Future<Word?> addWord(Word word) async {
    testWords.add(word);
    await Future.delayed(const Duration(seconds: 2));
    return word;
  }

  @override
  Future<void> delWord(String wordId) async {
    testWords.removeWhere((word) => word.id == wordId);
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<List<Word>> fetchAllWords() async {
    await Future.delayed(const Duration(seconds: 2));
    return testWords;
  }

  @override
  Future<List<Word>> fetchWordsByIds(List<String> wordsId) async {
    await Future.delayed(const Duration(seconds: 2));
    return testWords.where((word) => wordsId.contains(word.id)).toList();
  }
}
