import 'package:flutter/material.dart';
import 'package:voc_app/src/common/constants/sizes.dart';

class StyledOption extends StatelessWidget {
  const StyledOption(this.icon, {this.onPressed, super.key});

  final IconData? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: Sizes.p32),
      highlightColor: const Color.fromARGB(255, 170, 170, 170), // Colors.white,
      hoverColor: const Color.fromARGB(255, 200, 200, 200),
      disabledColor: Colors.grey,
    );
  }
}
