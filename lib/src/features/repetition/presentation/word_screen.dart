import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/constants/test_datas.dart';
import 'package:voc_app/src/common/widgets/styled_option.dart';
import 'package:voc_app/src/features/repetition/models/repetition.dart';
import 'package:voc_app/src/features/repetition/presentation/widgets/word_card.dart';
import 'package:voc_app/src/common/widgets/common_progress_indicator.dart';
import 'package:voc_app/src/common/widgets/option_panel.dart';
import 'package:voc_app/src/features/words/models/word.dart';

class WordScreen extends StatefulWidget {
  const WordScreen({super.key});

  @override
  State<WordScreen> createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  Repetition repetition = const Repetition();
  final List<Word> words = testWords;

  final swipeController = CardSwiperController();

  void passWord({required String id, bool? known}) {
    repetition = repetition.passWord(id: id, known: known);
    setState(() {});
  }

  List<Widget> children() {
    switch (repetition.state) {
      case RepetitionState.begin:
        return <Widget>[];
      case RepetitionState.process:
        return <Widget>[
          const Expanded(child: SizedBox()),
          OptionPanel(
            width: Sizes.p400,
            title: CommonProgressIndicator(
              successful: repetition.knownCount,
              failed: repetition.unknownCount,
              total: repetition.usingCount,
            ),
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
                    passWord(id: words[previousIndex].id, known: false);
                  }
                  if (direction.isCloseTo(CardSwiperDirection.right)) {
                    passWord(id: words[previousIndex].id, known: true);
                  }
                  repetition = repetition.changeIndex(currentIndex);
                  return true;
                },
                onUndo: (previousIndex, currentIndex, direction) {
                  passWord(id: words[currentIndex].id);
                  repetition = repetition.changeIndex(currentIndex);
                  return true;
                },
                onEnd: () {},
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
                        actif: index == repetition.index,
                        firstLanguage: 'fr',
                        secondLanguage: 'en',
                      );
                    },
              ),
            ),
          ),
          gapH24,
          const Expanded(child: SizedBox()),
        ];
      case RepetitionState.end:
        return <Widget>[];
    }
  }

  @override
  void initState() {
    super.initState();
    repetition = repetition.initialize(
      words: testWords.map<String>((word) => word.id).toList(),
      initialIndex: 0,
      firstLanguage: 'fr',
      secondLanguage: 'en',
    );
    repetition = repetition.start();
  }

  @override
  void dispose() {
    swipeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: children()));
  }
}
