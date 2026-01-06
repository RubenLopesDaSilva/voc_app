import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:voc_app/src/common/constants/gap.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/localization/string_hardcoded.dart';
import 'package:voc_app/src/common/widgets/async_value_widget.dart';
import 'package:voc_app/src/common/widgets/profile_menu_button.dart';
import 'package:voc_app/src/common/widgets/styled_button.dart';
import 'package:voc_app/src/common/widgets/styled_text.dart';
import 'package:voc_app/src/features/groups/data/group_repository.dart';
import 'package:voc_app/src/features/groups/domain/group.dart';
import 'package:voc_app/src/features/repetition/presentation/widgets/group_item_repetition.dart';
import 'package:voc_app/src/common/widgets/info_panel.dart';
import 'package:voc_app/src/navigation/navigation.dart';

class RepetitionsScreen extends StatefulWidget {
  const RepetitionsScreen({super.key});

  @override
  State<RepetitionsScreen> createState() => _RepetitionsScreenState();
}

class _RepetitionsScreenState extends State<RepetitionsScreen> {
  void repeatGroup(String id) {
    context.goNamed(AppRoutes.repetition.name, pathParameters: {'groupId': id});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          InfoPanel(
            children: [
              Row(
                children: [
                  gapW10,
                  StyledHeadline('Repetitions'.hardcoded, fontSize: Sizes.p10),
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
                        width: Sizes.p75,
                        onPressed: () {
                          context.goNamed(AppRoutes.login.name);
                        },
                        child: StyledText(
                          'Se déconnecter'.hardcoded,
                          fontSize: Sizes.p5,
                        ),
                      ),
                      gapH5,
                    ],
                  ),
                  gapW10,
                ],
              ),
            ],
          ),
          gapH5,
          Consumer(
            builder: (context, ref, child) {
              final AsyncValue<List<Group>> asyncGroups = ref.watch(
                groupListFutureProvider,
              );
              return AsyncValueWidget(
                asyncGroups,
                dataW: (groups) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: Sizes.p4),
                      child: ListView.separated(
                        itemCount: groups.length,
                        itemBuilder: (context, index) {
                          final Group group = groups[index];
                          return GroupItemRepetition(
                            group,
                            onTapDown: () {
                              repeatGroup(group.id);
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return gapH5;
                        },
                      ),
                    ),
                  );
                },
                loadingW: () {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                errorW: (error, stackTrace) {
                  return StyledTitle(
                    '$error',
                    fontSize: Sizes.p10,
                    overflow: TextOverflow.visible,
                    maxLines: 10,
                  );
                },
              );
            },
          ),
          gapH5,
        ],
      ),
    );
  }
}
