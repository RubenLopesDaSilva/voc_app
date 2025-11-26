import 'package:flutter/material.dart';
import 'package:primer_progress_bar/primer_progress_bar.dart';
import 'package:voc_app/src/common/constants/sizes.dart';

class CommonProgressIndicator extends StatelessWidget {
  const CommonProgressIndicator({
    required this.passed,
    required this.other,
    required this.total,
    super.key,
  });

  final int passed;
  final int other;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.p256,
      height: Sizes.p64,
      decoration: BoxDecoration(
        border: Border.all(width: Sizes.p4),
        borderRadius: BorderRadius.circular(Sizes.p32),
      ),
      child: PrimerProgressBar(
        segments: [
          Segment(value: passed, color: Colors.green),
          Segment(value: other, color: Colors.red),
        ],
        maxTotalValue: total,
        showLegend: false,
        barStyle: const SegmentedBarStyle(
          backgroundColor: Colors.grey,
          size: Sizes.p64,
          gap: 4,
          padding: EdgeInsets.all(0),
        ),
      ),
    );
  }
}
