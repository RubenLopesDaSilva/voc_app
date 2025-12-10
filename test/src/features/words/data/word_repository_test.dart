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
    test('addWord envoie le bon body et retourne le Word avec id', () async {
      const fakeId = 'FAKE_ID';
      const wordToAdd = Word(
        id: '',
        trad: {'fr': 'rire', 'en': 'laugh'},
        userId: '1',
        phonetics: {'fr': 'ʁiʁ', 'en': 'lɑːf'},
        definitions: {},
      );

      when(
        () => mockDio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/voc/addW'),
          statusCode: 201,
          data: wordToAdd.copyWith(id: fakeId).toJson(),
        ),
      );
      final result = await repository.addWord(wordToAdd);

      verify(
        () => mockDio.post(
          '/voc/addW',
          data: wordToAdd.toJson(),
          options: any(named: 'options'),
        ),
      ).called(1);

      expect(result!.id, fakeId);
      expect(result.trad, wordToAdd.trad);
      expect(result.userId, wordToAdd.userId);
      expect(result.phonetics, wordToAdd.phonetics);
    });

    test('delWord calls Dio.delete and succeeds', () async {
      when(() => mockDio.delete('/voc/word/5',options: any(named: 'options'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/voc/word/5'),
          statusCode: 200,
        ),
      );

      await repository.delWord('5');

      verify(() => mockDio.delete('/voc/word/5',options: any(named: 'options'))).called(1);
    });
    test('fetchWordsByIds calls Dio.get(list) and succeeds', () async {
      const listIds = <String>['1', '2', '3'];
      const List<Word> words = [
        Word(
          id: '1',
          trad: {'fr': 'rire', 'en': 'laugh'},
          userId: '1',
          phonetics: {},
        ),
        Word(
          id: '2',
          trad: {'fr': 'poubelle', 'en': 'bin'},
          userId: '1',
          phonetics: {},
        ),
        Word(
          id: '3',
          trad: {'fr': 'force', 'en': 'strength'},
          userId: '1',
          phonetics: {},
        ),
      ];
      when(
        () => mockDio.get(
          any(),
          options: any(named: 'options'),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/voc/searchW'),
          statusCode: 200,
          data: words.map((e) => e.toJson()).toList(),
        ),
      );

      final result = await repository.fetchWordsByIds(listIds);

      verify(
        () => mockDio.get(
          '/voc/searchW',
          options: any(named: 'options'),
          queryParameters: {'listeId': listIds},
        ),
      ).called(1);

      expect(result.length, words.length);
      expect(result, words);
    });
    test(
      'fetchAllWords returns all words available and calls Dio.get and succeeds',
      () async {
        const List<Word> words = [
          Word(
            id: '1',
            trad: {'fr': 'rire', 'en': 'laugh'},
            userId: '1',
            phonetics: {},
          ),
          Word(
            id: '2',
            trad: {'fr': 'poubelle', 'en': 'bin'},
            userId: '1',
            phonetics: {},
          ),
          Word(
            id: '3',
            trad: {'fr': 'force', 'en': 'strength'},
            userId: '3',
            phonetics: {},
          ),
          Word(
            id: '4',
            trad: {'fr': 'coffre', 'en': 'chest'},
            userId: '1',
            phonetics: {},
          ),
          Word(
            id: '5',
            trad: {'fr': 'jambes', 'en': 'legs'},
            userId: '2',
            phonetics: {},
          ),
        ];
        when(
          () => mockDio.get(any(), options: any(named: 'options')),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/voc'),
            statusCode: 200,
            data: words.map((e) => e.toJson()).toList(),
          ),
        );

        final result = await repository.fetchAllWords();

        verify(
          () => mockDio.get('/voc', options: any(named: 'options')),
        ).called(1);

        expect(result.length, words.length);
        expect(result, words);
      },
    );
  });
}
