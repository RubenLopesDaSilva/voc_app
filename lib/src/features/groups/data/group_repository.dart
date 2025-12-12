import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:voc_app/src/features/groups/domain/group.dart';

class GroupRepository {
  final Dio dio;
  final logger = Logger();

  GroupRepository({Dio? dio})
    : dio = dio ?? Dio(BaseOptions(baseUrl: 'http://localhost:3000'));

  Future<List<Group>> fetchGroups() async {
    try {
      final res = await dio.get('/voc/group');
      final datas = (res.data as List)
          .map((data) => Group.fromJson(data))
          .toList();
      return datas;
    } catch (e) {
      logger.e(e.toString());
      return List.empty();
    }
  }

  Future<List<Group>> fetchGroupsByUserId(String userId) async {
    try {
      final res = await dio.get(
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
      return List.empty();
    }
  }

  Future<Group?> fetchGroupBy(String id) async {
    try {
      final res = await dio.get(
        '/voc/group/$id',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      print('${res.data}');
      final statusCode = res.statusCode!;
      if (statusCode / 100 != 2) {
        throw Exception(statusCode);
      }
      final data = Group.fromJson(res.data);
      return data;
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
  }

  Future<Group?> addGroup(Group group) async {
    try {
      final res = await dio.post(
        '/voc/addG',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: jsonEncode(group),
      );
      final statusCode = res.statusCode!;
      if (statusCode / 100 != 2) {
        throw Exception(statusCode);
      }
      return Group.fromJson(res.data);
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
  }

  Future<void> delGroup(String groupId) async {
    try {
      final res = await dio.delete('/voc/group/$groupId');
      final statusCode = res.statusCode!;
      if (statusCode / 100 != 2) {
        throw Exception(statusCode);
      }
    } catch (e) {
      logger.e(e.toString());
      return;
    }
  }
}

final groupRepositoryProvider = Provider<GroupRepository>((ref) {
  return GroupRepository();
});

final groupListFutureProvider = FutureProvider.autoDispose<List<Group>>((ref) {
  final wordRepository = ref.watch(groupRepositoryProvider);
  // throw Error();
  return wordRepository.fetchGroups();
});

final groupFutureProviderBy = FutureProvider.family<Group?, String>((ref, id) {
  final wordRepository = ref.watch(groupRepositoryProvider);
  return wordRepository.fetchGroupBy(id);
});
