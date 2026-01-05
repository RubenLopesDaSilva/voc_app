import 'package:voc_app/src/features/users/domain/user.dart';

abstract class UserRepository {
  Future<List<User>> fetchUsers();

  Future<User?> signUp(String email, String password, String userName);

  Future<User?> login(String email, String password);
}
