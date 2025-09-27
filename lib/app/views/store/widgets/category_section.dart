import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:yash/app/helpers/helper_functions.dart';
import 'package:yash/app/model/book_model.dart';
import 'package:yash/app/routes/app_routes.dart';
import 'package:yash/app/views/store/widgets/books_cover_future_builder.dart';
import 'package:yash/generated/l10n.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({
    super.key,
    required this.books,
    required this.onBookTapped,
    required this.s,
  });

  final List<BookModel> books;
  final Function(BookModel book, String tag, Uint8List? image) onBookTapped;
  final S s;

  @override
  Widget build(BuildContext context) {
    final bool isRtl = HelperFunctions.isRtl();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                books.first.categoryModel.category,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () => Get.toNamed(
                  Routes.CATEGORY_BOOKS,
                  arguments: {"category": books.first.categoryModel},
                ),
                child: Text(s.see_all),
              ),
            ],
          ),
        ),
        Align(
          alignment: isRtl ? Alignment.centerRight : Alignment.centerLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: books.map((book) {
                return SizedBox(
                  width: 128,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: BookCoversFutureBuilder(
                      bookTag: "${book.title}-${book.categoryModel.category}",
                      book: book,
                      showText: true,
                      height: 220,
                      width: 128,
                      onTap: ({required book, required image}) => onBookTapped(
                        book,
                        "${book.title}-${book.categoryModel.category}",
                        image,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
