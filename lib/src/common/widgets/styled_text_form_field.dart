import 'package:flutter/material.dart';

class StyledTextFormField extends StatelessWidget {
  const StyledTextFormField({
    required this.controller,
    this.autovalidateMode,
    this.validator,
    this.readOnly,
    this.textInputType,
    this.prefixIcon,
    this.color,
    this.child,
    super.key,
  });

  final TextEditingController controller;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final TextInputType? textInputType;
  final Icon? prefixIcon;
  final Color? color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autovalidateMode,
      validator: validator,
      controller: controller,
      readOnly: readOnly ?? false,
      keyboardType: textInputType,
      cursorColor: color,
      decoration: InputDecoration(prefixIcon: prefixIcon, label: child),
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color),
    );
  }
}
