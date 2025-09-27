import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yash/app/controllers/checkout/checkout_controller.dart';
import 'package:yash/generated/l10n.dart';

class CheckoutView extends GetView<CheckoutController> {
  final String checkoutUrl;
  const CheckoutView({super.key, required this.checkoutUrl});

  @override
  Widget build(BuildContext context) {
    controller.loadCheckoutUrl(checkoutUrl);

    final S s = S.of(context);

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(s.checkout),
          centerTitle: true,
          leading: SizedBox(),
        ),
        body: WebViewWidget(controller: controller.webViewController),
      ),
    );
  }
}
