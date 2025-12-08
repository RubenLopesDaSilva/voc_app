import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:voc_app/src/common/constants/gap.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/constants/test_datas.dart';
import 'package:voc_app/src/common/localization/string_hardcoded.dart';
import 'package:voc_app/src/common/theme/theme.dart';
import 'package:voc_app/src/common/widgets/styled_button.dart';
import 'package:voc_app/src/common/widgets/styled_icon.dart';
import 'package:voc_app/src/common/widgets/styled_text.dart';
import 'package:voc_app/src/features/groups/domain/group.dart';
import 'package:voc_app/src/features/repetition/models/repetition.dart';
import 'package:voc_app/src/features/repetition/presentation/widgets/end_card.dart';
import 'package:voc_app/src/features/repetition/presentation/widgets/info_panel.dart';
import 'package:voc_app/src/features/repetition/presentation/widgets/word_card.dart';
import 'package:voc_app/src/common/widgets/common_progress_indicator.dart';
import 'package:voc_app/src/common/widgets/option_panel.dart';
import 'package:voc_app/src/features/words/domain/word.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((duration) async {
      //TODO : Implémenter historique
      // await Future.delayed(const Duration(seconds: 3));
      // swipeController.swipe(CardSwiperDirection.left);
      // print("$duration");
    });
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
                    'Contient ${group.words.length > 1
                            ? '${group.words.length} mots'
                            : group.words.length == 1
                            ? 'un mot'
                            : 'aucun mot'}'
                        .hardcoded,
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
        children.addAll([]);
        break;
      case RepetitionState.process:
        if (repetition.index < words.length) {
          children.addAll([
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
                    const StyledIcon(Icons.replay, onPressed: null),
                    gapW3,
                    StyledIcon(
                      // Icons.arrow_upward,
                      Icons.arrow_back,
                      // Icons.arrow_downward,
                      // Icons.arrow_back_ios,
                      onPressed: () {
                        swipeController.undo();
                      },
                    ),
                    gapW3,
                    StyledIcon(
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
                  cardsCount: words.isNotEmpty ? words.length : 1,
                  numberOfCardsDisplayed: words.length > 5
                      ? 5
                      : words.isNotEmpty
                      ? words.length
                      : 1,
                  isLoop: false,
                  initialIndex: repetition.index,
                  allowedSwipeDirection: const AllowedSwipeDirection.only(
                    left: true,
                    right: true,
                  ),
                  onSwipe: (previousIndex, currentIndex, direction) {
                    if (previousIndex < words.length) {
                      if (direction.isCloseTo(CardSwiperDirection.left)) {
                        passWord(id: words[previousIndex].id, known: false);
                      }
                      if (direction.isCloseTo(CardSwiperDirection.right)) {
                        passWord(id: words[previousIndex].id, known: true);
                      }
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
                    repetition = repetition
                        .changeIndex(repetition.index + 1)
                        .end();
                    setState(() {});
                  },
                  cardBuilder:
                      (
                        context,
                        index,
                        horizontalOffsetPercentage,
                        verticalOffsetPercentage,
                      ) {
                        if (index < words.length) {
                          final Word word = words[index];
                          return WordCard(
                            key: Key(word.id),
                            word: word,
                            actif: index == repetition.index,
                            firstLanguage: 'fr',
                            secondLanguage: 'en',
                          );
                        } else {
                          return EndCard(title: "Fin de Repetition".hardcoded);
                        }
                      },
                ),
              ),
            ),
            gapH6,
            expandH1,
          ]);
        }
        break;
      case RepetitionState.end:
        children.addAll([
          expandH4,
          OptionPanel(
            width: Sizes.p100,
            children: [
              gapH3,
              StyledHeadline(
                'Vous connaissez ${(100 * repetition.knownCount / repetition.usingCount).round()} % des ${repetition.usingCount} mots'
                    .hardcoded,
              ),
              gapH6,
              StyledButton(
                width: Sizes.p60,
                height: Sizes.p10,
                onPressed: repetition.index < words.length
                    ? () {
                        repetition = repetition.changeState(
                          RepetitionState.process,
                        );
                        setState(() {});
                      }
                    : null,
                child: StyledHeadline(
                  'Retour à la repetition actuelle'.hardcoded,
                ),
              ),
            ],
          ),
          gapH6,
          OptionPanel(
            width: Sizes.p100,
            children: [
              gapH3,
              StyledHeadline(
                'Vous connaissez ${repetition.knownCount} mots'.hardcoded,
              ),
              gapH6,
              StyledButton(
                width: Sizes.p40,
                height: Sizes.p10,
                onPressed: () {
                  repetition = repetition
                      .repeatWords(initialIndex: 0)
                      .restart();
                  words = testWords
                      .where(
                        (word) => repetition.allUsingWords.contains(word.id),
                      )
                      .toList();
                  setState(() {});
                },
                child: StyledHeadline('Répeter à nouveau'.hardcoded),
              ),
            ],
          ),
          gapH6,
          OptionPanel(
            width: Sizes.p100,
            children: [
              gapH3,
              StyledHeadline(
                'Vous ne connaissez pas ${repetition.unknownCount} mots'
                    .hardcoded,
              ),
              gapH6,
              StyledButton(
                width: Sizes.p70,
                height: Sizes.p10,
                onPressed: repetition.unknownCount > 0
                    ? () {
                        repetition = repetition
                            .repeatWords(initialIndex: 0, all: false)
                            .restart();
                        words = testWords
                            .where(
                              (word) =>
                                  repetition.allUsingWords.contains(word.id),
                            )
                            .toList();
                        setState(() {});
                      }
                    : null,
                child: StyledHeadline(
                  'Répeter seulement les mots pas sue'.hardcoded,
                ),
              ),
            ],
          ),
          gapH6,
          OptionPanel(
            width: Sizes.p100,
            children: [
              gapH3,
              StyledHeadline('Vous avez répétez cette liste 20 fois'.hardcoded),
              gapH6,
              StyledButton(
                width: Sizes.p50,
                height: Sizes.p10,
                child: StyledHeadline('Arrêter cette repetition'.hardcoded),
              ),
            ],
          ),
          expandH4,
        ]);
        break;
    }

    return children;
  }
}
