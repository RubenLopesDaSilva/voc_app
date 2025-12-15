import 'package:flutter_test/flutter_test.dart';
import 'package:voc_app/src/features/words/domain/word.dart';

void main() {
  test('Word can be instantiated', () {
    const word = Word(
      id: '1',
      userId: '1',
      trad: {'fr': 'rire', 'en': 'laugh'},
      phonetics: {'fr': 'ʁiʁ'},
    );

    expect(word.id, '1');
    expect(word.trad['fr'], 'rire');
    expect(word.phonetics!['fr'], 'ʁiʁ');
  });
  test('Word equality works', () {
    const word1 = Word(
      id: '1',
      userId: '1',
      trad: {'fr': 'rire'},
      phonetics: {'fr': 'ʁiʁ'},
    );

    const word2 = Word(
      id: '1',
      userId: '1',
      trad: {'fr': 'rire'},
      phonetics: {'fr': 'ʁiʁ'},
    );

    expect(word1, equals(word2));
    expect(word1.hashCode, equals(word2.hashCode));
    expect(word1.phonetics!['fr'], equals(word2.phonetics!['fr']));
  });
  test('Word copyWith overrides only given fields', () {
    const word = Word(
      id: '1',
      userId: '1',
      trad: {'fr': 'rire'},
      phonetics: {'fr': 'ʁiʁ'},
    );

    final copy = word.copyWith(id: '2');

    expect(copy.id, '2');
    expect(copy.trad, word.trad);
    expect(copy.userId, word.userId);
    expect(copy.phonetics!['fr'], 'ʁiʁ');
  });
  test('Word toJson returns correct map', () {
    const word = Word(
      id: '1',
      userId: '1',
      trad: {'fr': 'rire'},
      phonetics: {'fr': 'ʁiʁ'},
    );

    final json = word.toJson();

    expect(json['_id'], '1'); // important chez toi
    expect(json['userId'], '1');
    expect(json['trad']['fr'], 'rire');
    expect(json['phonetics']['fr'], 'ʁiʁ');
  });
  test('Word fromJson creates Word correctly', () {
    final json = {
      '_id': '1',
      'userId': '1',
      'trad': {'fr': 'rire'},
      'phonetics': {'fr': 'ʁiʁ'},
    };

    final word = Word.fromJson(json);

    expect(word.id, '1');
    expect(word.trad['fr'], 'rire');
    expect(word.userId, '1');
    expect(word.phonetics!['fr'], 'ʁiʁ');
  });
  test('Word toString', () {
    const word = Word(
      id: '1',
      userId: '1',
      trad: {'fr': 'rire'},
      phonetics: {'fr': 'ʁiʁ'},
    );
    expect(
      word.toString(),
      'Word(\n  id: ${word.id},\n  userId: ${word.userId},\n  trad: ${word.trad},\n  definitions: ${word.definitions},\n  phonetics: ${word.phonetics},\n)\n',
    );
  });
}
