import 'package:flutter/material.dart';
import 'package:primer_progress_bar/primer_progress_bar.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/theme/theme.dart';

class CommonProgressIndicator extends StatelessWidget {
  const CommonProgressIndicator({
    required this.successful,
    required this.failed,
    required this.total,
    super.key,
  });

  final int successful;
  final int failed;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.p256,
      height: Sizes.p64,
      decoration: BoxDecoration(
        color: AppColors.secondaryAccent,
        border: Border.all(width: Sizes.p4, color: AppColors.secondaryAccent),
        borderRadius: BorderRadius.circular(Sizes.p32),
      ),
      child: PrimerProgressBar(
        segments: [
          Segment(value: successful, color: AppColors.primaryAccent),
          Segment(value: failed, color: AppColors.secondaryColor),
        ],
        maxTotalValue: total,
        showLegend: false,
        barStyle: const SegmentedBarStyle(
          backgroundColor: Colors.transparent,
          size: Sizes.p64,
          gap: 4,
          padding: EdgeInsets.all(0),
        ),
      ),
    );
  }
}
