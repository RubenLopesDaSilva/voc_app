import 'package:flutter_test/flutter_test.dart';
import 'package:voc_app/src/features/users/domain/user.dart';

void main() {
  test('User equality works', () {
    const user1 = User(id: '1', username: 'test', email: 'test@email.com');
    const user2 = User(id: '1', username: 'test', email: 'test@email.com');

    expect(user1, equals(user2));
    expect(user1.hashCode, equals(user2.hashCode));
  });
  test('User toString', () {
    const user = User(id: '1', username: 'test', email: 'test@email.com');
    expect(
      user.toString(),
      'User(\n  id: ${user.id},\n  username:${user.username},\n  email:${user.email}\n)\n',
    );
  });
}
