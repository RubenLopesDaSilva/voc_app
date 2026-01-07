import 'package:flutter/material.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/theme/theme.dart';
import 'package:voc_app/src/common/widgets/styled_text.dart';

class EndCard extends StatelessWidget {
  const EndCard({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    const color = AppColors.primaryColor;
    return Container(
      width: 400,
      height: 240,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: AppColors.primaryAccent, width: 4.0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [StyledHeadline(title, fontSize: Sizes.p10)],
        ),
      ),
    );
  }
}
