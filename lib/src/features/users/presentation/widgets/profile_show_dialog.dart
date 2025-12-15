import 'package:flutter/material.dart';
import 'package:voc_app/src/common/constants/gap.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/localization/string_hardcoded.dart';
import 'package:voc_app/src/common/widgets/styled_button.dart';
import 'package:voc_app/src/common/widgets/styled_text.dart';

class ProfileShowDialog extends StatelessWidget {
  const ProfileShowDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: StyledHeadline(
          'Option de profile'.hardcoded,
          fontSize: Sizes.p5,
        ),
      ),
      content: SizedBox(
        width: Sizes.p5,
        height: Sizes.p5,
        child: Center(
          child: StyledText(
            'Que voulez vous faire ?'.hardcoded,
            fontSize: Sizes.p5,
          ),
        ),
      ),
      actions: [
        StyledButton(
          width: Sizes.p50,
          child: StyledText('Aller au profile'.hardcoded, fontSize: Sizes.p5),
        ),
        gapH5,
        StyledButton(
          width: Sizes.p50,
          child: StyledText('Changer de comptes'.hardcoded, fontSize: Sizes.p5),
        ),
        gapH5,
        StyledButton(
          width: Sizes.p50,
          child: StyledText('Se déconnecter'.hardcoded, fontSize: Sizes.p5),
        ),
      ],
    );
  }
}
