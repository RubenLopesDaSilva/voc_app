import 'package:flutter/material.dart';
import 'package:voc_app/src/features/words/models/word.dart';

final words = <Word>[
  Word(id: '1', trad: {'en': 'apple', 'fr': 'pomme'}, userId: '1'),
  Word(id: '2', trad: {'en': 'pineapple', 'fr': 'ananas'}, userId: '1'),
  Word(id: '3', trad: {'en': 'tomato', 'fr': 'tomate'}, userId: '1'),
  Word(id: '4', trad: {'en': 'strawberry', 'fr': 'fraise'}, userId: '1'),
  Word(id: '5', trad: {'en': 'carrot', 'fr': 'carrotte'}, userId: '1'),
];

final colors = <Color>[
  Colors.deepPurple,
  Colors.purple,
  Colors.red,
  Colors.deepOrange,
  Colors.orange,
  Colors.green,
];
