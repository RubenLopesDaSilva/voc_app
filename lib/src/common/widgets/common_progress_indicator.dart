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
    var sizedBox = SizedBox(
      width: 240,
      height: 40,
      child: PrimerProgressBar(
        segments: [
          Segment(value: passed, color: Colors.green),
          Segment(value: other, color: Colors.red),
        ],
        maxTotalValue: total,
        showLegend: false,
        barStyle: SegmentedBarStyle(backgroundColor: Colors.transparent),
      ),
      // LinearProgressIndicator(
      //   backgroundColor: Colors.grey,
      //   valueColor: AlwaysStoppedAnimation(Colors.black),
      //   value: (passed + other) / total,
      //   borderRadius: BorderRadius.circular(24),
      // ),
    );
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        sizedBox,
        gapW24,
        Container(
          decoration: ShapeDecoration(
            shape: CircleBorder(
              side: BorderSide(color: Colors.black, width: 4.0),
            ),
          ),
          padding: EdgeInsets.all(24),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(' $passed', style: TextStyle(fontSize: 24)),
                Text(
                  ' / ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(' ${passed + other} ', style: TextStyle(fontSize: 24)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
