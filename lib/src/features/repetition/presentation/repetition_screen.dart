import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:voc_app/src/common/constants/gap.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/localization/string_hardcoded.dart';
import 'package:voc_app/src/common/theme/theme.dart';
import 'package:voc_app/src/common/utilities/seed.dart';
import 'package:voc_app/src/common/widgets/profile_menu_button.dart';
import 'package:voc_app/src/common/widgets/sense_button.dart';
import 'package:voc_app/src/common/widgets/styled_button.dart';
import 'package:voc_app/src/common/widgets/styled_dropdown.dart';
import 'package:voc_app/src/common/widgets/styled_icon.dart';
import 'package:voc_app/src/common/widgets/styled_text.dart';
import 'package:voc_app/src/features/groups/data/mongo_group_repository.dart';
import 'package:voc_app/src/features/groups/domain/group.dart';
import 'package:voc_app/src/features/repetition/models/repetition.dart';
import 'package:voc_app/src/features/repetition/presentation/widgets/end_card.dart';
import 'package:voc_app/src/common/widgets/info_panel.dart';
import 'package:voc_app/src/features/repetition/presentation/widgets/word_card.dart';
import 'package:voc_app/src/common/widgets/common_progress_indicator.dart';
import 'package:voc_app/src/common/widgets/option_panel.dart';
import 'package:voc_app/src/features/words/data/word_repository.dart';
import 'package:voc_app/src/features/words/domain/word.dart';
import 'package:voc_app/src/navigation/navigation.dart';

class RepetitionScreen extends ConsumerStatefulWidget {
  const RepetitionScreen({required this.groupId, super.key});

  final String groupId;

  @override
  ConsumerState<RepetitionScreen> createState() => _RepetitionScreenState();
}

class _RepetitionScreenState extends ConsumerState<RepetitionScreen> {
  final swipeController = CardSwiperController();

  Repetition repetition = const Repetition();
  Group? group;
  List<Word> words = [];
  List<Word> wordsToUse = [];
  bool loading = false;
  bool groupLoaded = false;

  String firstLanguage = 'fr';
  String secondLanguage = 'en';
  bool sense = true;

  bool get groupNotFound => groupLoaded && group == null;
  bool get ready {
    return group != null &&
        !loading &&
        words.length == group?.words.length &&
        words.isNotEmpty;
  }

  set setWordToUse(List<Word> words) {
    wordsToUse = words.toList();
    wordsToUse.shuffle(Random(repetition.seed));
  }

  void goToRepetitions() {
    context.goNamed(AppRoutes.repetitions.name);
  }

  void start() {
    if (ready) {
      if (group case Group mygroup) {
        repetition = repetition.initialize(
          words: mygroup.words,
          initialIndex: 0,
          seed: newSeed,
          listId: mygroup.id,
          firstLanguage: sense ? firstLanguage : secondLanguage,
          secondLanguage: sense ? secondLanguage : firstLanguage,
        );
        prepareWordsToUse();
        repetition = repetition.start();
        setState(() {});
      }
    }
  }

  void prepareWordsToUse() {
    try {
      setWordToUse = repetition.allUsingWords.map((id) {
        return words.where((word) => word.id == id).first;
      }).toList();
    } catch (e) {
      setWordToUse = words;
    }
  }

  void passWord({required String id, bool? known}) {
    repetition = repetition.passWord(id: id, known: known);
    setState(() {});
  }

  void recommencer({bool all = true}) {
    repetition = repetition
        .repeatWords(initialIndex: 0, all: all)
        .changeSeed(newSeed)
        .restart();
    prepareWordsToUse();
    setState(() {});
  }

  Future<void> fetchGroup(String id) async {
    final MongoGroupRepository groupRepository = ref.read(
      groupRepositoryProvider,
    );
    final fetchedGroup = await groupRepository.fetchGroupBy(id);
    groupLoaded = true;
    if (fetchedGroup != null) {
      loading == true;
      group = fetchedGroup;
      fetchWords(fetchedGroup.words);
    }
    setState(() {});
  }

  Future<void> fetchWords(List<String> ids) async {
    loading = true;
    final WordRepository wordRepository = ref.read(wordRepositoryProvider);
    final fetchedWords = await wordRepository.fetchWordsByIds(ids);
    words = fetchedWords;
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchGroup(widget.groupId);
  }

