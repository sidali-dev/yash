import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yash/app/const/images.dart';
import 'package:yash/app/theme/app_colors.dart';
import 'package:yash/app/widgets/custom_box_shadow.dart';
import 'package:yash/generated/l10n.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({required this.s, super.key});
  final S s;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [CustomBoxShadow(context)],
        color: AppColors.card(context),
      ),
      margin: EdgeInsets.all(32),
      width: double.infinity,
      child: Column(
        children: [
          LottieBuilder.asset(Images.errorAnimation, repeat: true, height: 256),
          Text(
            s.error_caps,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: AppColors.error(context),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
