import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:voc_app/src/common/constants/gap.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/constants/test_datas.dart';
import 'package:voc_app/src/common/localization/string_hardcoded.dart';
import 'package:voc_app/src/common/theme/theme.dart';
import 'package:voc_app/src/common/widgets/styled_option.dart';
import 'package:voc_app/src/common/widgets/styled_text.dart';
import 'package:voc_app/src/features/groups/models/group.dart';
import 'package:voc_app/src/features/repetition/models/repetition.dart';
import 'package:voc_app/src/features/repetition/presentation/widgets/info_panel.dart';
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
  Group group =
      testGroups['1'] ??
      const Group(id: '0', name: 'name', words: [], userId: '0');
  List<Word> words = [];

  final swipeController = CardSwiperController();

  void passWord({required String id, bool? known}) {
    repetition = repetition.passWord(id: id, known: known);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    repetition = repetition.initialize(
      words: testWords
          .where((word) => group.words.contains(word.id))
          .map((word) => word.id)
          .toList(),
      initialIndex: 0,
      listId: group.id,
      firstLanguage: 'fr',
      secondLanguage: 'en',
    );
    words = testWords
        .where((word) => repetition.allUsingWords.contains(word.id))
        .toList();
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

  List<Widget> children() {
    List<Widget> children = [
      InfoPanel(
        children: [
          Row(
            children: [
              gapW10,
              StyledHeadline('Repetition'.hardcoded, fontSize: Sizes.p10),
              expandH10,
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.account_circle_outlined,
                  color: AppColors.secondaryAccent,
                  size: Sizes.p15,
                ),
              ),
              gapW10,
            ],
          ),
          gapH4,
          const Divider(
            color: AppColors.secondaryAccent,
            thickness: Sizes.p1,
            height: 0,
          ),
          gapH4,
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    children: [
                      StyledHeadline(' ${group.name}', fontSize: Sizes.p6),
                      const StyledHeadline('Burri Simon', fontSize: Sizes.p6),
                    ],
                  ),
                ),
              ),
              gapW4,
              const SizedBox(
                height: Sizes.p20,
                child: VerticalDivider(
                  color: AppColors.secondaryAccent,
                  thickness: Sizes.p1,
                  width: 0,
                ),
              ),
              gapW4,
              Expanded(
                child: Center(
                  child: StyledHeadline(
                    '${'Contient'.hardcoded} ${group.words.length > 1
                        ? '${group.words.length} ${'mots'.hardcoded}'
                        : group.words.length == 1
                        ? '${'un'.hardcoded} ${'mot'.hardcoded}'
                        : '${'aucun'.hardcoded} ${'mot'.hardcoded}'}',
                    fontSize: Sizes.p4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ];
    switch (repetition.state) {
      case RepetitionState.begin:
        break;
      case RepetitionState.process:
        children.addAll(<Widget>[
          gapH16,
          OptionPanel(
            width: Sizes.p100,
            children: [
              gapH3,
              CommonProgressIndicator(
                successful: repetition.knownCount,
                failed: repetition.unknownCount,
                total: repetition.usingCount,
              ),
              gapH6,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const StyledOption(Icons.replay, onPressed: null),
                  gapW3,
                  StyledOption(
                    // Icons.arrow_upward,
                    Icons.arrow_back,
                    // Icons.arrow_downward,
                    // Icons.arrow_back_ios,
                    onPressed: () {
                      swipeController.undo();
                    },
                  ),
                  gapW3,
                  StyledOption(
                    Icons.close,
                    onPressed: () {
                      repetition = repetition.end();
                      setState(() {});
                    },
                  ),
                ],
              ),
            ],
          ),
          gapH16,
          Center(
            child: SizedBox(
              width: 400,
              height: 280,
              child: CardSwiper(
                controller: swipeController,
                cardsCount: words.length,
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
                onEnd: () {
                  repetition = repetition.end();
                  setState(() {});
                },
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
                        actif: index == repetition.index,
                        firstLanguage: 'fr',
                        secondLanguage: 'en',
                      );
                    },
              ),
            ),
          ),
          gapH6,
          expandH1,
        ]);
        break;
      case RepetitionState.end:
        children.addAll(<Widget>[
           
        ]);
        break;
    }
    return children;
  }
}
