import 'dart:convert';

import 'package:appwrite/models.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:yash/app/controllers/bookshelf/bookshelf_controller.dart';
import 'package:yash/app/model/book_model.dart';
import 'package:yash/app/model/checkout_model.dart';
import 'package:yash/app/routes/app_routes.dart';
import 'package:yash/app/services/appwrite_service.dart';
import 'package:yash/app/services/bookmark_cache_service.dart';
import 'package:yash/app/services/cart_cache_service.dart';
import 'package:yash/generated/l10n.dart';

class CartController extends GetxController {
  late final BookshelfController bookshelfController;
  late final S _s;

  final RxList<BookModel> cartBooks = <BookModel>[].obs;
  final RxInt total = 0.obs;

  final RxBool isExpanded = false.obs;
  final RxBool isLoading = false.obs;

  late final AppwriteService _appwriteService;
  late final CartCacheService _cartCacheService;

  @override
  void onInit() {
    super.onInit();
    bookshelfController = Get.find();
    _appwriteService = AppwriteService();
    _s = S.of(Get.context!);

    _cartCacheService = CartCacheService();

    cartBooks.value = _cartCacheService.getCart(
      bookshelfController.userController.user.value!.$id,
    );

    cartBooks.map((e) => total.value = total.value + e.price).toList();
  }

  void reload() {
    bookshelfController.userLibrary.refresh();
  }

  void addToCart(BookModel book) {
    if (!isInCart(book)) {
      cartBooks.add(book);
      total.value = total.value + book.price;

      _cartCacheService.updateCart(
        bookshelfController.userController.user.value!.$id,
        cartBooks,
      );

      Get.snackbar(
        _s.success,
        _s.added_to_cart,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        _s.error,
        _s.book_already_in_cart,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void removeFromCart(BookModel book) {
    if (isInCart(book)) {
      cartBooks.remove(book);
      total.value = total.value - book.price;

      _cartCacheService.updateCart(
        bookshelfController.userController.user.value!.$id,
        cartBooks,
      );

      Get.snackbar(
        _s.success,
        _s.removed_from_cart,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        _s.error,
        _s.book_isnt_in_cart,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void clearCart() {
    if (cartBooks.isNotEmpty) {
      cartBooks.clear();
      total.value = 0;

      _cartCacheService.updateCart(
        bookshelfController.userController.user.value!.$id,
        cartBooks,
      );

      Get.snackbar(
        _s.success,
        _s.cart_cleared,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  bool isInCart(BookModel book) {
    return cartBooks.contains(book);
  }

  void goToCart() {
    Get.toNamed(Routes.CART);
  }

  void expandCard() {
    isExpanded.value = !isExpanded.value;
  }

  Future createChargilyInvoice(BookModel? book) async {
    try {
      isLoading.value = true;

      //check if the cart is empty
      if (cartBooks.isEmpty && book == null) {
        throw _s.cart_is_empty;
      }

      //check if a book in cart is already in library
      if (book == null) {
        final exists = cartBooks.any(
          (cartBook) => bookshelfController.userLibrary.value.books.any(
            (libraryBook) => libraryBook.id == cartBook.id,
          ),
        );
        if (exists) {
          throw _s.book_already_in_bookshelf;
        }
      } else {
        final exists = bookshelfController.userLibrary.value.books.any(
          (element) => element.id == book.id,
        );
        if (exists) {
          throw _s.book_already_in_bookshelf;
        }
      }

      //create the invoice
      late final Execution? result;

      if (book == null) {
        result = await _appwriteService.createChargilyInvoice(
          bookshelfController.userLibrary.value.books
              .map((book) => book.id)
              .toList(),
          cartBooks.map((book) => book.id).toList(),
          total.value,
        );
      } else {
        result = await _appwriteService.createChargilyInvoice(
          bookshelfController.userLibrary.value.books
              .map((book) => book.id)
              .toList(),
          [book.id],
          book.price,
        );
      }

      //make sure the invoice was created
      if (result == null) {
        throw _s.something_went_wrong;
      }

      //parse response
      CheckoutResponse checkoutResponse = CheckoutResponse.fromJson(
        jsonDecode(result.responseBody),
      );

      //open the webView for checkout
      final response = await Get.toNamed(
        Routes.CHECKOUT,
        arguments: {"checkout_url": checkoutResponse.checkoutUrl},
      );

      //make sure the webView was closed the right way
      if (response.runtimeType != bool) {
        throw _s.payment_canceled;
      }

      //clear cart and navigate to the checkout result screen after finishing
      if (response) {
        if (book == null) {
          clearCart();
        } else {
          if (isInCart(book)) {
            removeFromCart(book);
          }
        }

        Get.toNamed(
          Routes.CHECKOUT_RESULT,
          arguments: {"checkout_result": response},
        );

        await Future.delayed(5.seconds);
        bookshelfController.reloadBooks();
      }
      //if payment wasnt successful, just navigate to result screen
      else {
        Get.toNamed(
          Routes.CHECKOUT_RESULT,
          arguments: {"checkout_result": response},
        );
      }
    } catch (e) {
      Get.snackbar(_s.error, e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future openBook(BookModel book, int? initialPage) async {
    try {
      isLoading.value = true;

      final result = await _appwriteService.getBook(book.id, book.file);

      if (result == null || result.responseBody.startsWith("{")) {
        Get.snackbar(
          _s.error,
          _s.something_went_wrong,
          snackPosition: SnackPosition.BOTTOM,
        );

        return;
      } else {
        Uint8List bookFile = base64Decode(result.responseBody);

        if (initialPage == null) {
          initialPage = BookmarkCacheService().getPage(
            bookshelfController.userController.user.value!.$id,
            book.id,
          );

          Get.toNamed(
            Routes.BOOK_READER,
            arguments: {
              "user_id": bookshelfController.userController.user.value!.$id,
              "book_id": book.id,
              "initial_page": initialPage,
              "book": bookFile,
            },
          );
        } else {
          BookmarkCacheService().updatePage(
            bookshelfController.userController.user.value!.$id,
            book.id,
            initialPage,
          );

          Get.toNamed(
            Routes.BOOK_READER,
            arguments: {
              "user_id": bookshelfController.userController.user.value!.$id,
              "book_id": book.id,
              "initial_page": initialPage,
              "book": bookFile,
            },
          );
        }
      }
    } finally {
      isLoading.value = false;
    }
  }
}
