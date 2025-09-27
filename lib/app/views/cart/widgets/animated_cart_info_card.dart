import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/num_extensions.dart';
import 'package:yash/app/model/book_model.dart';
import 'package:yash/app/theme/app_colors.dart';
import 'package:yash/app/views/cart/widgets/expanded_info_card.dart';
import 'package:yash/app/views/cart/widgets/shrinked_info_order.dart';
import 'package:yash/app/widgets/custom_box_shadow.dart';
import 'package:yash/generated/l10n.dart';

class AnimatedCartInfoCard extends StatelessWidget {
  const AnimatedCartInfoCard({
    super.key,
    required this.isExpanded,
    required this.width,
    required this.height,
    required this.onTap,
    required this.onCheckout,
    required this.books,
    required this.total,
    required this.isLoading,
    required this.s,
  });

  final bool isExpanded;
  final double width;
  final double height;
  final Function onTap;
  final Function onCheckout;
  final List<BookModel> books;
  final int total;
  final bool isLoading;
  final S s;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card(context),
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        boxShadow: [CustomBoxShadow(context)],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: AnimatedSwitcher(
        duration: 1000.milliseconds,
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: (child, anim) => FadeTransition(
          opacity: anim,
          child: SizeTransition(sizeFactor: anim, child: child),
        ),
        child: isExpanded
            ? ExpandedOrderInfo(
                books: books,
                width: width,
                onTap: onTap,
                onCheckout: onCheckout,
                height: height,
                total: total,
                isLoading: isLoading,
                s: s,
              )
            : ShrinkedOrderInfo(onTap: onTap),
      ),
    );
  }
}
