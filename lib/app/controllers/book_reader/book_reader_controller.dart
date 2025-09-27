import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:yash/app/services/bookmark_cache_service.dart';

class BookReaderController extends GetxController {
  late final PdfViewerController pdfViewerController;
  late final BookmarkCacheService _bookmarkCacheService;

  @override
  void onInit() {
    _bookmarkCacheService = BookmarkCacheService();
    pdfViewerController = PdfViewerController();
    super.onInit();
  }

  void updateLastReadPage(int page) {
    _bookmarkCacheService.updatePage(
      Get.arguments["user_id"],
      Get.arguments["book_id"],
      page,
    );
  }
}
