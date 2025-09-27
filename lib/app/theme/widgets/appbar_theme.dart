import 'package:flutter/material.dart';
import 'package:yash/app/theme/app_colors.dart';

class AppAppbarTheme {
  static final light = AppBarTheme(
    backgroundColor: AppColors.backgroundLight,
    foregroundColor: AppColors.textPrimaryLight,
    elevation: 0,
  );

  static final dark = AppBarTheme(
    backgroundColor: AppColors.backgroundDark,
    foregroundColor: AppColors.textPrimaryDark,
    elevation: 0,
  );
}
