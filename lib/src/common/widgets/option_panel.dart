import 'package:flutter/material.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/theme/theme.dart';

class OptionPanel extends StatelessWidget {
  const OptionPanel({
    this.width,
    required this.children,
    super.key,
  });

  final double? width;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          border: Border(
            right: BorderSide(
              color: AppColors.secondaryAccent,
              width: Sizes.p8,
            ),
            bottom: BorderSide(
              color: AppColors.secondaryAccent,
              width: Sizes.p8,
            ),
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(Sizes.p12),
        child: Center(
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}
