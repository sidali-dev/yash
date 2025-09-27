import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ShrinkedOrderInfo extends StatelessWidget {
  const ShrinkedOrderInfo({super.key, required this.onTap});

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(8),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTap(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            Text(
              "Order Info",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            Icon(Iconsax.arrow_up_2_outline),
          ],
        ),
      ),
    );
  }
}
