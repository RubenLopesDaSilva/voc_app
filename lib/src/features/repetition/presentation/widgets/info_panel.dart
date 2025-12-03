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
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        border: Border(
          // left: BorderSide(color: AppColors.secondaryAccent, width: Sizes.p2),
          top: BorderSide(color: AppColors.secondaryAccent, width: Sizes.p2),
          bottom: BorderSide(color: AppColors.secondaryAccent, width: Sizes.p2),
        ),
        borderRadius: BorderRadius.only(
          // topRight: Radius.circular(20),
          // bottomLeft: Radius.circular(20),
          // topLeft: Radius.circular(20),
          // bottomRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(Sizes.p3),
      child: Center(child: Column(children: children)),
    );
  }
}
