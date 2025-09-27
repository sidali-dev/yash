import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:yash/app/controllers/bookshelf/bookshelf_controller.dart';
import 'package:yash/app/model/book_model.dart';
import 'package:yash/app/model/category_model.dart';
import 'package:yash/app/routes/app_routes.dart';
import 'package:yash/app/services/appwrite_service.dart';

class CategoryBooksController extends GetxController {
  final int _limit = 12;
  late final AppwriteService _appwriteService;
  late final BookshelfController _bookshelfController;
  late final ScrollController scrollController;

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxInt pageNumber = 1.obs;
  final RxList<BookModel> books = <BookModel>[].obs;

  late final CategoryModel categoryModel;
  int? totalBooks;
  late final int totalPages;

  @override
  void onInit() async {
    super.onInit();
    try {
      isLoading.value = true;

      categoryModel = Get.arguments["category"];

      _bookshelfController = Get.find();
      scrollController = ScrollController();
      _appwriteService = AppwriteService();

      await getBooks(pageNumber.value);
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getBooks(int page) async {
    pageNumber.value = page;

    int offset = (pageNumber.value - 1) * _limit;

    final result = await _appwriteService.getBooks(
      categoryId: categoryModel.id,
      limit: _limit,
      offset: offset,
    );

    if (totalBooks == null) {
      totalBooks = result!.total;
      totalPages = (totalBooks! / _limit).ceil();
    }

    books.value = result!.rows.map((e) => BookModel.fromJson(e.data)).toList();

    await Future.delayed(500.microseconds);

    scrollController.animateTo(
      0,
      duration: 1000.milliseconds,
      curve: Curves.easeInOut,
    );
  }

  void goToBookInfo({
    required BookModel book,
    required Uint8List? image,
    required String tag,
  }) {
    if (_bookshelfController.hasBook(book)) {
      Get.toNamed(
        Routes.BOOK_INFO,
        arguments: {"book": book, "image": image, "tag": tag},
      );
    } else {
      Get.toNamed(
        Routes.BOOK_INFO,
        arguments: {"book": book, "image": image, "tag": tag},
      );
    }
  }
}
