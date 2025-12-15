import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:voc_app/src/features/words/domain/word.dart';

class WordRepository {
  final Dio dio;
  final logger = Logger();

  WordRepository({Dio? dio})
    : dio = dio ?? Dio(BaseOptions(baseUrl: 'http://localhost:3000'));

  Future<List<Word>> fetchAllWords() async {
    try {
      final res = await dio.get(
        '/voc',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      final statusCode = res.statusCode!;
      if ((statusCode / 100) != 2) {
        throw Exception('$statusCode');
      }
      final datas = (res.data as List)
          .map((word) => Word.fromJson(word))
          .toList();
      return datas;
    } catch (e) {
      logger.e(e.toString());
      return List.empty();
    }
  }

  Future<List<Word>> fetchWordsByIds(List<String> wordsId) async {
    try {
      final res = await dio.get(
        '/voc/searchW',
        queryParameters: {'listeId': wordsId},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      final statusCode = res.statusCode!;
      if ((statusCode ~/ 100) != 2) {
        throw Exception(statusCode);
      }
      final datas = (res.data as List)
          .map((data) => Word.fromJson(data))
          .toList();
      return datas;
    } catch (e) {
      logger.e(e.toString());
      return List.empty();
    }
  }

  Future<Word?> addWord(Word word) async {
    try {
      final res = await dio.post(
        '/voc/addW',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: word.toJson(),
      );
      final statusCode = res.statusCode!;
      if ((statusCode ~/ 100)!= 2) {
        throw Exception(statusCode);
      }
      return Word.fromJson(res.data);
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
  }

  Future<void> delWord(String wordId) async {
    try {
      final res = await dio.delete(
        '/voc/word/$wordId',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      final statusCode = res.statusCode!;
      if ((statusCode ~/ 100) != 2) {
        throw Exception(statusCode);
      }
    } catch (e) {
      logger.e(e.toString());
      return;
    }
  }
}
