import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:voc_app/src/features/users/domain/user.dart';

class UserRepository {
  final Dio dio;
  final FlutterSecureStorage storage;
  final logger = Logger();

  UserRepository({Dio? dio, FlutterSecureStorage? storage})
    : dio = dio ?? Dio(BaseOptions(baseUrl: 'http://localhost:3000')),
      storage = storage ?? FlutterSecureStorage();

  Future<List<User>> fetchUsers() async {
    try {
      final res = await dio.get(
        '/auth/user',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      final statusCode = res.statusCode!;
      if (statusCode ~/ 100 != 2) {
        throw Exception(statusCode);
      }
      final datas = (res.data as List)
          .map((user) => User.fromJson(user))
          .toList();
      return datas;
    } catch (e) {
      logger.e(e.toString());
      return <User>[];
    }
  }

  Future<User?> signUp(String email, String password, String userName) async {
    try {
      final res = await dio.post(
        '/auth/signup',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {"userName": userName, "email": email, "password": password},
      );
      final statusCode = res.statusCode!;
      if (statusCode ~/ 100 != 2) {
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
      final res = await dio.post(
        '/auth/login',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {'password': password, 'email': email},
      );
      final statusCode = res.statusCode!;
      final body = res.data;
      if (statusCode ~/ 100 != 2) {
        throw Exception(statusCode);
      }
      final token = body['token'];
      await storage.write(key: 'token', value: token);
      return User(id: body['_id'], username: '', email: email);
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
  }
}
