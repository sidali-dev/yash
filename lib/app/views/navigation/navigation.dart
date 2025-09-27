import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yash/app/controllers/navigation/navigation_controller.dart';
import 'package:yash/app/views/bookshelf/bookshlef_view.dart';
import 'package:yash/app/views/navigation/widgets/custom_bottom_navigation.dart';
import 'package:yash/app/views/store/store_view.dart';

class Navigation extends GetView<NavigationController> {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(() {
            switch (controller.currentIndex.value) {
              case 0:
                return const StoreView();
              case 1:
                return const BookshlefView();
              default:
                return const SizedBox.shrink();
            }
          }),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavigation(),
          ),
        ],
      ),
    );
  }
}
