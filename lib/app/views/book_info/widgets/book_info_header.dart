import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:yash/app/model/book_model.dart';
import 'package:yash/app/theme/app_colors.dart';
import 'package:yash/app/views/store/widgets/book_cover_card.dart';
import 'package:yash/generated/l10n.dart';

class BookInfoHeader extends StatelessWidget {
  const BookInfoHeader({
    required this.bookTag,
    required this.book,
    required this.s,
    this.image,
    super.key,
  });

  final String bookTag;
  final BookModel book;
  final Uint8List? image;
  final S s;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.primary(context),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(48)),
          ),
          width: double.infinity,
          padding: EdgeInsets.only(left: 20, right: 20, top: 48, bottom: 240),
          child: Text(
            s.book_info,
            style: Theme.of(
              context,
            ).textTheme.displaySmall!.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        Positioned(
          bottom: -128,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            clipBehavior: Clip.hardEdge,
            child: Hero(
              tag: bookTag,
              child: BookCoverCard(
                image: image,
                book: book,
                isLoading: false,
                showText: false,
                height: 320,
                width: 200,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
