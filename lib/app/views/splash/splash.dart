import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yash/app/const/images.dart';
import 'package:yash/app/controllers/auth/auth_controller.dart';
import 'package:yash/app/routes/app_routes.dart';
import '../../theme/app_colors.dart';

class SplashView extends GetView<AuthController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: FutureBuilder(
          future: controller.checkLoginStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Images.logo, height: 128),
                    const SizedBox(height: 24),
                    CircularProgressIndicator(
                      color: AppColors.primary(context),
                    ),
                  ],
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                if (controller.isLoggedIn.value) {
                  await controller.loadUserProfile();
                  Get.offAllNamed(Routes.NAVIGATION);
                } else {
                  Get.offAllNamed(Routes.AUTH);
                }
              });
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
