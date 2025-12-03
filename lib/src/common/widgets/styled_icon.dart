import 'package:flutter/material.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/theme/theme.dart';

class StyledIcon extends StatelessWidget {
  const StyledIcon(this.icon, {this.onPressed, super.key});

  final IconData? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: Sizes.p8),
      color: AppColors.secondaryAccent,
      highlightColor: AppColors.middleColor,
      hoverColor: AppColors.primaryAccent,
      disabledColor: AppColors.middleColor,
    );
  }
}
