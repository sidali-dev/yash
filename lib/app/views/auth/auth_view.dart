import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yash/app/const/images.dart';
import 'package:yash/app/controllers/auth/auth_controller.dart';
import 'package:yash/app/theme/app_colors.dart';
import 'package:yash/app/views/auth/widgets/auth_card.dart';
import 'package:yash/generated/l10n.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // Android
        statusBarBrightness: Brightness.dark, // iOS
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary(context),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(48),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(Images.logo, height: 160),
                    Text(
                      s.yash,
                      style: Theme.of(
                        context,
                      ).textTheme.displayMedium!.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -56),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: AuthCard(s: s),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
