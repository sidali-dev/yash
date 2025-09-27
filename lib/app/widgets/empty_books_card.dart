import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yash/app/const/images.dart';
import 'package:yash/app/theme/app_colors.dart';
import 'package:yash/app/widgets/custom_box_shadow.dart';
import 'package:yash/generated/l10n.dart';

class EmptyBooksCard extends StatelessWidget {
  const EmptyBooksCard({required this.s, super.key});
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
          LottieBuilder.asset(
            Images.emptyAnimation,
            repeat: false,
            height: 256,
          ),
          Text(
            s.no_books_added,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: AppColors.primary(context),
            ),
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
