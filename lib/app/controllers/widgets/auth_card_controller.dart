import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:yash/app/controllers/auth/auth_controller.dart';

class AuthCardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController animationController;

  final RxBool isLogin = true.obs;
  final RxBool isFlipped = false.obs;
  final RxBool isPasswordHidden = true.obs;

  late final AuthController authController;
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void onInit() {
    animationController = AnimationController(vsync: this);
    authController = Get.find();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  void flipCard() {
    isLogin.value = !isLogin.value;
  }

  void mirrorContent() async {
    await Future.delayed(500.ms);
    isFlipped.value = !isFlipped.value;
  }

  void hidePassword() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }
}
