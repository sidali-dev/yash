import 'package:flutter/material.dart';
import 'package:yash/app/theme/app_colors.dart';

class AppDividerTheme {
  static final light = DividerThemeData(
    color: AppColors.dividerLight,
    thickness: 1,
    space: 32,
    indent: 16,
    endIndent: 16,
  );

  static final dark = DividerThemeData(
    color: AppColors.dividerDark,
    thickness: 1,
    space: 32,
    indent: 16,
    endIndent: 16,
  );
}
