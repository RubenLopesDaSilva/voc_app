import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voc_app/src/common/constants/gap.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/theme/theme.dart';
import 'package:voc_app/src/common/widgets/styled_text.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget(
    this.value, {
    this.dataW,
    this.loadingW,
    this.errorW,
    super.key,
  });

  final AsyncValue<T> value;
  final Widget Function(T)? dataW;
  final Widget Function()? loadingW;
  final Widget Function(Object, StackTrace)? errorW;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data:
          dataW ??
          (data) => Center(
            child: StyledTitle(
              '$data',
              fontSize: Sizes.p10,
              overflow: TextOverflow.visible,
              maxLines: 10,
            ),
          ),
      error:
          errorW ??
          (error, stackTrace) => Center(
            child: Column(
              children: [
                gapH4,
                StyledTitle(
                  '$error',
                  fontSize: Sizes.p10,
                  overflow: TextOverflow.visible,
                  maxLines: 10,
                ),
                const Divider(
                  color: AppColors.secondaryAccent,
                  thickness: Sizes.p1,
                  height: Sizes.p10,
                ),
                StyledTitle(
                  '$stackTrace',
                  fontSize: Sizes.p10,
                  overflow: TextOverflow.visible,
                  maxLines: 10,
                ),
                gapH4,
              ],
            ),
          ),
      loading:
          loadingW ??
          () => const Center(
            child: StyledTitle(
              'Loading ...',
              fontSize: Sizes.p10,
              overflow: TextOverflow.visible,
              maxLines: 10,
            ),
          ),
    );
  }
}
