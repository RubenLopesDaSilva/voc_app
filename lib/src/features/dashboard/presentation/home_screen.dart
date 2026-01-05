import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:voc_app/src/common/constants/gap.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/localization/string_hardcoded.dart';
import 'package:voc_app/src/common/widgets/styled_button.dart';
import 'package:voc_app/src/common/widgets/styled_text.dart';
import 'package:voc_app/src/navigation/navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          gapWinfinity,
          expandH5,
          StyledTitle('Vocabulary'.hardcoded, fontSize: Sizes.p15),
          StyledTitle('App'.hardcoded, fontSize: Sizes.p15),
          expandH10,
          StyledButton(
            width: Sizes.p100,
            onPressed: () {
              context.goNamed(AppRoutes.login.name);
            },
            child: StyledText('Commencer'.hardcoded, fontSize: Sizes.p8),
          ),
          expandH5,
        ],
      ),
    );
  }
}
