import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:voc_app/src/features/words/models/word.dart';

class WordCard extends StatelessWidget {
  const WordCard({required this.word, required this.color, super.key});

  final Word word;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      controller: FlipCardController(),
      rotateSide: RotateSide.bottom,
      animationDuration: Duration(seconds: 1),
      axis: FlipAxis.horizontal,
      onTapFlipping: true,
      frontWidget: Container(
        width: 400,
        height: 240,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.black, width: 4.0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            word.trad['fr'].toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      backWidget: Container(
        width: 400,
        height: 240,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.black, width: 4.0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            word.trad['en'].toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
