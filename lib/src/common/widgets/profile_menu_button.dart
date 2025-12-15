import 'package:flutter/material.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/theme/theme.dart';
import 'package:voc_app/src/common/widgets/styled_menu.dart';

class ProfileMenuButton extends StatelessWidget {
  const ProfileMenuButton({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final Offset position = renderBox.localToGlobal(Offset.zero);
        StyledMenu.show(
          context: context,
          dx: position.dx,
          dy: position.dy + renderBox.size.height + Sizes.p2,
          width: Sizes.p100,
          height: Sizes.p10,
          children: children,
        );
      },
      icon: const Icon(
        Icons.account_circle_outlined,
        color: AppColors.secondaryAccent,
        size: Sizes.p15,
      ),
    );
  }
}
