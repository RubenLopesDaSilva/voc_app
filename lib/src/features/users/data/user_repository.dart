import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:voc_app/src/features/users/domain/user.dart';

class UserRepository {
  final _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000'));
  final logger = Logger();

  Future<List<User>?> fetchUsers() async {
    try {
      final res = await _dio.get('user');
      final statusCode = res.statusCode;
      if (statusCode != 200) {
        throw Exception(statusCode);
      }
      final datas = (res.data as List)
          .map((user) => User.fromJson(user))
          .toList();
      return datas;
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
  }

  Future<User?> signUp(String email, String password, String userName) async {
    try {
      final res = await _dio.put(
        '/auth/signup',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: jsonEncode({
          "userName": userName,
          "email": email,
          "password": password,
        }),
      );
      final statusCode = res.statusCode;
      if (statusCode != 200) {
        throw Exception(statusCode);
      }
      final data = User.fromJson(res.data);
      return data;
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      final res = await _dio.post(
        '/voc/login',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: jsonEncode({'password': password, 'email': email}),
      );
      final statusCode = res.statusCode;
      final body = jsonDecode(res.data);
      if (statusCode != 200) {
        final message = body['message'];
        throw Exception(message);
      }
      final token = body['token'];
      final storage = FlutterSecureStorage();
      await storage.write(key: 'token', value: token);
      return User(id: '', username: '', email: '');
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
  }
}
