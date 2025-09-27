import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yash/app/controllers/bookshelf/bookshelf_controller.dart';
import 'package:yash/app/views/bookshelf/widgets/shelf_book_card.dart';
import 'package:yash/app/views/bookshelf/widgets/shelf_header.dart';
import 'package:yash/app/widgets/empty_books_card.dart';
import 'package:yash/app/widgets/error_card.dart';
import 'package:yash/app/widgets/loading_card.dart';
import 'package:yash/generated/l10n.dart';

class BookshlefView extends GetView<BookshelfController> {
  const BookshlefView({super.key});

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.reloadBooks();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              spacing: 24,
              children: [
                Obx(() {
                  if (controller.isLoading.value || controller.hasError.value) {
                    return ShelfHeader(s: s, numberOfPages: 0);
                  }

                  return ShelfHeader(
                    s: s,
                    numberOfPages: controller.userLibrary.value.books.length,
                  );
                }),
                const SizedBox(height: 16),
                Obx(() {
                  if (controller.isLoading.value) {
                    return LoadingCard(s: s);
                  }
                  if (controller.hasError.value) {
                    return ErrorCard(s: s);
                  }
                  if (controller.userLibrary.value.books.isEmpty) {
                    return EmptyBooksCard(s: s);
                  }
                  return Column(
                    children: [
                      ...controller.userLibrary.value.books.map(
                        (book) => ShelfBookCard(
                          book: book,
                          s: s,
                          userId: controller.userController.user.value!.$id,
                        ),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 128),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
