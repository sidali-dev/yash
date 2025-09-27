// ignore_for_file: non_constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:yash/app/theme/app_colors.dart';

BoxShadow CustomBoxShadow(BuildContext context) {
  return BoxShadow(
    color: AppColors.shadow(context),
    blurRadius: 28,
    offset: const Offset(0, 4),
  );
}
