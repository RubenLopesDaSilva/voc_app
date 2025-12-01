import 'package:flutter/material.dart';
import 'package:voc_app/src/common/constants/sizes.dart';

class AppColors {
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color primaryColor = const Color.fromARGB(255, 238, 155, 0);
  static Color primaryAccent = const Color.fromARGB(255, 202, 103, 2);
  static Color secondaryColor = const Color.fromARGB(255, 174, 32, 18);
  static Color secondaryAccent = const Color.fromARGB(255, 155, 34, 26);
  static Color textColor = const Color.fromARGB(255, 187, 62, 3);
}

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.textColor),
  scaffoldBackgroundColor: AppColors.primaryColor,
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: AppColors.textColor, fontSize: Sizes.p16),
    headlineMedium: TextStyle(
      color: AppColors.secondaryColor,
      fontSize: Sizes.p16,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: AppColors.secondaryColor,
      fontSize: Sizes.p20,
      fontWeight: FontWeight.bold,
    ),
  ),
);
