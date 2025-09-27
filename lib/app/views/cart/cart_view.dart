import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:yash/app/controllers/cart/cart_controller.dart';
import 'package:yash/app/helpers/helper_functions.dart';
import 'package:yash/app/views/cart/widgets/animated_cart_info_card.dart';
import 'package:yash/app/views/cart/widgets/cart_book_card.dart';
import 'package:yash/app/views/cart/widgets/cart_header.dart';
import 'package:yash/generated/l10n.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = HelperFunctions.screenWidth(context);
    final double height = HelperFunctions.screenHeight(context);
    final S s = S.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          if (controller.isExpanded.value) {
            controller.expandCard();
          }
        },
        child: Scaffold(
          body: SizedBox(
            height: height,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Stack(
                    children: [
                      CartHeader(
                        s: s,
                        onClearCart: () => controller.clearCart(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 128.0, bottom: 128),
                        child: Obx(
                          () => Column(
                            children: controller.cartBooks
                                .map(
                                  (book) => CartBookCard(
                                    s: s,
                                    book: book,
                                    onDelete: () =>
                                        controller.removeFromCart(book),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Obx(
                    () => AnimatedCartInfoCard(
                      s: s,
                      width: width,
                      height: height * 0.2,
                      isExpanded: controller.isExpanded.value,
                      books: controller.cartBooks,
                      onTap: controller.expandCard,
                      onCheckout: () async {
                        await controller.createChargilyInvoice(null);
                      },
                      total: controller.total.value,
                      isLoading: controller.isLoading.value,
                    ),
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
