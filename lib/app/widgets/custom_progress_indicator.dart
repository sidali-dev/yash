import 'package:flutter/material.dart';
import 'package:yash/app/model/book_model.dart';
import 'package:yash/app/services/bookmark_cache_service.dart';
import 'package:yash/app/theme/app_colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    super.key,
    required this.spacing,
    required this.minHeight,
    required this.textSize,
    required this.book,
    required this.userId,
  });

  final double spacing, minHeight, textSize;
  final BookModel book;
  final String userId;

  @override
  Widget build(BuildContext context) {
    int currentPage = BookmarkCacheService().getPage(userId, book.id);
    double progress = (currentPage / book.pageCount);
    return Row(
      spacing: spacing,
      children: [
        Expanded(
          child: LinearProgressIndicator(
            minHeight: minHeight,
            color: AppColors.primary(context),
            backgroundColor: AppColors.secondaryBackground(context),
            borderRadius: BorderRadius.circular(8),
            value: progress,
          ),
        ),
        Text(
          "${(progress * 100).floor()}%",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.primary(context),
            fontSize: textSize,
          ),
        ),
      ],
    );
  }
}
