import 'package:get_storage/get_storage.dart';

class BookmarkCacheService {
  final GetStorage _box = GetStorage();

  int getPage(String userId, String bookId) {
    final int? page = _box.read("${userId}_$bookId");

    if (page != null) {
      return page;
    }
    return 1;
  }

  Future<void> updatePage(String userId, String bookId, int page) async {
    await _box.write("${userId}_$bookId", page);
  }
}
