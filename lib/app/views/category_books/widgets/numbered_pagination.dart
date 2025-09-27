import 'package:flutter/material.dart';
import 'package:yash/app/theme/app_colors.dart';
import 'package:yash/app/widgets/custom_box_shadow.dart';

class NumberedPagination extends StatelessWidget {
  const NumberedPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPrevious,
    required this.onPageClick,
    required this.onNext,
  });

  final int totalPages;
  final int currentPage;

  final void Function() onPrevious;
  final void Function(int page) onPageClick;
  final void Function() onNext;

  @override
  Widget build(BuildContext context) {
    // determine visible page range (max 5 pages at once)
    int startPage = (currentPage - 2).clamp(1, totalPages);
    int endPage = (startPage + 4).clamp(1, totalPages);

    // shift window if near the end
    if (endPage - startPage < 4) {
      startPage = (endPage - 4).clamp(1, totalPages);
    }

    return Row(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Left arrow
        GestureDetector(
          onTap: () => onPrevious(),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: currentPage > 1
                  ? AppColors.card(context)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [CustomBoxShadow(context)],
            ),

            child: currentPage > 1
                ? Icon(
                    Icons.chevron_left,
                    color: AppColors.textPrimary(context),
                  )
                : null,
          ),
        ),

        // Page numbers
        ...List.generate(endPage - startPage + 1, (index) {
          final page = startPage + index;
          final isActive = page == currentPage;

          return GestureDetector(
            onTap: () async => onPageClick(page),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.primary(context)
                    : AppColors.card(context),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [CustomBoxShadow(context)],
              ),
              child: Text(
                "$page",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: isActive ? Colors.white : null,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }),

        // Right arrow
        GestureDetector(
          onTap: () => onNext(),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: currentPage != totalPages
                  ? AppColors.card(context)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [CustomBoxShadow(context)],
            ),
            child: currentPage != totalPages
                ? Icon(
                    Icons.chevron_right,
                    color: AppColors.textPrimary(context),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