  @override
  void dispose() {
    swipeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((duration) async {});
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
              ProfileMenuButton(
                children: [
                  gapH5,
                  gapWinfinity,
                  StyledHeadline(
                    'Option de profile'.hardcoded,
                    fontSize: Sizes.p5,
                  ),
                  gapH5,
                  StyledButton(
                    width: Sizes.p75,
                    child: StyledText(
                      'Aller au profile'.hardcoded,
                      fontSize: Sizes.p5,
                    ),
                  ),
                  gapH5,
                  StyledButton(
                    width: Sizes.p75,
                    child: StyledText(
                      'Changer de comptes'.hardcoded,
                      fontSize: Sizes.p5,
                    ),
                  ),
                  gapH5,
                  StyledButton(
                    onPressed: () {
                      context.goNamed(AppRoutes.login.name);
                    },
                    width: Sizes.p75,
                    child: StyledText(
                      'Se déconnecter'.hardcoded,
                      fontSize: Sizes.p5,
                    ),
                  ),
                  gapH5,
                ],
              ),
              gapW5,
            ],
          ),
          // gapH4,
          // const StyledDivider(spacement: 0),
          // gapH4,
          // Row(
          //   children: [
          //     Expanded(
          //       child: Center(
          //         child: Column(
          //           children: [
          //             StyledHeadline(
          //               'Burri Simon'.hardcoded,
          //               fontSize: Sizes.p6,
          //             ),
          //             const StyledHeadline('Rien', fontSize: Sizes.p6),
          //           ],
          //         ),
          //       ),
          //     ),
          //     gapW4,
          //     const SizedBox(
          //       height: Sizes.p20,
          //       child: StyledDivider(horizontal: false, spacement: 0),
          //     ),
          //     gapW4,
          //     Expanded(
          //       child: Center(
          //         child: Column(
          //           children: [
          //             StyledHeadline(
          //               ' ${group?.name ?? 'Aucun'.hardcoded}'.hardcoded,
          //               fontSize: Sizes.p4,
          //             ),
          //             StyledHeadline(
          //               'De Burri Simon'.hardcoded,
          //               fontSize: Sizes.p4,
          //             ),
          //             StyledHeadline(
          //               'Contient ${groupLength > 1
          //                       ? '$groupLength mots'
          //                       : groupLength == 1
          //                       ? 'un mot'
          //                       : 'aucun mot'}'
          //                   .hardcoded,
          //               fontSize: Sizes.p4,
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    ];

    switch (repetition.state) {
      case RepetitionState.begin:
        children.addAll([
          expandH4,
          // OptionPanel(
          //   width: Sizes.p100,
          //   children: [
          //     StyledText(
          //       'Ce group est gérer par Burri Simon'.hardcoded,
          //       fontSize: Sizes.p5,
          //     ),
          //     const StyledDivider(
          //       color: AppColors.secondaryColor,
          //       spacement: Sizes.p10,
          //       indent: Sizes.p4,
          //       endIndent: Sizes.p4,
          //     ),
          //     StyledText(
          //       'Ce group est réussi à 20 %'.hardcoded,
          //       fontSize: Sizes.p5,
          //     ),
          //     const StyledDivider(
          //       color: AppColors.secondaryColor,
          //       spacement: Sizes.p10,
          //       indent: Sizes.p4,
          //       endIndent: Sizes.p4,
          //     ),
          //     StyledText(
          //       'Vous avez repeter ce group 5 fois'.hardcoded,
          //       fontSize: Sizes.p5,
          //     ),
          //   ],
          // ),
          gapH15,
          OptionPanel(
            width: Sizes.p100,
            children: [
              // StyledHeadline(
              //   'Dans quels langues voulez vous répéter ?'.hardcoded,
              //   fontSize: Sizes.p5,
              // ),
              gapH4,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.language,
                    color: AppColors.secondaryAccent,
                    size: Sizes.p10,
                  ),
                  StyledDropdown(
                    width: 100,
                    height: 40,
                    value: firstLanguage,
                    values: ['fr', 'en'],
                    onChanged: (value) {
                      firstLanguage = value ?? firstLanguage;
                      setState(() {});
                    },
                  ),
                  gapW5,
                  SenseButton(
                    sense,
                    onPressed: () {
                      sense = !sense;
                      setState(() {});
                    },
                  ),
                  gapW5,
                  StyledDropdown(
                    width: 100,
                    height: 40,
                    value: secondLanguage,
                    values: ['fr', 'en'],
                    onChanged: (value) {
                      secondLanguage = value ?? secondLanguage;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ],
          ),
          gapH15,
          OptionPanel(
            width: Sizes.p100,
            children: [
              // Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     StyledText(
              //       group != null
              //           ? 'Le group est chargé'.hardcoded
              //           : 'Le group n\'est pas encore chargé'.hardcoded,
              //       fontSize: Sizes.p5,
              //     ),
              //     gapW4,
              //     StyledCheck(group != null),
              //   ],
              // ),
              // const StyledDivider(
              //   color: AppColors.secondaryColor,
              //   spacement: Sizes.p10,
              //   indent: Sizes.p4,
              //   endIndent: Sizes.p4,
              // ),
              // StyledText(
              //   '${words.length} mots chargés'.hardcoded,
              //   fontSize: Sizes.p5,
              // ),
              // const StyledDivider(
              //   color: AppColors.secondaryColor,
              //   spacement: Sizes.p10,
              //   indent: Sizes.p4,
              //   endIndent: Sizes.p4,
              // ),
              gapH3,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StyledButton(
                    width: Sizes.p25,
                    onPressed: goToRepetitions,
                    child: StyledHeadline(
                      'Quitter'.hardcoded,
                      fontSize: Sizes.p5,
                    ),
                  ),
                  gapW5,
                  !groupNotFound
                      ? StyledButton(
                          width: Sizes.p40,
                          onPressed: ready ? start : null,
                          child: StyledHeadline(
                            'Commencer'.hardcoded,
                            fontSize: Sizes.p5,
                          ),
                        )
                      : StyledButton(
                          width: Sizes.p40,
                          onPressed: () => fetchGroup(widget.groupId),
                          child: StyledHeadline(
                            'Recharger'.hardcoded,
                            fontSize: Sizes.p5,
                          ),
                        ),
                ],
              ),
              gapH3,
            ],
          ),
          expandH4,
        ]);
        break;
      case RepetitionState.process:
        if (repetition.index < wordsToUse.length) {
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
                      Icons.arrow_back,
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
                  cardsCount: wordsToUse.isNotEmpty ? wordsToUse.length : 1,
                  numberOfCardsDisplayed: wordsToUse.length > 5
                      ? 5
                      : wordsToUse.isNotEmpty
                      ? wordsToUse.length
                      : 1,
                  isLoop: false,
                  initialIndex: repetition.index,
                  allowedSwipeDirection: const AllowedSwipeDirection.only(
                    left: true,
                    right: true,
                  ),
                  onSwipe: (previousIndex, currentIndex, direction) {
                    if (previousIndex < wordsToUse.length) {
                      if (direction.isCloseTo(CardSwiperDirection.left)) {
                        passWord(
                          id: wordsToUse[previousIndex].id,
                          known: false,
                        );
                      }
                      if (direction.isCloseTo(CardSwiperDirection.right)) {
                        passWord(id: wordsToUse[previousIndex].id, known: true);
                      }
                    }
                    repetition = repetition.changeIndex(currentIndex);
                    return true;
                  },
                  onUndo: (previousIndex, currentIndex, direction) {
                    passWord(id: wordsToUse[currentIndex].id);
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
                        if (index < wordsToUse.length) {
                          final Word word = wordsToUse[index];
                          return WordCard(
                            key: Key(word.id),
                            word: word,
                            actif: index == repetition.index,
                            firstLanguage: repetition.firstLanguage,
                            secondLanguage: repetition.secondLanguage,
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
          // OptionPanel(
          //   width: Sizes.p100,
          //   children: [
          //     gapH3,
          //     StyledHeadline(
          //       'Vous connaissez ${(100 * repetition.knownCount / repetition.usingCount).round()} % des ${repetition.usingCount} mots'
          //           .hardcoded,
          //     ),
          //     gapH6,
          //     StyledButton(
          //       width: Sizes.p60,
          //       height: Sizes.p10,
          //       onPressed: repetition.index < wordsToUse.length
          //           ? () {
          //               repetition = repetition.changeState(
          //                 RepetitionState.process,
          //               );
          //               setState(() {});
          //             }
          //           : null,
          //       child: StyledHeadline(
          //         'Retour à la repetition actuelle'.hardcoded,
          //       ),
          //     ),
          //   ],
          // ),
          // gapH6,
          OptionPanel(
            width: Sizes.p100,
            part: Part.top,
            children: [
              gapH3,
              StyledHeadline(
                'Vous connaissez ${repetition.knownCount} mots'.hardcoded,
              ),
              gapH6,
              StyledButton(
                width: Sizes.p40,
                height: Sizes.p10,
                onPressed: recommencer,
                child: StyledHeadline('Répeter à nouveau'.hardcoded),
              ),
            ],
          ),
          // gapH15,
          OptionPanel(
            width: Sizes.p100,
            part: Part.body,
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
                    ? () => recommencer(all: false)
                    : null,
                child: StyledHeadline(
                  'Répeter seulement les mots pas sue'.hardcoded,
                ),
              ),
            ],
          ),
          // gapH15,
          OptionPanel(
            width: Sizes.p100,
            part: Part.bottom,
            children: [
              gapH3,
              // StyledHeadline('Vous avez répétez cette liste 20 fois'.hardcoded),
              // gapH6,
              StyledButton(
                width: Sizes.p50,
                height: Sizes.p10,
                onPressed: goToRepetitions,
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
