import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:yash/app/controllers/app/language_controller.dart';

class HorizontalArrow extends GetView<LanguageController> {
  const HorizontalArrow({this.color, this.size = 24, super.key});

  final Color? color;
  final double size;

  @override
  Icon build(BuildContext context) {
    bool isRtl = controller.getCurrentLanguage() == "ar";

    return Icon(
      isRtl ? Iconsax.arrow_left_2_outline : Iconsax.arrow_right_3_outline,
      color: color ?? Theme.of(context).iconTheme.color,
      size: size,
    );
  }
}
