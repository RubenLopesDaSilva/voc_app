import 'package:flutter/material.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/theme/theme.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({
    this.width,
    this.height,
    this.foregroundColor,
    this.backgroundColor,
    this.onPressed,
    required this.child,
    super.key,
  });

  final double? width;
  final double? height;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.secondaryAccent, width: Sizes.p1),
        borderRadius: BorderRadius.circular(40),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: foregroundColor ?? AppColors.secondaryAccent,
          backgroundColor: backgroundColor ?? AppColors.middleColor,
        ),
        child: SizedBox(
          width: width,
          height: height,
          child: Center(child: child),
        ),
      ),
    );
  }
}
