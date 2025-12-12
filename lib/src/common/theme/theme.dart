import 'package:flutter/material.dart';
import 'package:voc_app/src/common/constants/sizes.dart';

// class AppColors {
//   static const Color white = Colors.white;
//   static const Color grey = Colors.grey;
//   static const Color black = Colors.black;
//   static const Color primaryColor = Color.fromARGB(255, 238, 155, 0);
//   static const Color primaryAccent = Color.fromARGB(255, 202, 103, 2);
//   static const Color secondaryColor = Color.fromARGB(255, 174, 32, 18);
//   static const Color secondaryAccent = Color.fromARGB(255, 155, 34, 26);
//   static const Color textColor = Color.fromARGB(255, 187, 62, 3);
// }

// class AppColors {
//   static const Color white = Colors.white;
//   static const Color grey = Colors.grey;
//   static const Color black = Colors.black;
//   static const Color primaryColor = Color.fromARGB(255, 217, 237, 146);
//   static const Color primaryAccent = Color.fromARGB(255, 181, 228, 140);
//   static const Color secondaryColor = Color.fromARGB(255, 118, 200, 147);
//   static const Color secondaryAccent = Color.fromARGB(255, 82, 182, 154);
//   static const Color textColor = Color.fromARGB(255, 153, 217, 140);
// }

class AppColors {
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color black = Colors.black;
  static const Color primaryColor = Color.fromARGB(255, 248, 244, 227);
  static const Color primaryAccent = Color.fromARGB(255, 212, 205, 195);
  static const Color middleColor = Color.fromARGB(255, 213, 208, 205);
  static const Color secondaryColor = Color.fromARGB(255, 162, 163, 146);
  static const Color secondaryAccent = Color.fromARGB(255, 154, 153, 140);
}

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.middleColor),
  scaffoldBackgroundColor: AppColors.primaryAccent,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: AppColors.secondaryColor, fontSize: Sizes.p4),
    headlineMedium: TextStyle(
      color: AppColors.secondaryColor,
      fontSize: Sizes.p4,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: AppColors.secondaryColor,
      fontSize: Sizes.p5,
      fontWeight: FontWeight.bold,
    ),
  ),
  scrollbarTheme: const ScrollbarThemeData(
    thickness: WidgetStatePropertyAll(Sizes.p4),
    radius: Radius.circular(Sizes.p5),
    thumbColor: WidgetStatePropertyAll(AppColors.secondaryAccent),
  ),
);
