import 'package:flutter/material.dart';
import 'package:voc_app/src/common/theme/theme.dart';

class StyledCheck extends StatelessWidget {
  const StyledCheck(this.check, {super.key});

  final bool check;

  @override
  Widget build(BuildContext context) {
    return Icon(
      check ? Icons.check_circle_outline_outlined : Icons.cancel_outlined,
      color: AppColors.secondaryAccent,
    );
  }
}
