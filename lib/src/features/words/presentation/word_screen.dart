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
  int? actualIndeex = 0;

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
                      return WordCard(word: words[index], color: Colors.white);
                    },
                cardsCount: words.length,
                numberOfCardsDisplayed: 5,
                onSwipe: (previousIndex, currentIndex, direction) {
                  actualIndeex = currentIndex;
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
