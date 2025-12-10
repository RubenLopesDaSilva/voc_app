import 'package:flutter/material.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/theme/theme.dart';

class StyledDivider extends StatelessWidget {
  const StyledDivider({
    this.horizontal = true,
    this.width,
    this.height,
    this.color,
    this.thickness,
    this.spacement,
    this.indent,
    this.endIndent,
    super.key,
  });

  final bool horizontal;
  final double? width;
  final double? height;
  final Color? color;
  final double? thickness;
  final double? spacement;
  final double? indent;
  final double? endIndent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: horizontal
          ? Divider(
              color: color ?? AppColors.secondaryAccent,
              thickness: thickness ?? Sizes.p1,
              height: spacement ?? Sizes.p5,
              indent: indent ?? Sizes.p2,
              endIndent: endIndent ?? Sizes.p2,
            )
          : VerticalDivider(
              color: color ?? AppColors.secondaryAccent,
              thickness: thickness ?? Sizes.p1,
              width: spacement ?? Sizes.p5,
              indent: indent ?? Sizes.p2,
              endIndent: endIndent ?? Sizes.p2,
            ),
    );
  }
}
