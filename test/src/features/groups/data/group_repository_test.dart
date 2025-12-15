import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:voc_app/src/features/groups/data/group_repository.dart';
import 'package:voc_app/src/features/groups/domain/group.dart';

import '../../mock.dart';

void main() {
  group('Group', () {
    late MockDio mockDio;
    late GroupRepository repository;

    setUp(() {
      mockDio = MockDio();
      repository = GroupRepository(dio: mockDio);
    });
    setUpAll(() {
      registerFallbackValue(RequestOptions(path: ''));
    });
    group('addG', () {
      test('addG calls Dio.post and succeeds', () async {
        const fakeId = 'FAKE_ID';
        const groupToAdd = Group(
          id: '',
          name: 'test',
          words: ['1', '2', '3'],
          userId: '1',
        );
        when(
          () => mockDio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/voc/addG'),
            data: groupToAdd.copyWith(id: fakeId).toJson(),
            statusCode: 201,
          ),
        );

        final result = await repository.addGroup(groupToAdd);

        verify(
          () => mockDio.post(
            '/voc/addG',
            data: groupToAdd.toJson(),
            options: any(named: 'options'),
          ),
        ).called(1);

        expect(result!.id, fakeId);
        expect(result.name, groupToAdd.name);
        expect(result.words, groupToAdd.words);
        expect(result.userId, groupToAdd.userId);
      });
      test('addG calls Dio.post but fails and sends an empty data', () async {
        const groupToAdd = Group(
          id: '',
          name: 'test',
          words: ['1', '2', '3'],
          userId: '1',
        );
        when(
          () => mockDio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/voc/addG'),
            data: null,
            statusCode: 500,
          ),
        );

        final result = await repository.addGroup(groupToAdd);

        verify(
          () => mockDio.post(
            '/voc/addG',
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).called(1);

        expect(result, isNull);
      });
    });
    group('delG', () {
      test('delG calls Dio.delete and succeeds', () async {
        when(
          () => mockDio.delete(any(), options: any(named: 'options')),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/voc/group/5'),
            statusCode: 200,
          ),
        );

        await repository.delGroup('5');

        verify(
          () => mockDio.delete('/voc/group/5', options: any(named: 'options')),
        ).called(1);
      });
      test(
        'delG calls Dio.delete bu fails and dosent throw and alert',
        () async {
          when(
            () => mockDio.delete(any(), options: any(named: 'options')),
          ).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(path: '/voc/group/5'),
              statusCode: 500,
            ),
          );

          await repository.delGroup('5');

          verify(
            () =>
                mockDio.delete('/voc/group/5', options: any(named: 'options')),
          ).called(1);
        },
      );
    });
    group('fetchGroupsByUserId', () {
      test('fetchGroupByUserId calls Dio.get(userId) and succeeds', () async {
        const List<Group> list = [
          Group(id: '1', name: 'Test', words: ['1', '2', '3'], userId: '1'),
          Group(id: '2', name: 'Test', words: ['1', '2', '3'], userId: '1'),
        ];
        when(
          () => mockDio.get(
            any(),
            options: any(named: 'options'),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/voc/search'),
            statusCode: 200,
            data: list.map((g) => g.toJson()).toList(),
          ),
        );
        final result = await repository.fetchGroupsByUserId('1');

        verify(
          () => mockDio.get(
            '/voc/search',
            options: any(named: 'options'),
            queryParameters: {'userId': '1'},
          ),
        ).called(1);

        expect(result.length, list.length);
      });
      test(
        'fetchGroupByUserId calls Dio.get(userId) but fails and returns an empty list',
        () async {
          when(
            () => mockDio.get(
              any(),
              options: any(named: 'options'),
              queryParameters: any(named: 'queryParameters'),
            ),
          ).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(path: '/voc/search'),
              statusCode: 500,
              data: List.empty(),
            ),
          );
          final result = await repository.fetchGroupsByUserId('1');

          verify(
            () => mockDio.get(
              '/voc/search',
              options: any(named: 'options'),
              queryParameters: {'userId': '1'},
            ),
          ).called(1);

          expect(result, List.empty());
        },
      );
    });
    group('fetchGroupById', () {
      test('fetchGroupBy returns the right Group by its Id', () async {
        const fakeId = 'FAKE_ID';
        const group = Group(
          id: fakeId,
          name: 'Test',
          words: ['1', '2', '3'],
          userId: '1',
        );
        when(
          () => mockDio.get(any(), options: any(named: 'options')),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/voc/group/$fakeId'),
            statusCode: 200,
            data: group.copyWith(id: fakeId).toJson(),
          ),
        );

        final result = await repository.fetchGroupBy(fakeId);

        verify(
          () =>
              mockDio.get('/voc/group/$fakeId', options: any(named: 'options')),
        ).called(1);

        expect(result, group);
      });
      test(
        'fetchGroupBy calls Dio.get(Id) bu fails and returns an empty data',
        () async {
          const fakeId = 'FAKE_ID';
          when(
            () => mockDio.get(any(), options: any(named: 'options')),
          ).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(path: '/voc/group/$fakeId'),
              statusCode: 500,
              data: null,
            ),
          );

          final result = await repository.fetchGroupBy(fakeId);

          verify(
            () => mockDio.get(
              '/voc/group/$fakeId',
              options: any(named: 'options'),
            ),
          ).called(1);
          expect(result, isNull);
        },
      );
    });
    group('fetchAllGroups', () {
      test('fetchAllGroups calls Dio.get and succeeds', () async {
        const groups = <Group>[
          Group(id: '1', name: 'Test1', words: ['1', '2', '3'], userId: '1'),
          Group(id: '2', name: 'Test2', words: ['4', '5', '6'], userId: '2'),
          Group(id: '3', name: 'Test3', words: ['7', '8', '9'], userId: '4'),
          Group(id: '4', name: 'Test4', words: ['10', '11', '12'], userId: '3'),
          Group(id: '5', name: 'Test5', words: ['13', '14', '15'], userId: '5'),
        ];
        when(
          () => mockDio.get(any(), options: any(named: 'options')),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/voc/group'),
            statusCode: 200,
            data: groups.map((e) => e.toJson()).toList(),
          ),
        );

        final result = await repository.fetchGroups();

        verify(
          () => mockDio.get('/voc/group', options: any(named: 'options')),
        ).called(1);

        expect(result.length, groups.length);
        expect(result, groups);
      });
      test(
        'fetchAllGroups calls Dio.get but fails and returns an empty list',
        () async {
          when(
            () => mockDio.get(any(), options: any(named: 'options')),
          ).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(path: '/voc/group'),
              statusCode: 500,
              data: List.empty(),
            ),
          );

          final result = await repository.fetchGroups();

          verify(
            () => mockDio.get('/voc/group', options: any(named: 'options')),
          ).called(1);

          expect(result, List.empty());
        },
      );
    });
  });
}
