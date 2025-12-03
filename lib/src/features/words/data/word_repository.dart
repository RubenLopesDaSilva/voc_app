import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:voc_app/src/features/words/domain/word.dart';

class WordRepository {
  final _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000'));
  final logger = Logger();

  Future<List<Word>?> fetchAllWords() async {
    try {
      final res = await _dio.get('/voc');
      final statusCode = res.statusCode;
      if (statusCode != 200) {
        throw Exception('$statusCode');
      }
      final datas = (res.data as List)
          .map((word) => Word.fromJson(word))
          .toList();
      return datas;
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  Future<List<Word>?> fetchWordsByIds(List<String> wordsId) async {
    try {
      final res = await _dio.get(
        '/voc/searchW',
        queryParameters: {'listeId': wordsId},
      );
      final statusCode = res.statusCode;
      if (statusCode != 200) {
        logger.w(statusCode);
      }
      final datas = (res.data as List)
          .map((data) => Word.fromJson(data))
          .toList();
      return datas;
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
  }
}
