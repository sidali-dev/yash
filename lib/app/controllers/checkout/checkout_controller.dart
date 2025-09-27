import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckoutController extends GetxController {
  late final WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            if (request.url.startsWith("http://")) {
              final secureUrl = request.url.replaceFirst("http://", "https://");
              webViewController.loadRequest(Uri.parse(secureUrl));
              return NavigationDecision.prevent;
            }

            // ✅ success
            if (request.url.startsWith("https://google.com/")) {
              Get.back(result: true);
              return NavigationDecision.prevent;
            }

            // ❌ failure
            if (request.url.startsWith("https://www.bing.com/")) {
              Get.back(result: false);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      );
  }

  void loadCheckoutUrl(String url) {
    final secureUrl = url.startsWith("http://")
        ? url.replaceFirst("http://", "https://")
        : url;

    webViewController.loadRequest(Uri.parse(secureUrl));
  }
}
//catch the response, and navigate to appropriate screen