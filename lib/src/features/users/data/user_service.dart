import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:voc_app/src/features/users/models/user.dart';

class UserService {
  final _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000/auth'));
  final logger = Logger();

  Future<User?> signUp(String name, String email, String password) async {
    try {
      final res = await _dio.put(
        '/signup',
        options: Options(headers: {'Content-Type': 'applciation/json'}),
        data: jsonEncode({"name": name, "email": email, "password": password}),
      );
      final statuscode = res.statusCode;
      if (statuscode != 201) {
        return null;
      }

      final body = jsonDecode(res.data);
      final userName = body['user']['name'];
      final userEmail = body['user']['email'];
      final userId = body['user']['id'];
      return User(id: userId, username: userName, email: userEmail);
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      final res = await _dio.post(
        '/login',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: jsonEncode({"email": email, "password": password}),
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

  Future<List<User>?> fetchUsers() async {
    try {
      final res = await _dio.get('/auth');
      final statusCode = res.statusCode;
      if (statusCode != 200) {
        throw Exception('$statusCode');
      }
      final datas = (res.data as List)
          .map((data) => User.fromJson(data))
          .toList();
      return datas;
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
  }
}
