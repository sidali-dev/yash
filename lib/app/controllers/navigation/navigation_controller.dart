import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:yash/app/theme/app_colors.dart';

class NavigationController extends GetxController {
  final RxInt currentIndex = 0.obs;

  List<IconData> icons = [Iconsax.shop_outline, Iconsax.book_1_outline];

  void changePage(int index) {
    currentIndex.value = index;
  }

  Color getSelectedColor(BuildContext context, int index) {
    return index == currentIndex.value
        ? AppColors.primary(context)
        : AppColors.secondary(context);
  }
}
