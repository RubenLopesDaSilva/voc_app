import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voc_app/src/common/constants/gap.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/localization/string_hardcoded.dart';
import 'package:voc_app/src/common/theme/theme.dart';
import 'package:voc_app/src/common/widgets/async_value_widget.dart';
import 'package:voc_app/src/common/widgets/styled_text.dart';
import 'package:voc_app/src/features/groups/data/group_repository.dart';
import 'package:voc_app/src/features/groups/domain/group.dart';
import 'package:voc_app/src/features/repetition/presentation/widgets/info_panel.dart';

class RepetitionsScreen extends StatefulWidget {
  const RepetitionsScreen({super.key});

  @override
  State<RepetitionsScreen> createState() => _RepetitionsScreenState();
}

class _RepetitionsScreenState extends State<RepetitionsScreen> {
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
                          StyledHeadline(
                            'Burri Simon'.hardcoded,
                            fontSize: Sizes.p6,
                          ),
                          const StyledHeadline(
                            'Vos groupes',
                            fontSize: Sizes.p6,
                          ),
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
                        'Contient'.hardcoded,
                        fontSize: Sizes.p4,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          expandH4,
          Consumer(
            builder: (context, ref, child) {
              final AsyncValue<List<Group>> asyncGroups = ref.watch(
                groupListFutureProvider,
              );
              return AsyncValueWidget(
                asyncGroups,
                dataW: (groups) {
                  return Expanded(
                    child: ListView.separated(
                      itemCount: groups.length,
                      itemBuilder: (context, index) {
                        final Group group = groups[index];
                        return StyledText(group.name);
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: AppColors.secondaryAccent,
                          thickness: Sizes.p1,
                          height: Sizes.p10,
                          indent: Sizes.p10,
                          endIndent: Sizes.p10,
                        );
                      },
                    ),
                  );
                },
                loadingW: () {
                  return const CircularProgressIndicator();
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
          expandH4,
        ],
      ),
    );
  }
}
