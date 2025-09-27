import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:yash/app/model/book_model.dart';
import 'package:yash/app/theme/app_colors.dart';
import 'package:yash/generated/l10n.dart';

class ExpandedOrderInfo extends StatelessWidget {
  const ExpandedOrderInfo({
    super.key,
    required this.width,
    required this.height,
    required this.onTap,
    required this.books,
    required this.total,
    required this.onCheckout,
    required this.isLoading,
    required this.s,
  });

  final double width;
  final double height;
  final Function onTap;
  final List<BookModel> books;
  final int total;
  final Function onCheckout;
  final bool isLoading;
  final S s;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => onTap(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              Text(
                s.order_info,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              Icon(Iconsax.arrow_down_1_outline),
            ],
          ),
        ),
        SizedBox(height: 0),
        SizedBox(
          height: height,
          child: SingleChildScrollView(
            child: Column(
              children: books
                  .map(
                    (e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width / 2,
                          child: Text(
                            e.title,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Text(
                          '${e.price}.00 ${s.da}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width / 2,
              child: Text(
                s.total,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              "$total.00 ${s.da}",
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 0),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary(context),
            elevation: 10,
          ),
          onPressed: () async {
            isLoading ? null : await onCheckout();
          },
          child: isLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(),
                )
              : Text(
                  s.checkout,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: Colors.white),
                ),
        ),
        SizedBox(height: 0),
      ],
    );
  }
}
