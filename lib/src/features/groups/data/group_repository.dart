import 'package:voc_app/src/features/groups/domain/group.dart';

abstract class GroupRepository {
  Future<List<Group>> fetchGroups();

  Future<List<Group>> fetchGroupsByUserId(String userId);

  Future<Group?> fetchGroupBy(String id);

  Future<Group?> addGroup(Group group);

  Future<void> delGroup(String groupId);
}
