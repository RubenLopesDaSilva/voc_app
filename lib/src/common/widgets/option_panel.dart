import 'package:flutter/material.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/theme/theme.dart';

class OptionPanel extends StatelessWidget {
  const OptionPanel({
    this.width,
    required this.title,
    required this.options,
    super.key,
  });

  final double? width;
  final Widget title;
  final List<Widget> options;

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
            // topLeft: Radius.circular(20),
            // bottomRight: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(Sizes.p12),
        child: Center(
          child: Column(
            children: [
              title,
              gapH24,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: options,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
