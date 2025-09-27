import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:yash/app/controllers/auth/auth_controller.dart';
import 'package:yash/app/views/settings/widgets/sign_out_dialog.dart';
import 'package:yash/generated/l10n.dart';

class SignoutButton extends GetView<AuthController> {
  const SignoutButton({super.key, required this.s});
  final S s;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: controller.isLoading.value
          ? null
          : () async {
              final bool? confirm = await Get.dialog<bool>(SignOutDialog());
              if (confirm == true) {
                await controller.signOut();
              }
            },
      icon: controller.isLoading.value
          ? null
          : const Icon(Icons.logout, color: Colors.white),
      label: Center(
        child: controller.isLoading.value
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                s.sign_out_caps,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(color: Colors.white),
              ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
    );
  }
}
