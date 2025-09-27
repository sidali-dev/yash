// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:yash/app/controllers/auth/auth_controller.dart';
import 'package:yash/app/controllers/auth/user_controller.dart';
import 'package:yash/app/controllers/book_reader/book_reader_controller.dart';
import 'package:yash/app/controllers/bookshelf/bookshelf_controller.dart';
import 'package:yash/app/controllers/cart/cart_controller.dart';
import 'package:yash/app/controllers/category_books/category_books_controller.dart';
import 'package:yash/app/controllers/checkout/checkout_controller.dart';
import 'package:yash/app/controllers/navigation/navigation_controller.dart';
import 'package:yash/app/controllers/settings/settings_controller.dart';
import 'package:yash/app/controllers/store/store_controller.dart';
import 'package:yash/app/controllers/widgets/auth_card_controller.dart';
import 'package:yash/app/routes/app_routes.dart';
import 'package:yash/app/views/auth/auth_view.dart';
import 'package:yash/app/views/book_info/book_info_view.dart';
import 'package:yash/app/views/book_reader/book_reader_view.dart';
import 'package:yash/app/views/cart/cart_view.dart';
import 'package:yash/app/views/category_books/category_books_view.dart';
import 'package:yash/app/views/checkout_view/checkout_result.dart';
import 'package:yash/app/views/checkout_view/checkout_view.dart';
import 'package:yash/app/views/navigation/navigation.dart';
import 'package:yash/app/views/settings/settings_view.dart';
import 'package:yash/app/views/splash/splash.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final List<GetPage> routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
      binding: BindingsBuilder(() {
        Get.put(UserController(), permanent: true);
        Get.put(AuthController(), permanent: true);
      }),
    ),

    GetPage(
      name: Routes.AUTH,
      page: () => const AuthView(),
      binding: BindingsBuilder(() {
        Get.put(AuthCardController());
      }),
    ),

    GetPage(
      name: Routes.NAVIGATION,
      page: () => const Navigation(),
      binding: BindingsBuilder(() {
        Get.put(NavigationController());
        Get.put(BookshelfController());
        Get.put(StoreController());
        Get.put(CartController());
      }),
    ),

    GetPage(
      name: Routes.SETTINGS,
      page: () => const SettingsView(),
      binding: BindingsBuilder(() {
        Get.put(SettingsController());
      }),
      transition: Transition.leftToRight,
    ),

    GetPage(
      name: Routes.BOOK_INFO,
      page: () => BookInfoView(
        book: Get.arguments["book"],
        image: Get.arguments["image"],
        bookTag: Get.arguments["tag"],
      ),
      binding: BindingsBuilder(() {}),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: Routes.CART,
      page: () => CartView(),
      binding: BindingsBuilder(() {}),
      transition: Transition.downToUp,
    ),

    GetPage(
      name: Routes.CATEGORY_BOOKS,
      page: () => CategoryBooksView(category: Get.arguments["category"]),
      binding: BindingsBuilder(() {
        Get.put(CategoryBooksController());
      }),
      transition: Transition.downToUp,
    ),

    GetPage(
      name: Routes.CHECKOUT,
      page: () => CheckoutView(checkoutUrl: Get.arguments["checkout_url"]),
      binding: BindingsBuilder(() {
        Get.put(CheckoutController());
      }),
      transition: Transition.downToUp,
    ),

    GetPage(
      name: Routes.CHECKOUT_RESULT,
      page: () => CheckoutResult(isSuccess: Get.arguments["checkout_result"]),
      binding: BindingsBuilder(() {}),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: Routes.BOOK_READER,
      page: () => BookReaderView(
        initialPage: Get.arguments["initial_page"],
        book: Get.arguments["book"],
      ),
      binding: BindingsBuilder(() {
        Get.put(BookReaderController());
      }),
      transition: Transition.rightToLeft,
    ),
  ];
}
