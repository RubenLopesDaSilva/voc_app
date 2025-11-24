import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:voc_app/src/features/words/models/word.dart';

class WordCard extends StatelessWidget {
  const WordCard({
    required this.word,
    required this.color,
    required this.actif,
    required this.firstLanguage,
    required this.secondLanguage,
    super.key,
  });

  final Word word;
  final Color color;
  final bool actif;
  final String firstLanguage;
  final String secondLanguage;

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      controller: FlipCardController(),
      rotateSide: RotateSide.bottom,
      animationDuration: Duration(seconds: 1),
      axis: FlipAxis.horizontal,
      onTapFlipping: actif,
      frontWidget: CardSide(
        title: word.trad[firstLanguage].toString(),
        color: color,
      ),
      backWidget: CardSide(
        title: word.trad[secondLanguage].toString(),
        color: color,
      ),
    );
  }
}

class CardSide extends StatelessWidget {
  const CardSide({required this.title, required this.color, super.key});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 240,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black, width: 4.0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
