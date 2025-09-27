import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:yash/app/const/images.dart';
import 'package:yash/app/routes/app_routes.dart';
import 'package:yash/app/theme/app_colors.dart';
import 'package:yash/generated/l10n.dart';

class CheckoutResult extends StatelessWidget {
  const CheckoutResult({super.key, required this.isSuccess});

  final bool isSuccess;

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              isSuccess ? Images.successAnimation : Images.failureAnimation,
              width: 256,
              repeat: false,
            ),
            SizedBox(height: 32),
            Text(
              isSuccess ? s.congratulations : s.error,
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              isSuccess ? s.purchase_success : s.purchase_failure,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 64),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isSuccess
                    ? AppColors.primary(context)
                    : AppColors.error(context),
              ),
              onPressed: () {
                Get.offNamedUntil(Routes.NAVIGATION, (route) => false);
              },
              child: Center(
                child: Text(
                  isSuccess ? s.continue_ : s.go_back,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
