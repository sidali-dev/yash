import 'package:flutter/material.dart';
import 'package:yash/app/theme/widgets/appbar_theme.dart';
import 'package:yash/app/theme/widgets/button_theme.dart';
import 'package:yash/app/theme/widgets/card_theme.dart';
import 'package:yash/app/theme/widgets/divider_theme.dart';
import 'package:yash/app/theme/widgets/input_theme.dart';
import 'package:yash/app/theme/widgets/progress_indicator_theme.dart';
import 'app_colors.dart';
import 'widgets/text_theme.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'K2D',
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryLight,
        secondary: AppColors.secondaryLight,
        surface: AppColors.surfaceLight,
        error: AppColors.errorLight,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimaryLight,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.backgroundLight,
      textTheme: AppTextTheme.light,
      iconTheme: IconThemeData(color: AppColors.iconLight),
      appBarTheme: AppAppbarTheme.light,
      cardTheme: AppCardTheme.light,
      inputDecorationTheme: AppInputTheme.light,
      elevatedButtonTheme: AppButtonTheme.light,
      outlinedButtonTheme: AppButtonTheme.outlinedLight,
      textButtonTheme: AppButtonTheme.textLight,
      dividerTheme: AppDividerTheme.light,
      progressIndicatorTheme: AppProgressIndicatorTheme.light,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'K2D',
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryDark,
        secondary: AppColors.secondaryDark,
        surface: AppColors.surfaceDark,
        error: AppColors.errorDark,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimaryDark,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.backgroundDark,
      textTheme: AppTextTheme.dark,
      iconTheme: IconThemeData(color: AppColors.iconDark),
      appBarTheme: AppAppbarTheme.dark,
      cardTheme: AppCardTheme.dark,
      inputDecorationTheme: AppInputTheme.dark,
      elevatedButtonTheme: AppButtonTheme.dark,
      outlinedButtonTheme: AppButtonTheme.outlinedDark,
      textButtonTheme: AppButtonTheme.textDark,
      dividerTheme: AppDividerTheme.dark,
      progressIndicatorTheme: AppProgressIndicatorTheme.dark,
    );
  }
}
