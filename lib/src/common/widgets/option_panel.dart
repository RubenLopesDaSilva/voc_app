import 'package:flutter/material.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/theme/theme.dart';

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
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          border: Border.all(color: AppColors.textColor, width: Sizes.p4),
          borderRadius: BorderRadius.circular(20),
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
