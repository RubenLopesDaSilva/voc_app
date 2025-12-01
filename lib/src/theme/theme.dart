import 'package:flutter/material.dart';
import 'package:voc_app/src/common/constants/sizes.dart';

class AppColors {
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color black = Colors.black;
  static const Color primaryColor = Color.fromARGB(255, 238, 155, 0);
  static const Color primaryAccent = Color.fromARGB(255, 202, 103, 2);
  static const Color secondaryColor = Color.fromARGB(255, 174, 32, 18);
  static const Color secondaryAccent = Color.fromARGB(255, 155, 34, 26);
  static const Color textColor = Color.fromARGB(255, 187, 62, 3);
}

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.textColor),
  scaffoldBackgroundColor: AppColors.primaryAccent,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: AppColors.textColor, fontSize: Sizes.p16),
    headlineMedium: TextStyle(
      color: AppColors.textColor,
      fontSize: Sizes.p16,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: AppColors.textColor,
      fontSize: Sizes.p20,
      fontWeight: FontWeight.bold,
    ),
  ),
);
