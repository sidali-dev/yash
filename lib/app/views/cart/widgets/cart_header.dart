import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:yash/app/theme/app_colors.dart';
import 'package:yash/app/widgets/header_icon_button.dart';
import 'package:yash/generated/l10n.dart';

class CartHeader extends StatelessWidget {
  const CartHeader({super.key, required this.onClearCart, required this.s});

  final Function onClearCart;
  final S s;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary(context),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      padding: EdgeInsets.only(top: 64, bottom: 64, left: 16, right: 16),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            HeaderIconButton(
              onTap: () => Get.back(),
              iconData: Iconsax.arrow_left_2_outline,
            ),
            Spacer(),
            Icon(Iconsax.shopping_cart_outline, color: Colors.white, size: 32),
            SizedBox(width: 16),
            Text(
              s.cart,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium!.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            HeaderIconButton(
              onTap: () => onClearCart(),
              iconData: Iconsax.trash_outline,
            ),
          ],
        ),
      ),
    );
  }
}
