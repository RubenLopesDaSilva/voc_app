import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/constants/test_datas.dart';
import 'package:voc_app/src/common/widgets/styled_option.dart';
import 'package:voc_app/src/features/repetition/data/repetition_repository.dart';
import 'package:voc_app/src/features/words/presentation/widgets/word_card.dart';
import 'package:voc_app/src/common/widgets/common_progress_indicator.dart';
import 'package:voc_app/src/common/widgets/option_panel.dart';

class WordScreen extends StatefulWidget {
  const WordScreen({super.key});

  @override
  State<WordScreen> createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  RepetitionRepository repository = RepetitionRepository();
  Widget component = const SizedBox();
  final List<Widget> children = <Widget>[];

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

  void changeWidget() {
    children.clear();
    switch (repository.state) {
      case Etat.begin:
        break;
      case Etat.process:
        children.add(
          Center(
            child: SizedBox(
              width: 400,
              height: 280,
              child: CardSwiper(
                controller: swipeController,
                cardsCount: testWords.length,
                numberOfCardsDisplayed: 5,
                isLoop: false,
                onSwipe: (previousIndex, currentIndex, direction) {
                  if (direction.isVertical) {
                    swipeController.undo();
                    return false;
                  }
                  if (direction.isCloseTo(CardSwiperDirection.left)) {
                    passWord(id: testWords[previousIndex].id, known: false);
                  }
                  if (direction.isCloseTo(CardSwiperDirection.right)) {
                    passWord(id: testWords[previousIndex].id, known: true);
                  }
                  actualIndex = currentIndex;
                  return true;
                },
                onUndo: (previousIndex, currentIndex, direction) {
                  passWord(id: testWords[currentIndex].id);
                  actualIndex = currentIndex;
                  return true;
                },
                onEnd: () {
                  //TODO end
                },
                cardBuilder:
                    (
                      context,
                      index,
                      horizontalOffsetPercentage,
                      verticalOffsetPercentage,
                    ) {
                      final word = testWords[index];
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
              ),
            ),
          ),
        );
        break;
      case Etat.end:
        break;
    }
    // component = Center(
    //   child: SizedBox(
    //     width: 400,
    //     height: 280,
    //     child: CardSwiper(
    //       controller: swipeController,
    //       cardsCount: testWords.length,
    //       numberOfCardsDisplayed: 5,
    //       isLoop: false,
    //       onSwipe: (previousIndex, currentIndex, direction) {
    //         if (direction.isVertical) {
    //           swipeController.undo();
    //           return false;
    //         }
    //         if (direction.isCloseTo(CardSwiperDirection.left)) {
    //           passWord(id: testWords[previousIndex].id, known: false);
    //         }
    //         if (direction.isCloseTo(CardSwiperDirection.right)) {
    //           passWord(id: testWords[previousIndex].id, known: true);
    //         }
    //         actualIndex = currentIndex;
    //         return true;
    //       },
    //       onUndo: (previousIndex, currentIndex, direction) {
    //         passWord(id: testWords[currentIndex].id);
    //         actualIndex = currentIndex;
    //         return true;
    //       },
    //       onEnd: () {
    //         //TODO end
    //       },
    //       cardBuilder:
    //           (
    //             context,
    //             index,
    //             horizontalOffsetPercentage,
    //             verticalOffsetPercentage,
    //           ) {
    //             final word = testWords[index];
    //             return WordCard(
    //               key: Key(word.id),
    //               word: word,
    //               color: Colors.grey,
    //               textColor: Colors.black,
    //               actif: index == actualIndex,
    //               firstLanguage: 'fr',
    //               secondLanguage: 'en',
    //             );
    //           },
    //     ),
    //   ),
    // );
  }

  @override
  void initState() {
    super.initState();
    changeWidget();
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
          const Expanded(child: SizedBox()),
          OptionPanel(
            width: Sizes.p400,
            title: CommonProgressIndicator(
              passed: knownWords.length,
              other: unknownWords.length,
              total: testWords.length,
            ),
            //TODO Implementer method pour options
            options: [
              const StyledOption(Icons.replay, onPressed: null),
              gapW12,
              StyledOption(
                // Icons.arrow_upward,
                Icons.arrow_back,
                // Icons.arrow_downward,
                // Icons.arrow_back_ios,
                onPressed: () {
                  swipeController.undo();
                },
              ),
              gapW12,
              const StyledOption(Icons.close, onPressed: null),
            ],
          ),
          gapH64,
          component,
          gapH24,
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
