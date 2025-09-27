import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:yash/app/controllers/auth/auth_controller.dart';

class AuthCardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController animationController;

  RxBool isLogin = true.obs;
  RxBool isFlipped = false.obs;

  late final AuthController authController;

  @override
  void onInit() {
    animationController = AnimationController(vsync: this);
    authController = Get.find();
    super.onInit();
  }

  void flipCard() {
    isLogin.value = !isLogin.value;
  }

  void mirrorContent() async {
    await Future.delayed(500.ms);
    isFlipped.value = !isFlipped.value;
  }
}
