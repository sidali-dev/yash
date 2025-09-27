import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:yash/app/const/images.dart';
import 'package:yash/app/model/book_model.dart';
import 'package:yash/app/theme/app_colors.dart';
import 'package:yash/app/widgets/custom_box_shadow.dart';

class BookCoverCard extends StatelessWidget {
  const BookCoverCard({
    super.key,
    required this.book,
    required this.image,
    required this.isLoading,
    required this.showText,
    required this.height,
    required this.width,
  });

  final BookModel book;
  final Uint8List? image;
  final bool isLoading;
  final bool showText;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.secondaryBackground(context),
                boxShadow: [CustomBoxShadow(context)],
              ),
              clipBehavior: Clip.hardEdge,
              child: isLoading
                  //is loading
                  ? SizedBox(
                      width: width,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : image == null
                  //failure
                  ? SizedBox(
                      width: width,
                      child: Center(
                        child: Image.asset(Images.logo, height: width / 2),
                      ),
                    )
                  //success
                  : Image.memory(image!, fit: BoxFit.cover),
            ),
          ),
          showText
              ? Text(
                  book.title,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              : SizedBox(),
          showText
              ? Text(
                  book.authorModel.name,
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
