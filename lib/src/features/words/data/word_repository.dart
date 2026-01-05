import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voc_app/src/features/words/data/mongo_word_repository.dart';
import 'package:voc_app/src/features/words/domain/word.dart';

abstract class WordRepository {
  Future<List<Word>> fetchAllWords();

  Future<List<Word>> fetchWordsByIds(List<String> wordsId);

  Future<Word?> addWord(Word word);

  Future<void> delWord(String wordId);
}

final wordRepositoryProvider = Provider<WordRepository>((ref) {
  // return FakeWordRepository();
  return MongoWordRepository();
});

final wordListFutureProvider = FutureProvider.autoDispose<List<Word>>((ref) {
  final wordRepository = ref.watch(wordRepositoryProvider);
  return wordRepository.fetchAllWords();
});
