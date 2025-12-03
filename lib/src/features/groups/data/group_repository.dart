import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:voc_app/src/features/groups/domain/group.dart';

class GroupRepository {
  final _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000'));
  final logger = Logger();

  Future<List<Group>?> fetchGroups() async {
    try {
      final res = await _dio.get('/voc/group');
      final datas = (res.data as List)
          .map((data) => Group.fromJson(data))
          .toList();
      return datas;
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  Future<List<Group>?> fetchGroupsByUserId(String userId) async {
    try {
      final res = await _dio.get(
        '/voc/group',
        queryParameters: {'userId': userId},
      );
      final statusCode = res.statusCode;
      if (statusCode != 200) throw Exception(statusCode);
      final datas = (res.data as List)
          .map((group) => Group.fromJson(group))
          .toList();
      return datas;
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
  }
}
