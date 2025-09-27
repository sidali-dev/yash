import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:yash/app/model/book_model.dart';
import 'package:yash/app/views/store/widgets/books_cover_future_builder.dart';
import 'package:yash/generated/l10n.dart';

class LatestReleasesCarousel extends StatelessWidget {
  const LatestReleasesCarousel({
    super.key,
    required this.books,
    required this.onBookTapped,
    required this.s,
  });

  final List<BookModel> books;
  final Function(BookModel book, String tag, Uint8List? image) onBookTapped;
  final S s;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            s.recently_added,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.copyWith(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            s.you_might_like_this_books,
            style: Theme.of(
              context,
            ).textTheme.titleSmall!.copyWith(color: Colors.white),
          ),
        ),
        SizedBox(height: 24),
        CarouselSlider(
          items: books.map((book) {
            return BookCoversFutureBuilder(
              bookTag: "${book.title}-new-release",
              book: book,
              showText: true,
              height: 220,
              width: 128,
              onTap: ({required book, required image}) =>
                  onBookTapped(book, "${book.title}-new-release", image),
            );
          }).toList(),
          options: CarouselOptions(
            autoPlay: true,
            enableInfiniteScroll: true,
            enlargeCenterPage: true,
            enlargeFactor: 0.4,
            viewportFraction: 0.4,
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            height: 220,
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayInterval: const Duration(seconds: 5),
          ),
        ),
      ],
    );
  }
}
