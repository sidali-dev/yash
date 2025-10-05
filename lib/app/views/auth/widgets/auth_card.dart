import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:yash/app/controllers/widgets/auth_card_controller.dart';
import 'package:yash/app/helpers/helper_functions.dart';
import 'package:yash/app/theme/app_colors.dart';
import 'package:yash/app/widgets/custom_box_shadow.dart';
import 'package:yash/generated/l10n.dart';

class AuthCard extends GetView<AuthCardController> {
  const AuthCard({required this.s, super.key});
  final S s;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Obx(
      () => Form(
        key: formKey,
        child:
            Container(
              decoration: BoxDecoration(
                color: AppColors.card(context),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [CustomBoxShadow(context)],
              ),
              child: Transform.flip(
                flipX: controller.isFlipped.value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        controller.isFlipped.value ? s.sign_up : s.welcome_back,
                        style: Theme.of(context).textTheme.displaySmall!
                            .copyWith(color: AppColors.primary(context)),
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
                      const SizedBox(height: 32),
                      //---------------------
                      Obx(
                        () => controller.isFlipped.value
                            ? TextFormField(
                                controller: controller.nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "name required";
                                  }
                                  if (HelperFunctions.isName(value)) {
                                    return "invalid name";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: "Name",
                                  prefixIcon: Icon(Icons.person_outlined),
                                ),
                                keyboardType: TextInputType.name,
                              )
                            : SizedBox(),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: controller.emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "email required";
                          }
                          if (!GetUtils.isEmail(value)) {
                            return "invalid email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 16),
                      Obx(
                        () => TextFormField(
                          controller: controller.passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "password required";
                            }
                            if (value.length < 8) {
                              return "password minimum length";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: InkWell(
                              onTap: controller.hidePassword,
                              child: controller.isPasswordHidden.value
                                  ? Icon(Iconsax.eye_slash_outline)
                                  : Icon(Iconsax.eye_outline),
                            ),
                          ),
                          obscureText: controller.isPasswordHidden.value,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Obx(
                        () => ElevatedButton(
                          onPressed: controller.authController.isLoading.value
                              ? null
                              : () async {
                                  if (formKey.currentState!.validate()) {
                                    controller.isFlipped.value
                                        ? await controller.authController
                                              .signUp(
                                                name: controller
                                                    .nameController
                                                    .text,
                                                email: controller
                                                    .emailController
                                                    .text,
                                                password: controller
                                                    .passwordController
                                                    .text,
                                              )
                                        : await controller.authController
                                              .signIn(
                                                email: controller
                                                    .emailController
                                                    .text,
                                                password: controller
                                                    .passwordController
                                                    .text,
                                                newUser: false,
                                              );
                                  }
                                },
                          child: controller.authController.isLoading.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(),
                                )
                              : Text(
                                  controller.isFlipped.value
                                      ? s.sign_up
                                      : s.sign_in,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(color: Colors.white),
                                ),
                        ),
                      ),
                      SizedBox(height: 24),

                      //---------------------
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
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(color: AppColors.primary(context)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Divider(height: 64)),
                          Text("OR"),
                          Expanded(child: Divider(height: 64)),
                        ],
                      ),
                      OutlinedButton.icon(
                        onPressed: () async {
                          await controller.authController.signInWithGoogle();
                        },
                        icon: Brand(Brands.google),
                        label: Text(
                          s.continue_with_google,
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
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
      ),
    );
  }
}
