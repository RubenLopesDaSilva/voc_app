import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voc_app/src/features/groups/data/mongo_group_repository.dart';
import 'package:voc_app/src/features/groups/domain/group.dart';

abstract class GroupRepository {
  Future<List<Group>> fetchGroups();

  Future<List<Group>> fetchGroupsByUserId(String userId);

  Future<Group?> fetchGroupBy(String id);

  Future<Group?> addGroup(Group group);

  Future<void> delGroup(String groupId);
}

final groupRepositoryProvider = Provider<GroupRepository>(
  // (ref) => FakeGroupRepository(),
  (ref) => MongoGroupRepository(),
);

final groupListFutureProvider = FutureProvider.autoDispose<List<Group>>((ref) {
  final wordRepository = ref.watch(groupRepositoryProvider);
  return wordRepository.fetchGroups();
});

final groupFutureProviderBy = FutureProvider.family<Group?, String>((ref, id) {
  final wordRepository = ref.watch(groupRepositoryProvider);
  return wordRepository.fetchGroupBy(id);
});
