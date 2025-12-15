import 'package:flutter_test/flutter_test.dart';
import 'package:voc_app/src/features/groups/domain/group.dart';

void main() {
  test('Group copyWith overrides only given fields', () {
    const group = Group(id: '1', name: 'Test1', userId: '1', words: []);
    final copy = group.copyWith(id: '2');

    expect(copy.id, '2');
    expect(copy.name, group.name);
    expect(copy.userId, group.userId);
    expect(copy.words, group.words);
  });
  test('Group toString', () {
    const group = Group(id: '1', name: 'test', userId: '1', words: []);
    expect(
      group.toString(),
      'Group(\n  id: ${group.id},\n  name: ${group.name},\n  words: ${group.words},\n  userId: ${group.userId},\n)\n',
    );
  });
  test('Group equality works', () {
    const group1 = Group(
      id: '1',
      userId: '1',
      name: 'test1',
      words: [],
    );

    const group2 = Group(
      id: '1',
      userId: '1',
      name: 'test1',
      words: [],
    );

    expect(group1, equals(group2));
    expect(group1.hashCode, equals(group2.hashCode));
  });
}
