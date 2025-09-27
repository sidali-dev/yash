import 'package:flutter/material.dart';
import 'package:yash/app/theme/app_colors.dart';

class HeaderIconButton extends StatelessWidget {
  const HeaderIconButton({
    super.key,
    required this.onTap,
    required this.iconData,
  });

  final Function onTap;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(10),
        child: Icon(iconData, color: AppColors.primary(context)),
      ),
    );
  }
}
