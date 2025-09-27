import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:yash/app/model/book_model.dart';
import 'package:yash/app/routes/app_routes.dart';
import 'package:yash/app/theme/app_colors.dart';
import 'package:yash/app/views/store/widgets/books_cover_future_builder.dart';
import 'package:yash/app/widgets/custom_box_shadow.dart';
import 'package:yash/app/widgets/custom_progress_indicator.dart';
import 'package:yash/generated/l10n.dart';

class ShelfBookCard extends StatelessWidget {
  const ShelfBookCard({
    super.key,
    required this.book,
    required this.userId,
    required this.s,
  });

  final BookModel book;
  final String userId;
  final S s;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card(context),
        boxShadow: [CustomBoxShadow(context)],
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            BookCoversFutureBuilder(
              onTap: ({required book, required image}) => Get.toNamed(
                Routes.BOOK_INFO,
                arguments: {
                  "book": book,
                  "image": image,
                  "tag": "${book.title}-library",
                },
              ),
              bookTag: "${book.title}-library",
              book: book,
              showText: false,
              height: 200,
              width: 128,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    book.authorModel.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${book.pageCount} ${s.pages}",
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.start,
                  ),
                  const Spacer(),
                  CustomProgressIndicator(
                    minHeight: 6,
                    spacing: 8,
                    textSize: 12,
                    book: book,
                    userId: userId,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
