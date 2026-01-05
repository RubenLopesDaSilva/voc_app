import 'package:flutter/material.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/theme/theme.dart';

enum Part { top, body, bottom }

class OptionPanel extends StatelessWidget {
  const OptionPanel({this.width, this.part, required this.children, super.key});

  final double? width;
  final Part? part;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          border: Border(
            top: part == Part.body
                ? const BorderSide(
                    color: AppColors.secondaryAccent,
                    width: Sizes.p2,
                  )
                : BorderSide.none,
            right: const BorderSide(
              color: AppColors.secondaryAccent,
              width: Sizes.p2,
            ),
            bottom: part == Part.bottom || part == Part.body
                ? const BorderSide(
                    color: AppColors.secondaryAccent,
                    width: Sizes.p2,
                  )
                : BorderSide.none,
          ),
          borderRadius: BorderRadius.only(
            topRight: part == Part.top
                ? const Radius.circular(20)
                : Radius.zero,
            bottomLeft: part == Part.bottom
                ? const Radius.circular(20)
                : Radius.zero,
          ),
        ),
        padding: const EdgeInsets.all(Sizes.p3),
        child: Center(child: Column(children: children)),
      ),
    );
  }
}
