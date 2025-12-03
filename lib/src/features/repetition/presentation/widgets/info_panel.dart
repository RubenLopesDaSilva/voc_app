import 'package:flutter/material.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/theme/theme.dart';

class InfoPanel extends StatelessWidget {
  const InfoPanel({this.width, required this.children, super.key});

  final double? width;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: Sizes.p60,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        border: Border(
          top: BorderSide(color: AppColors.secondaryAccent, width: Sizes.p2),
          bottom: BorderSide(color: AppColors.secondaryAccent, width: Sizes.p2),
        ),
      ),
      padding: const EdgeInsets.all(Sizes.p3),
      child: Center(child: Column(children: children)),
    );
  }
}
