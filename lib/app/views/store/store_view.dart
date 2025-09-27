import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:yash/app/controllers/store/store_controller.dart';
import 'package:yash/app/views/store/widgets/category_section.dart';
import 'package:yash/app/widgets/empty_books_card.dart';
import 'package:yash/app/widgets/error_card.dart';
import 'package:yash/app/views/store/widgets/latest_releases_carousel.dart';
import 'package:yash/app/widgets/loading_card.dart';
import 'package:yash/app/views/store/widgets/store_header.dart';
import 'package:yash/generated/l10n.dart';

class StoreView extends GetView<StoreController> {
  const StoreView({super.key});

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StoreHeader(),
              Transform.translate(
                offset: Offset(0, -192),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return LoadingCard(s: s);
                  }
                  if (controller.hasError.value) {
                    return ErrorCard(s: s);
                  }
                  if (controller.newReleases.isEmpty) {
                    return EmptyBooksCard(s: s);
                  }
                  return Column(
                    children: [
                      LatestReleasesCarousel(
                        s: s,
                        books: controller.newReleases,
                        onBookTapped: (book, tag, image) => controller
                            .goToBookInfo(book: book, image: image, tag: tag),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        spacing: 16,
                        children: controller.booksByCategory
                            .map(
                              (element) => CategorySection(
                                s: s,
                                books: element,
                                onBookTapped: (book, tag, image) =>
                                    controller.goToBookInfo(
                                      book: book,
                                      image: image,
                                      tag: tag,
                                    ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
