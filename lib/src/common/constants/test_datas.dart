import 'package:voc_app/src/features/groups/models/group.dart';
import 'package:voc_app/src/features/words/models/word.dart';

final testWords = <Word>[
  const Word(
    id: '1',
    traductions: {'en': 'apple', 'fr': 'pomme'},
    phonetics: {'en': 'apple', 'fr': 'pomme'},
    definitions: {},
    userId: '1',
  ),
  const Word(
    id: '2',
    traductions: {'en': 'pineapple', 'fr': 'ananas'},
    phonetics: {'en': 'pineapple', 'fr': 'ananas'},
    definitions: {},
    userId: '1',
  ),
  const Word(
    id: '3',
    traductions: {'en': 'tomato', 'fr': 'tomate'},
    phonetics: {'en': 'tomato', 'fr': 'tomate'},
    definitions: {},
    userId: '1',
  ),
  const Word(
    id: '4',
    traductions: {'en': 'strawberry', 'fr': 'fraise'},
    phonetics: {'en': 'strawberry', 'fr': 'fraise'},
    definitions: {},
    userId: '1',
  ),
  const Word(
    id: '5',
    traductions: {'en': 'carrot', 'fr': 'carrotte'},
    phonetics: {'en': 'carrot', 'fr': 'carrotte'},
    definitions: {},
    userId: '1',
  ),
  const Word(
    id: '6',
    traductions: {'en': 'meat', 'fr': 'viande'},
    phonetics: {'en': 'meat', 'fr': 'viande'},
    definitions: {},
    userId: '1',
  ),
  const Word(
    id: '7',
    traductions: {'en': 'bread', 'fr': 'pain'},
    phonetics: {'en': 'bread', 'fr': 'pain'},
    definitions: {},
    userId: '1',
  ),
  const Word(
    id: '8',
    traductions: {'en': 'milk', 'fr': 'lait'},
    phonetics: {'en': 'milk', 'fr': 'lait'},
    definitions: {},
    userId: '1',
  ),
  const Word(
    id: '9',
    traductions: {'en': 'cheese', 'fr': 'fromage'},
    phonetics: {'en': 'cheese', 'fr': 'fromage'},
    definitions: {},
    userId: '1',
  ),
  const Word(
    id: '10',
    traductions: {'en': 'tomato', 'fr': 'tomate'},
    phonetics: {'en': 'to-may-to', 'fr': 'to-mat'},
    definitions: {},
    userId: '1',
  ),
  const Word(
    id: '11',
    traductions: {'en': 'football', 'fr': 'football'},
    phonetics: {'en': 'football', 'fr': 'football'},
    definitions: {},
    userId: '1',
  ),
  const Word(
    id: '12',
    traductions: {'en': 'basketball', 'fr': 'basket-ball'},
    phonetics: {'en': 'basketball', 'fr': 'basket-ball'},
    definitions: {},
    userId: '1',
  ),
  const Word(
    id: '13',
    traductions: {'en': 'running', 'fr': 'course'},
    phonetics: {'en': 'running', 'fr': 'course'},
    definitions: {},
    userId: '1',
  ),
  const Word(
    id: '14',
    traductions: {'en': 'swimming', 'fr': 'natation'},
    phonetics: {'en': 'swimming', 'fr': 'natation'},
    definitions: {},
    userId: '1',
  ),
  const Word(
    id: '15',
    traductions: {'en': 'tennis', 'fr': 'tennis'},
    phonetics: {'en': 'tennis', 'fr': 'tennis'},
    definitions: {},
    userId: '1',
  ),
];

final testGroups = const <String, Group>{
  '1': Group(
    id: '1',
    name: 'Food',
    words: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
    userId: '1',
  ),
  '2': Group(
    id: '2',
    name: 'Sport',
    words: ['11', '12', '13', '14', '15'],
    userId: '1',
  ),
};
