import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/constants/test_datas.dart';
import 'package:voc_app/src/features/words/presentation/widgets/word_card.dart';
import 'package:voc_app/src/common/widgets/common_progress_indicator.dart';

class WordScreen extends StatefulWidget {
  const WordScreen({super.key});

  @override
  State<WordScreen> createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  final swipeController = CardSwiperController();
  int? actualIndex = 0;
  Set<String> knownWords = <String>{};
  Set<String> unknownWords = <String>{};

  void passWord({required String id, bool? known}) {
    if (known == null) {
      knownWords.remove(id);
      unknownWords.remove(id);
    } else {
      if (known) {
        unknownWords.remove(id);
        knownWords.add(id);
      } else {
        knownWords.remove(id);
        unknownWords.add(id);
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    swipeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: SizedBox()),
          Container(
            width: 480,
            height: 240,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(24),
            child: Center(
              child: Column(
                children: [
                  CommonProgressIndicator(
                    passed: knownWords.length,
                    other: unknownWords.length,
                    total: words.length,
                  ),
                ],
              ),
            ),
          ),
          gapH64,
          Center(
            child: SizedBox(
              width: 400,
              height: 280,
              child: CardSwiper(
                controller: swipeController,
                cardBuilder:
                    (
                      context,
                      index,
                      horizontalOffsetPercentage,
                      verticalOffsetPercentage,
                    ) {
                      final word = words[index];
                      return WordCard(
                        key: Key(word.id),
                        word: word,
                        color: Colors.grey,
                        textColor: Colors.black,
                        actif: index == actualIndex,
                        firstLanguage: 'fr',
                        secondLanguage: 'en',
                      );
                    },
                cardsCount: words.length,
                numberOfCardsDisplayed: 5,
                onSwipe: (previousIndex, currentIndex, direction) {
                  if (direction.isVertical) {
                    swipeController.undo();
                    return false;
                  }
                  if (direction.isCloseTo(CardSwiperDirection.left)) {
                    passWord(id: words[previousIndex].id, known: false);
                  }
                  if (direction.isCloseTo(CardSwiperDirection.right)) {
                    passWord(id: words[previousIndex].id, known: true);
                  }
                  actualIndex = currentIndex;
                  return true;
                },
                onUndo: (previousIndex, currentIndex, direction) {
                  passWord(id: words[currentIndex].id);
                  actualIndex = currentIndex;
                  return true;
                },
                isLoop: false,
              ),
            ),
          ),
          gapH24,

          Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
