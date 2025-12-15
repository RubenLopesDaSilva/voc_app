import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:voc_app/src/features/users/data/user_repository.dart';
import 'package:voc_app/src/features/users/domain/user.dart';

import '../../mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('User', () {
    late MockDio mockDio;
    late UserRepository repository;
    late MockStorage mockStorage;
    setUp(() {
      mockStorage = MockStorage();
      mockDio = MockDio();
      repository = UserRepository(dio: mockDio, storage: mockStorage);
    });
    group('fetchAllUsers', () {
      test(
        'fetchAllUsers returns all users available and calls Dio.get',
        () async {
          const users = <User>[
            User(id: '1', username: 'Test1', email: 'test1@gmail.com'),
            User(id: '2', username: 'Test2', email: 'test2@gmail.com'),
            User(id: '3', username: 'Test3', email: 'test3@gmail.com'),
            User(id: '4', username: 'Test4', email: 'test4@gmail.com'),
            User(id: '5', username: 'Test5', email: 'test5@gmail.com'),
          ];
          when(
            () => mockDio.get(any(), options: any(named: 'options')),
          ).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(path: '/auth/user'),
              statusCode: 200,
              data: users.map((e) => e.toJson()).toList(),
            ),
          );

          final result = await repository.fetchUsers();

          verify(
            () => mockDio.get('/auth/user', options: any(named: 'options')),
          ).called(1);

          expect(result.length, users.length);
          expect(result, users);
        },
      );
      test(
        'fetchAllUsers calls Dio.get but fails and returns an empty list',
        () async {
          when(
            () => mockDio.get(any(), options: any(named: 'options')),
          ).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(path: '/auth/user'),
              statusCode: 500,
              data: null,
            ),
          );

          final result = await repository.fetchUsers();

          verify(
            () => mockDio.get('/auth/user', options: any(named: 'options')),
          ).called(1);

          expect(result, List.empty());
        },
      );
    });
    group('signUp', () {
      test('signUp', () async {
        const email = 'test@gmail.com';
        const password = '123456';
        const userName = 'Test';

        final mockUser = {
          '_id': '3',
          'email': email,
          'token': 'new_fake_token',
          'userName': userName,
        };

        when(
          () => mockDio.post(
            any(),
            options: any(named: 'options'),
            data: any(named: 'data'),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/auth/signup'),
            statusCode: 201,
            data: mockUser,
          ),
        );

        final result = await repository.signUp(email, password, userName);

        verify(
          () => mockDio.post(
            '/auth/signup',
            options: any(named: 'options'),
            queryParameters: any(named: 'queryParameters'),
            data: {'email': email, 'password': password, 'userName': userName},
          ),
        ).called(1);

        expect(result!.email, email);
        expect(result.id, mockUser['_id']);
        expect(result.username, mockUser['userName']);
      });
      test(
        'signUp calls Dio.post but fails and dosent create an User and returns an empty User',
        () async {
          const email = 'test@gmail.com';
          const password = '123456';
          const userName = 'Test';

          when(
            () => mockDio.post(
              any(),
              options: any(named: 'options'),
              data: any(named: 'data'),
              queryParameters: any(named: 'queryParameters'),
            ),
          ).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(path: '/auth/signup'),
              statusCode: 500,
              data: null,
            ),
          );

          final result = await repository.signUp(email, password, userName);

          verify(
            () => mockDio.post(
              '/auth/signup',
              options: any(named: 'options'),
              queryParameters: any(named: 'queryParameters'),
              data: {
                'email': email,
                'password': password,
                'userName': userName,
              },
            ),
          ).called(1);
          expect(result, isNull);
        },
      );
    });
    group('login', () {
      test('User login', () async {
        const email = 'test@gmail.com';
        const password = '123456';

        final mockReponseData = {
          '_id': '1',
          'email': email,
          'token': 'fake_jwt_token',
        };

        when(
          () => mockDio.post(
            any(),
            options: any(named: 'options'),
            queryParameters: any(named: 'queryParameters'),
            data: any(named: 'data'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/auth/login'),
            statusCode: 200,
            data: mockReponseData,
          ),
        );

        when(
          () => mockStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        ).thenAnswer((_) async {});

        final result = await repository.login(email, password);

        verify(
          () => mockDio.post(
            '/auth/login',
            options: any(named: 'options'),
            queryParameters: any(named: 'queryParameters'),
            data: {'email': email, 'password': password},
          ),
        ).called(1);

        verify(
          () => mockStorage.write(key: 'token', value: 'fake_jwt_token'),
        ).called(1);

        expect(result!.email, email);
        expect(result.id, mockReponseData['_id']);
      });
      test(
        'login calls Dio.post but fails and dosent connect and send a null User',
        () async {
          const email = 'test@gmail.com';
          const password = '123456';

          when(
            () => mockDio.post(
              any(),
              options: any(named: 'options'),
              queryParameters: any(named: 'queryParameters'),
              data: any(named: 'data'),
            ),
          ).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(path: '/auth/login'),
              statusCode: 500,
              data: null,
            ),
          );

          when(
            () => mockStorage.write(
              key: any(named: 'key'),
              value: any(named: 'value'),
            ),
          ).thenAnswer((_) async {});

          final result = await repository.login(email, password);

          verify(
            () => mockDio.post(
              '/auth/login',
              options: any(named: 'options'),
              queryParameters: any(named: 'queryParameters'),
              data: {'email': email, 'password': password},
            ),
          ).called(1);

          verifyNever(
            () => mockStorage.write(key: 'token', value: 'fake_jwt_token'),
          );

          expect(result, isNull);
        },
      );
    });
  });
}
