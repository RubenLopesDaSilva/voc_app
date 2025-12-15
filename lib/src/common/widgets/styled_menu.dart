import 'package:flutter/material.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/theme/theme.dart';

class StyledMenu {
  static show({
    required BuildContext context,
    double dx = Sizes.pZero,
    double dy = Sizes.pZero,
    double width = Sizes.pZero,
    double height = Sizes.pZero,
    List<Widget> children = const [],
  }) {
    showMenu(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
      ),
      shadowColor: AppColors.secondaryAccent,
      elevation: Sizes.p5,
      position: RelativeRect.fromLTRB(
        dx - Sizes.p5,
        dy,
        dx + Sizes.p100,
        dy + Sizes.p2,
      ),
      items: [
        PopupMenuItem(
          enabled: false,
          child: SizedBox(
            width: Sizes.p75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}
