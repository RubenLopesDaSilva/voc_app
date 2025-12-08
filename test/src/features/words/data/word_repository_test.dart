import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:voc_app/src/features/words/data/word_repository.dart';
import 'package:voc_app/src/features/words/domain/word.dart';

import '../../mock.dart';

void main() {
  group('Word', () {
    late MockDio mockDio;
    late WordRepository repository;
    setUp(() {
      mockDio = MockDio();
      repository = WordRepository(dio: mockDio);
    });
    setUpAll(() {
      registerFallbackValue(RequestOptions(path: ''));
    });
    //TODO:
    // test('addWord envoie le bon body et retourne le Word avec id', () async {
    //   const fakeId = 'FAKE_ID';
    //   const wordToAdd = Word(
    //     id: '',
    //     trad: {'fr': 'rire', 'en': 'laugh'},
    //     userId: '1',
    //     phonetics: {'fr': 'ʁiʁ', 'en': 'lɑːf'},
    //   );

    //   when(
    //     () => mockDio.post('/voc/addW', data: any(named: 'data')),
    //   ).thenAnswer(
    //     (_) async => Response(
    //       requestOptions: RequestOptions(path: '/voc/addW'),
    //       statusCode: 201,
    //       data: wordToAdd.copyWith(id: fakeId).toJson(),
    //     ),
    //   );

    //   final result = await repository.addWord(wordToAdd.copyWith(id: fakeId));

    //   verify(
    //     () => mockDio.post('/voc/addW', data: wordToAdd.copyWith(id: fakeId).toJson()),
    //   ).called(1);

    //   expect(result!.id, fakeId);
    //   expect(result.trad, wordToAdd.trad);
    //   expect(result.userId, wordToAdd.userId);
    //   expect(result.phonetics, wordToAdd.phonetics);
    // });

    test('delWord calls Dio.delete and succeeds', () async {
      when(() => mockDio.delete('/voc/word/5')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/voc/word/5'),
          statusCode: 200,
        ),
      );

      await repository.delWord('5');

      verify(() => mockDio.delete('/voc/word/5')).called(1);
    });
  });
}
