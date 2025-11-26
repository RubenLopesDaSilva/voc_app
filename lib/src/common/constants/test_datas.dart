import 'package:flutter/material.dart';
import 'package:voc_app/src/features/words/models/word.dart';

final words = <Word>[
  Word(
    id: '1',
    traductions: {'en': 'apple', 'fr': 'pomme'},
    phonetics: {'en': 'apple', 'fr': 'pomme'},
    definitions: {},
    userId: '1',
  ),
  Word(
    id: '2',
    traductions: {'en': 'pineapple', 'fr': 'ananas'},
    phonetics: {'en': 'pineapple', 'fr': 'ananas'},
    definitions: {},
    userId: '1',
  ),
  Word(
    id: '3',
    traductions: {'en': 'tomato', 'fr': 'tomate'},
    phonetics: {'en': 'tomato', 'fr': 'tomate'},
    definitions: {},
    userId: '1',
  ),
  Word(
    id: '4',
    traductions: {'en': 'strawberry', 'fr': 'fraise'},
    phonetics: {'en': 'strawberry', 'fr': 'fraise'},
    definitions: {},
    userId: '1',
  ),
  Word(
    id: '5',
    traductions: {'en': 'carrot', 'fr': 'carrotte'},
    phonetics: {'en': 'carrot', 'fr': 'carrotte'},
    definitions: {},
    userId: '1',
  ),
];

final colors = <Color>[
  Colors.deepPurple,
  Colors.purple,
  Colors.red,
  Colors.deepOrange,
  Colors.orange,
  Colors.green,
];
