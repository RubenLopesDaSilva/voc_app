import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:voc_app/src/constants/test_datas.dart';
import 'package:voc_app/src/features/words/presentation/widgets/word_card.dart';

class WordScreen extends StatefulWidget {
  const WordScreen({super.key});

  @override
  State<WordScreen> createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  final swipeController = CardSwiperController();
  int? actualIndex = 0;
  List<String> knownWords = <String>[];
  List<String> unKnownWords = <String>[];

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
                  if (direction.isCloseTo(CardSwiperDirection.left) &&
                      currentIndex != null) {
                    unKnownWords.add(words[previousIndex].id);
                  }
                  if (direction.isCloseTo(CardSwiperDirection.right) &&
                      currentIndex != null) {
                    print("knownWords add ${words[previousIndex].trad['fr']}");
                    knownWords.add(words[previousIndex].id);
                  }
                  actualIndex = currentIndex;
                  return true;
                },
                onUndo: (previousIndex, currentIndex, direction) {
                  //TODO remove word from lists
                  actualIndex = currentIndex;
                  return true;
                },
              ),
            ),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
