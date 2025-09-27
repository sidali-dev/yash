import 'package:flutter/material.dart';
import 'package:yash/app/const/images.dart';
import 'package:yash/app/theme/app_colors.dart';
import 'package:yash/app/widgets/custom_box_shadow.dart';
import 'package:yash/generated/l10n.dart';

class CategoryBooksHeader extends StatelessWidget {
  const CategoryBooksHeader({
    super.key,
    required this.numberOfBooks,
    required this.category,
    required this.s,
  });

  final int numberOfBooks;
  final String category;
  final S s;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.primary(context),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
          ),
          padding: const EdgeInsets.only(top: 64, bottom: 72),
          width: double.infinity,
          child: Text(
            category,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium!.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: -32,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.card(context),
              borderRadius: BorderRadius.circular(36),
              boxShadow: [CustomBoxShadow(context)],
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            margin: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 12,
              children: [
                Image.asset(Images.bookshelf, height: 36),
                Text(
                  "$numberOfBooks ${s.books_found}",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
