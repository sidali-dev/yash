import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:yash/app/helpers/helper_functions.dart';
import 'package:yash/app/model/book_model.dart';
import 'package:yash/app/views/store/widgets/book_cover_card.dart';

class BookCoversFutureBuilder extends StatelessWidget {
  const BookCoversFutureBuilder({
    super.key,
    required this.bookTag,
    required this.book,
    required this.showText,
    required this.height,
    required this.width,
    required this.onTap,
  });

  final String bookTag;
  final BookModel book;
  final bool showText;
  final double height;
  final double width;
  final Function({required BookModel book, required Uint8List? image}) onTap;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: HelperFunctions.getImage(
        context: context,
        imageId: book.cover,
        title: book.title,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //LOADING
          return BookCoverCard(
            image: null,
            book: book,
            isLoading: true,
            showText: showText,
            height: height,
            width: width,
          );
        }

        //FAILURE
        if (snapshot.hasError) {
          return GestureDetector(
            onTap: () => onTap(image: null, book: book),
            child: Hero(
              tag: bookTag,
              child: BookCoverCard(
                image: null,
                book: book,
                isLoading: false,
                showText: showText,
                height: height,
                width: width,
              ),
            ),
          );
        }

        //SUCCESS
        if (snapshot.hasData && snapshot.data != null) {
          return GestureDetector(
            onTap: () => onTap(image: snapshot.data, book: book),
            child: Hero(
              tag: bookTag,
              child: BookCoverCard(
                image: snapshot.data,
                book: book,
                isLoading: false,
                showText: showText,
                height: height,
                width: width,
              ),
            ),
          );
        }

        //FALLBACK
        return GestureDetector(
          onTap: () => onTap(image: null, book: book),
          child: Hero(
            tag: bookTag,
            child: BookCoverCard(
              book: book,
              isLoading: false,
              image: null,
              showText: showText,
              height: height,
              width: width,
            ),
          ),
        );
      },
    );
  }
}
