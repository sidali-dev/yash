import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:yash/app/theme/app_colors.dart';
import 'package:yash/generated/l10n.dart';

class SignOutDialog extends StatelessWidget {
  const SignOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AlertDialog(
      title: Text(s.sign_out),
      content: Text(s.sign_out_confirmation),
      actions: [
        TextButton(
          onPressed: () => Get.back(result: false),
          child: Text(
            s.cancel,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.secondary(context),
            ),
          ),
        ),
        TextButton(
          onPressed: () => Get.back(result: true),
          child: Text(
            s.confirm,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.warning(context),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
