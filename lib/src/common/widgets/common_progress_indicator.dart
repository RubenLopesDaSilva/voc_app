import 'package:flutter/material.dart';
import 'package:primer_progress_bar/primer_progress_bar.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/theme/theme.dart';

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
      width: Sizes.p64,
      height: Sizes.p16,
      decoration: BoxDecoration(
        color: AppColors.secondaryAccent,
        border: Border.all(width: Sizes.p2, color: AppColors.secondaryAccent),
        borderRadius: BorderRadius.circular(Sizes.p8),
      ),
      //TODO : Créer ma propre bar de progress pour que les 2 couleurs soi opposé et rejoigne le centre
      child: PrimerProgressBar(
        segments: [
          // Segment(value: successful, color: AppColors.primaryAccent),
          // Segment(value: failed, color: AppColors.secondaryColor),
          Segment(value: successful, color: AppColors.primaryColor),
          Segment(value: failed, color: AppColors.primaryAccent),
        ],
        maxTotalValue: total,
        showLegend: false,
        barStyle: const SegmentedBarStyle(
          backgroundColor: Colors.transparent,
          size: Sizes.p16,
          gap: Sizes.p2,
          padding: EdgeInsets.all(0),
        ),
      ),
    );
  }
}
