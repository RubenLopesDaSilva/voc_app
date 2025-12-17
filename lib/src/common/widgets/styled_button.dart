import 'package:flutter/material.dart';
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
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
      child: TextButton(
        onPressed: onPressed,
        style: onPressed != null
            ? TextButton.styleFrom(
                foregroundColor: foregroundColor ?? AppColors.secondaryAccent,
                backgroundColor: backgroundColor ?? AppColors.primaryColor,
              )
            : TextButton.styleFrom(
                backgroundColor: backgroundColor ?? AppColors.grey,
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
