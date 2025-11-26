import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:voc_app/src/features/words/models/word.dart';

class WordService {
  final _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000'));
  final logger = Logger();

  Future<List<Word>?> fetchWords() async {
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

  Future<List<Word>?> fetchWordsById(List<String> wordsId) async {
    try {
      final response = <dynamic>[];
      for (int i = 0; i < wordsId.length; i++) {
        final res = await _dio.get(
          '/voc/searchW',
          queryParameters: {'id': wordsId[i]},
        );
        final statusCode = res.statusCode;
        if (statusCode != 200) {
          logger.w(statusCode);
          continue;
        }
        response.add(res.data);
      }
      final datas = (response).map((data) => Word.fromJson(data)).toList();
      return datas;
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
  }
}
