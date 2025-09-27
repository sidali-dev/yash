import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:yash/app/controllers/widgets/auth_card_controller.dart';
import 'package:yash/app/theme/app_colors.dart';
import 'package:yash/app/widgets/custom_box_shadow.dart';
import 'package:yash/generated/l10n.dart';

class AuthCard extends GetView<AuthCardController> {
  const AuthCard({required this.s, super.key});
  final S s;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          Container(
            decoration: BoxDecoration(
              color: AppColors.card(context),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [CustomBoxShadow(context)],
            ),
            child: Transform.flip(
              flipX: controller.isFlipped.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    controller.isFlipped.value ? s.sign_up : s.welcome_back,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: AppColors.primary(context),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.isFlipped.value
                        ? s.sign_up_desc
                        : s.welcome_back_desc,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 96),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        await controller.authController.signInWithGoogle();
                      },
                      icon: Brand(Brands.google),
                      label: Text(
                        s.continue_with_google,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    controller.isFlipped.value
                        ? s.have_an_account
                        : s.dont_have_an_account,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if (controller.animationController.isCompleted) {
                        controller.animationController.forward(from: 0);
                        controller.flipCard();
                        controller.mirrorContent();
                      }
                    },
                    child: Text(
                      controller.isFlipped.value ? s.sign_in : s.sign_up,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.primary(context),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ).animate(
            controller: controller.animationController,
            effects: [
              FlipEffect(
                direction: Axis.horizontal,
                duration: 1000.ms,
                begin: controller.isLogin.value ? 1.0 : 2.0,
                end: controller.isLogin.value ? 2.0 : 1.0,
              ),
            ],
          ),
    );
  }
}
