import 'package:flutter/material.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/theme/theme.dart';

class SenseButton extends StatelessWidget {
  const SenseButton(this.sense, {this.onPressed, super.key});

  final bool sense;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        sense
            ? Icons.keyboard_double_arrow_right_rounded
            : Icons.keyboard_double_arrow_left_rounded,
        color: AppColors.secondaryAccent,
        size: Sizes.p10,
      ),
      highlightColor: AppColors.primaryAccent,
    );
  }
}
