import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:yash/app/theme/app_colors.dart';
import 'package:yash/app/widgets/header_icon_button.dart';
import 'package:yash/generated/l10n.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({required this.s, super.key});
  final S s;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary(context),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
      ),
      padding: EdgeInsets.only(right: 20, left: 20, top: 48, bottom: 96),
      child: Column(
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderIconButton(
                  iconData: Iconsax.arrow_left_2_outline,
                  onTap: () => Get.back(),
                ),
                const Spacer(),
                Text(
                  s.settings,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineLarge!.copyWith(color: Colors.white),
                ),
                const Spacer(),
                const SizedBox(width: 44),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
