import 'package:voc_app/src/common/constants/test_datas.dart';
import 'package:voc_app/src/features/groups/data/group_repository.dart';
import 'package:voc_app/src/features/groups/domain/group.dart';

class FakeGroupRepository implements GroupRepository {
  @override
  Future<Group?> addGroup(Group group) async {
    testGroups[group.id] = group;
    await Future.delayed(const Duration(seconds: 2));
    return group;
  }

  @override
  Future<void> delGroup(String groupId) async {
    testGroups.remove(groupId);
  }

  @override
  Future<Group?> fetchGroupBy(String id) async {
    await Future.delayed(const Duration(seconds: 2));
    return testGroups[id];

  }

  @override
  Future<List<Group>> fetchGroups() async {
    await Future.delayed(const Duration(seconds: 2));
    return testGroups.values.toList();
  }

  @override
  Future<List<Group>> fetchGroupsByUserId(String userId) async {
    await Future.delayed(const Duration(seconds: 2));
    return testGroups.values.where((group) => group.userId == userId).toList();
  }
}
