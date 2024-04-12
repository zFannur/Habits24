import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_style.dart';

export 'app_colors.dart';
export 'app_icons.dart';
export 'app_text_style.dart';
export 'consts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.grey,
    useMaterial3: true,
    fontFamily: 'Inter',
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      secondary: AppColors.orange,
      background: AppColors.white,
    ),
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColors.grey,
      titleTextStyle: AppTextStyle.bold24,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.white,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.grey,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedLabelStyle: AppTextStyle.bold14,
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.orange,
      unselectedItemColor: AppColors.grey,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.grey,
      surfaceTintColor: Colors.transparent,
    ),
    textTheme: TextTheme(
      titleLarge: AppTextStyle.bold24,
      titleMedium: AppTextStyle.bold14,
      titleSmall: AppTextStyle.bold10,
      displayMedium: AppTextStyle.medium14,
      displayLarge: AppTextStyle.mediumBlack20,
      displaySmall: AppTextStyle.mediumBlack12,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.transparent,
    ),
    datePickerTheme: DatePickerThemeData(
      surfaceTintColor: Colors.transparent,
      weekdayStyle: AppTextStyle.bold14,
      dayStyle: AppTextStyle.bold14,
      backgroundColor: AppColors.greyDark,
      headerHelpStyle: AppTextStyle.bold24,
      cancelButtonStyle: TextButton.styleFrom(
        textStyle: AppTextStyle.bold14,
      ),
      confirmButtonStyle: TextButton.styleFrom(
        textStyle: AppTextStyle.bold14,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.greyDark,
      ),
    ),
    primaryColor: AppColors.greyDark,
    useMaterial3: true,
    fontFamily: 'Inter',
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      secondary: AppColors.orange,
      background: AppColors.black,
    ),
    scaffoldBackgroundColor: AppColors.black,
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColors.greyDark,
      titleTextStyle: AppTextStyle.bold24,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.greyDark,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedLabelStyle: AppTextStyle.bold14,
      backgroundColor: AppColors.greyDark,
      selectedItemColor: AppColors.orange,
      unselectedItemColor: AppColors.grey,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.greyDark,
      surfaceTintColor: Colors.transparent,
    ),
    textTheme: TextTheme(
      titleLarge: AppTextStyle.bold24,
      titleMedium: AppTextStyle.bold14,
      titleSmall: AppTextStyle.bold10,
      displayMedium: AppTextStyle.medium14,
      displayLarge: AppTextStyle.mediumBlack20,
      displaySmall: AppTextStyle.mediumBlack12,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.transparent,
    ),
    datePickerTheme: DatePickerThemeData(
      surfaceTintColor: Colors.transparent,
      weekdayStyle: AppTextStyle.bold14,
      dayStyle: AppTextStyle.bold14,
      backgroundColor: AppColors.greyDark,
      headerHelpStyle: AppTextStyle.bold24,
      cancelButtonStyle: TextButton.styleFrom(
        textStyle: AppTextStyle.bold14,
      ),
      confirmButtonStyle: TextButton.styleFrom(
        textStyle: AppTextStyle.bold14,
      ),
    ),
  );
}
