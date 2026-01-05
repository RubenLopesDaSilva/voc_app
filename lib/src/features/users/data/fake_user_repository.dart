import 'package:voc_app/src/features/users/data/user_repository.dart';
import 'package:voc_app/src/features/users/domain/user.dart';

class FakeUserRepository implements UserRepository {
  @override
  Future<List<User>> fetchUsers() {
    throw UnimplementedError();
  }

  @override
  Future<User?> login(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Future<User?> signUp(String email, String password, String userName) {
    throw UnimplementedError();
  }
}
