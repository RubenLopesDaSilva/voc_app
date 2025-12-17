import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledText extends StatelessWidget {
  const StyledText(
    this.text, {
    this.color,
    this.fontSize,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines,
    super.key,
  });

  final String text;
  final Color? color;
  final double? fontSize;
  final TextOverflow overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.geologica(
        textStyle: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: color, fontSize: fontSize),
      ),
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}

class StyledHeadline extends StatelessWidget {
  const StyledHeadline(
    this.text, {
    this.color,
    this.fontSize,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines,
    super.key,
  });

  final String text;
  final Color? color;
  final double? fontSize;
  final TextOverflow overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.geologica(
        textStyle: Theme.of(
          context,
        ).textTheme.headlineMedium?.copyWith(color: color, fontSize: fontSize),
      ),
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}

class StyledTitle extends StatelessWidget {
  const StyledTitle(
    this.text, {
    this.color,
    this.fontSize,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines,
    super.key,
  });

  final String text;
  final Color? color;
  final double? fontSize;
  final TextOverflow overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.geologica(
        textStyle: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(color: color, fontSize: fontSize),
      ),
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
