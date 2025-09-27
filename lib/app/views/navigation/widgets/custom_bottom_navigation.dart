import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yash/app/controllers/navigation/navigation_controller.dart';
import 'package:yash/app/theme/app_colors.dart';
import 'package:yash/app/widgets/custom_box_shadow.dart';

class CustomBottomNavigation extends GetView<NavigationController> {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      margin: EdgeInsets.only(bottom: 24, right: 24, left: 24),
      decoration: BoxDecoration(
        color: AppColors.background(context),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [CustomBoxShadow(context)],
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: controller.icons.map((e) {
            int index = controller.icons.indexOf(e);

            return InkWell(
              onTap: () => controller.changePage(index),
              child: SizedBox(
                height: 64,
                width: 64,
                child: Icon(
                  e,
                  size: 26,
                  color: controller.getSelectedColor(context, index),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
