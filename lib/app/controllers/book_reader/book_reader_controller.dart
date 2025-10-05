import 'package:get/get.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:yash/app/services/bookmark_cache_service.dart';

class BookReaderController extends GetxController {
  late final PdfViewerController pdfViewerController;
  late final BookmarkCacheService _bookmarkCacheService;
  late final noScreen = NoScreenshot.instance;

  @override
  void onInit() async {
    _bookmarkCacheService = BookmarkCacheService();
    pdfViewerController = PdfViewerController();
    await noScreen.screenshotOff();

    super.onInit();
  }

  @override
  InternalFinalCallback<void> get onDelete {
    noScreen.screenshotOn();

    return super.onDelete;
  }

  void updateLastReadPage(int page) {
    _bookmarkCacheService.updatePage(
      Get.arguments["user_id"],
      Get.arguments["book_id"],
      page,
    );
  }
}
