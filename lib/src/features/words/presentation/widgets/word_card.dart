import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:voc_app/src/features/words/models/word.dart';

class WordCard extends StatelessWidget {
  const WordCard({
    required this.word,
    required this.color,
    required this.textColor,
    required this.actif,
    required this.firstLanguage,
    required this.secondLanguage,
    super.key,
  });

  final Word word;
  final Color color;
  final Color textColor;
  final bool actif;
  final String firstLanguage;
  final String secondLanguage;

  //TODO animation si actif pour changer la couleur plus doucement

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      controller: FlipCardController(),
      rotateSide: RotateSide.bottom,
      animationDuration: Duration(milliseconds: 600),
      axis: FlipAxis.horizontal,
      onTapFlipping: actif,
      frontWidget: CardSide(
        title: word.traductions[firstLanguage].toString(),
        phonetic: word.phonetics[firstLanguage].toString(),
        color: color,
        textColor: actif ? textColor : color,
      ),
      backWidget: CardSide(
        title: word.traductions[secondLanguage].toString(),
        phonetic: word.phonetics[secondLanguage].toString(),
        color: color,
        textColor: actif ? textColor : color,
      ),
    );
  }
}

class CardSide extends StatelessWidget {
  const CardSide({
    required this.title,
    required this.phonetic,
    required this.color,
    required this.textColor,
    super.key,
  });

  final String title;
  final String phonetic;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 240,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: textColor, width: 4.0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(phonetic, style: TextStyle(color: textColor, fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
