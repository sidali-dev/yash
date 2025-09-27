import 'package:get_storage/get_storage.dart';
import 'package:yash/app/model/book_model.dart';

class CartCacheService {
  final GetStorage _box = GetStorage();

  static const String _cartKey = 'cart';

  List<BookModel> getCart(String userId) {
    final List? cart = _box.read("${_cartKey}_$userId");

    if (cart != null) {
      final List<BookModel> books = [];
      for (Map<String, dynamic> book in cart) {
        books.add(BookModel.fromJson(book));
      }
      return books;
    }
    return [];
  }

  Future<void> updateCart(String userId, List cart) async {
    await _box.write("${_cartKey}_$userId", cart);
  }
}
