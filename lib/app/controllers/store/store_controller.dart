import 'dart:typed_data';

import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:yash/app/controllers/bookshelf/bookshelf_controller.dart';
import 'package:yash/app/model/book_model.dart';
import 'package:yash/app/model/category_model.dart';
import 'package:yash/app/routes/app_routes.dart';
import 'package:yash/app/services/appwrite_service.dart';

class StoreController extends GetxController {
  late final AppwriteService appwriteService;
  late final BookshelfController bookshelfController;

  final RxList<BookModel> newReleases = <BookModel>[].obs;
  final RxList<List<BookModel>> booksByCategory = <List<BookModel>>[].obs;

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;

  @override
  void onInit() async {
    super.onInit();
    try {
      isLoading.value = true;

      appwriteService = AppwriteService();

      bookshelfController = Get.find();

      await fetchNewReleases();
      await fetchBooksByCategory();
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchNewReleases() async {
    final result = await appwriteService.getBooks(limit: 5);

    if (result != null && result.rows.isNotEmpty) {
      final List<BookModel> allBooks = result.rows
          .map((doc) => BookModel.fromJson(doc.data))
          .toList();

      newReleases.value = allBooks;
    }
  }

  Future<void> fetchBooksByCategory() async {
    final response = await appwriteService.getCategories();

    if (response == null) {
      return;
    }

    List<CategoryModel> categories = response.rows
        .map((e) => CategoryModel.fromJson(e.data))
        .toList();

    for (CategoryModel category in categories) {
      final result = await appwriteService.getBooks(
        limit: 5,
        categoryId: category.id,
      );
      if (result != null && result.rows.isNotEmpty) {
        final List<BookModel> allBooks = result.rows
            .map((doc) => BookModel.fromJson(doc.data))
            .toList();

        booksByCategory.add(allBooks);
      }
    }
  }

  void goToBookInfo({
    required BookModel book,
    required Uint8List? image,
    required String tag,
  }) {
    if (bookshelfController.hasBook(book)) {
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
