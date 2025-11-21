import 'package:flutter/material.dart';
import 'package:voc_app/src/features/words/presentation/widgets/word_card.dart';

class WordScreen extends StatefulWidget {
  const WordScreen({super.key});

  @override
  State<WordScreen> createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: WordCard());
  }
}
