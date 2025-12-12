import 'package:flutter/material.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/localization/string_hardcoded.dart';
import 'package:voc_app/src/common/widgets/option_panel.dart';
import 'package:voc_app/src/common/widgets/styled_divider.dart';
import 'package:voc_app/src/common/widgets/styled_text.dart';
import 'package:voc_app/src/features/groups/domain/group.dart';

class GroupItemRepetition extends StatelessWidget {
  const GroupItemRepetition(this.group, {required this.onTapDown, super.key});

  final Group group;
  final VoidCallback onTapDown;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        onTapDown();
      },
      child: OptionPanel(
        width: Sizes.p100,
        children: [
          Row(
            children: [
              Expanded(
                child: Center(
                  child: StyledHeadline(group.name, fontSize: Sizes.p5),
                ),
              ),
              const StyledDivider(
                horizontal: false,
                height: Sizes.p50,
                spacement: Sizes.p10,
              ),
              Column(
                children: [
                  StyledHeadline(
                    'De Burri Simon'.hardcoded,
                    fontSize: Sizes.p5,
                  ),
                  const StyledDivider(
                    horizontal: true,
                    height: Sizes.p25,
                    width: Sizes.p50,
                  ),
                  StyledHeadline(
                    'Contient ${group.words.length} mots'.hardcoded,
                    fontSize: Sizes.p5,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
