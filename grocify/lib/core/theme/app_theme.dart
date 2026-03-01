import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_sizes.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: AppSizes.fontSizeXL,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        minimumSize: Size(double.infinity, AppSizes.buttonHeightMD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
        ),
        textStyle: TextStyle(
          fontSize: AppSizes.fontSizeMD,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: BorderSide(color: AppColors.primary),
        minimumSize: Size(double.infinity, AppSizes.buttonHeightMD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
        ),
        textStyle: TextStyle(
          fontSize: AppSizes.fontSizeMD,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.gray50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
        borderSide: BorderSide(color: AppColors.gray300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
        borderSide: BorderSide(color: AppColors.gray300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
        borderSide: BorderSide(color: AppColors.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
        borderSide: BorderSide(color: AppColors.error),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSizes.paddingMD,
        vertical: AppSizes.paddingMD,
      ),
    ),
    cardTheme: CardTheme(
      color: AppColors.cardBackground,
      elevation: AppSizes.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: AppColors.gray900,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.gray800,
      foregroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: AppSizes.fontSizeXL,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        minimumSize: Size(double.infinity, AppSizes.buttonHeightMD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
        ),
        textStyle: TextStyle(
          fontSize: AppSizes.fontSizeMD,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: BorderSide(color: AppColors.primary),
        minimumSize: Size(double.infinity, AppSizes.buttonHeightMD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
        ),
        textStyle: TextStyle(
          fontSize: AppSizes.fontSizeMD,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.gray800,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
        borderSide: BorderSide(color: AppColors.gray600),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
        borderSide: BorderSide(color: AppColors.gray600),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
        borderSide: BorderSide(color: AppColors.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
        borderSide: BorderSide(color: AppColors.error),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSizes.paddingMD,
        vertical: AppSizes.paddingMD,
      ),
    ),
    cardTheme: CardTheme(
      color: AppColors.gray800,
      elevation: AppSizes.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
      ),
    ),
  );
}