import 'package:flutter/material.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/theme/theme.dart';
import 'package:voc_app/src/common/widgets/styled_text.dart';

class StyledDropdown<T> extends StatelessWidget {
  const StyledDropdown({
    this.width,
    this.height,
    this.value,
    required this.values,
    required this.onChanged,
    super.key,
  });

  final double? width;
  final double? height;
  final T? value;
  final List<T> values;
  final Function(T?) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        children: [
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                value: value,
                dropdownColor: AppColors.primaryColor,
                iconEnabledColor: AppColors.secondaryAccent,
                items: [
                  for (T value in values)
                    DropdownMenuItem(
                      value: value,
                      alignment: AlignmentGeometry.center,
                      child: StyledHeadline(
                        value.toString(),
                        fontSize: Sizes.p5,
                      ),
                    ),
                ],
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
