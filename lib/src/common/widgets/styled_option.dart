import 'package:flutter/material.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/theme/theme.dart';

class StyledOption extends StatelessWidget {
  const StyledOption(this.icon, {this.onPressed, super.key});

  final IconData? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: Sizes.p32),
      color: AppColors.secondaryAccent,
      highlightColor: AppColors.textColor,
      hoverColor: AppColors.primaryAccent,
      disabledColor: AppColors.textColor,
    );
  }
}
