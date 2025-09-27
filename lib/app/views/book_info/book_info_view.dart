import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:yash/app/controllers/cart/cart_controller.dart';
import 'package:yash/app/model/book_model.dart';
import 'package:yash/app/theme/app_colors.dart';
import 'package:yash/app/views/book_info/widgets/book_info_header.dart';
import 'package:yash/app/views/book_info/widgets/book_info_row.dart';
import 'package:yash/app/widgets/custom_progress_indicator.dart';
import 'package:yash/generated/l10n.dart';

class BookInfoView extends GetView<CartController> {
  const BookInfoView({
    required this.bookTag,
    required this.book,
    required this.image,
    super.key,
  });

  final String bookTag;
  final BookModel book;
  final Uint8List? image;

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
          onRefresh: () async => controller.reload(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BookInfoHeader(
                  book: book,
                  bookTag: bookTag,
                  image: image,
                  s: s,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 152),
                      Text(
                        book.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          spacing: 16,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BookInfoRow(
                              icon: Iconsax.user_bold,
                              text: book.authorModel.name,
                            ),
                            BookInfoRow(
                              icon: Iconsax.book_1_outline,
                              text: book.pageCount.toString(),
                            ),
                            BookInfoRow(
                              icon: Iconsax.tag_outline,
                              text: book.categoryModel.category,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => controller.bookshelfController.hasBook(book)
                            ? CustomProgressIndicator(
                                minHeight: 8,
                                spacing: 16,
                                textSize: 14,
                                book: book,
                                userId: controller
                                    .bookshelfController
                                    .userController
                                    .user
                                    .value!
                                    .$id,
                              )
                            : Text(
                                "${book.price}.00 ${s.da}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(
                                      color: AppColors.primary(context),
                                    ),
                                textAlign: TextAlign.center,
                              ),
                      ),
                      const SizedBox(height: 32),
                      Column(
                        spacing: 8,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            s.description,
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            book.description,
                            style: Theme.of(context).textTheme.titleSmall,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      const SizedBox(height: 64),
                      Obx(
                        () => ElevatedButton(
                          onPressed: () async => controller.isLoading.value
                              ? null
                              : controller.bookshelfController.hasBook(book)
                              ? await controller.openBook(book, 1)
                              : controller.isInCart(book)
                              ? controller.goToCart()
                              : controller.addToCart(book),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.card(context),
                            elevation: 5,
                          ),
                          child: Center(
                            child: controller.isLoading.value
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: AppColors.primary(context),
                                    ),
                                  )
                                : Text(
                                    controller.bookshelfController.hasBook(book)
                                        ? s.start_over
                                        : controller.isInCart(book)
                                        ? s.go_to_cart
                                        : s.add_to_cart,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineSmall,
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => ElevatedButton(
                          onPressed: () async => controller.isLoading.value
                              ? null
                              : controller.bookshelfController.hasBook(book)
                              ? await controller.openBook(book, null)
                              : controller.createChargilyInvoice(book),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary(context),
                            elevation: 5,
                          ),
                          child: Center(
                            child: controller.isLoading.value
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(),
                                  )
                                : Text(
                                    controller.bookshelfController.hasBook(book)
                                        ? s.continue_reading
                                        : s.buy_now,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(color: Colors.white),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
