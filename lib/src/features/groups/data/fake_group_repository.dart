import 'package:voc_app/src/common/constants/test_datas.dart';
import 'package:voc_app/src/features/groups/data/group_repository.dart';
import 'package:voc_app/src/features/groups/domain/group.dart';

class FakeGroupRepository implements GroupRepository {
  @override
  Future<Group?> addGroup(Group group) async {
    testGroups[group.id] = group;
    return group;
  }

  @override
  Future<void> delGroup(String groupId) async {
    testGroups.remove(groupId);
  }

  @override
  Future<Group?> fetchGroupBy(String id) async {
    return testGroups[id];
  }

  @override
  Future<List<Group>> fetchGroups() async {
    return testGroups.values.toList();
  }

  @override
  Future<List<Group>> fetchGroupsByUserId(String userId) async {
    return testGroups.values.where((group) => group.userId == userId).toList();
  }
}
