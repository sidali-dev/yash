import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:yash/app/const/images.dart';
import 'package:yash/app/routes/app_routes.dart';
import 'package:yash/app/theme/app_colors.dart';
import 'package:yash/app/widgets/header_icon_button.dart';

class StoreHeader extends StatelessWidget {
  const StoreHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary(context),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(48)),
      ),
      padding: EdgeInsets.only(left: 20, right: 20, top: 48, bottom: 240),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderIconButton(
              iconData: Iconsax.setting_2_outline,
              onTap: () => Get.toNamed(Routes.SETTINGS),
            ),
            Transform.translate(
              offset: Offset(0, 24),
              child: Image.asset(Images.logo, width: 88),
            ),
            HeaderIconButton(
              iconData: Iconsax.shopping_cart_outline,
              onTap: () => Get.toNamed(Routes.CART),
            ),
          ],
        ),
      ),
    );
  }
}
