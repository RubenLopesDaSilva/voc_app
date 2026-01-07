import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/widgets/styled_text.dart';
import 'package:voc_app/src/features/words/domain/word.dart';
import 'package:voc_app/src/common/theme/theme.dart';

class WordCard extends StatelessWidget {
  const WordCard({
    required this.word,
    required this.actif,
    required this.firstLanguage,
    required this.secondLanguage,
    super.key,
  });

  final Word word;
  final bool actif;
  final String firstLanguage;
  final String secondLanguage;

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      controller: FlipCardController(),
      rotateSide: RotateSide.bottom,
      animationDuration: const Duration(milliseconds: 600),
      axis: FlipAxis.horizontal,
      onTapFlipping: actif,
      frontWidget: CardSide(
        title: word.trad[firstLanguage].toString(),
        phonetic: word.phonetics[firstLanguage].toString(),
        actif: actif,
      ),
      backWidget: CardSide(
        title: word.trad[secondLanguage].toString(),
        phonetic: word.phonetics[secondLanguage].toString(),
        actif: actif,
      ),
    );
  }
}

class CardSide extends StatelessWidget {
  const CardSide({
    required this.title,
    required this.phonetic,
    required this.actif,
    super.key,
  });

  final String title;
  final String phonetic;
  final bool actif;

  @override
  Widget build(BuildContext context) {
    const color = AppColors.primaryColor;
    return Container(
      width: 400,
      height: 240,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: actif ? AppColors.primaryAccent : color,
          width: 4.0,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StyledHeadline(
              title,
              color: actif ? null : color,
              fontSize: Sizes.p10,
            ),
            StyledText(phonetic, color: actif ? null : color),
          ],
        ),
      ),
    );
  }
}
