import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:yash/app/controllers/category_books/category_books_controller.dart';
import 'package:yash/app/model/category_model.dart';
import 'package:yash/app/views/category_books/widgets/category_books_header.dart';
import 'package:yash/app/views/category_books/widgets/numbered_pagination.dart';
import 'package:yash/app/views/store/widgets/books_cover_future_builder.dart';
import 'package:yash/app/widgets/error_card.dart';
import 'package:yash/app/widgets/loading_card.dart';
import 'package:yash/generated/l10n.dart';

class CategoryBooksView extends GetView<CategoryBooksController> {
  const CategoryBooksView({required this.category, super.key});

  final CategoryModel category;

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
          controller: controller.scrollController,
          child: Column(
            children: [
              Obx(() {
                if (controller.isLoading.value || controller.hasError.value) {
                  return CategoryBooksHeader(
                    s: s,
                    numberOfBooks: 0,
                    category: category.category,
                  );
                }

                return CategoryBooksHeader(
                  s: s,
                  numberOfBooks: controller.totalBooks!,
                  category: category.category,
                );
              }),

              SizedBox(height: 64),

              Obx(() {
                if (controller.hasError.value) {
                  return ErrorCard(s: s);
                }

                if (controller.isLoading.value) {
                  return LoadingCard(s: s);
                }

                return GridView(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 16,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: controller.books
                      .map(
                        (book) => BookCoversFutureBuilder(
                          bookTag: "${book.id}-category",
                          book: book,
                          showText: true,
                          height: 300,
                          width: 128,
                          onTap: ({required book, required image}) =>
                              controller.goToBookInfo(
                                book: book,
                                image: image,
                                tag: "${book.id}-category",
                              ),
                        ),
                      )
                      .toList(),
                );
              }),
              SizedBox(height: 32),
              Obx(() {
                if (controller.isLoading.value || controller.hasError.value) {
                  return SizedBox();
                }

                return NumberedPagination(
                  currentPage: controller.pageNumber.value,
                  totalPages: controller.totalPages,
                  onPrevious: () =>
                      controller.getBooks(controller.pageNumber.value - 1),
                  onPageClick: (page) => controller.getBooks(page),
                  onNext: () =>
                      controller.getBooks(controller.pageNumber.value + 1),
                );
              }),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
