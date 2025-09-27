import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:yash/app/controllers/auth/user_controller.dart';
import 'package:yash/app/model/book_model.dart';
import 'package:yash/app/model/user_library_model.dart';
import 'package:yash/app/repository/user_library_repository.dart';

class BookshelfController extends GetxController {
  late final UserLibraryRepository _repository;
  late final UserController userController;

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;

  late final Rx<UserLibraryModel> userLibrary;

  @override
  void onInit() async {
    super.onInit();

    try {
      isLoading.value = true;

      userController = Get.find();
      _repository = UserLibraryRepository();

      await loadLibrary();
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadLibrary() async {
    final UserLibraryModel? userLibraryModel = await _repository.loadLibrary(
      userId: userController.user.value!.$id,
    );

    userLibrary = userLibraryModel!.obs;
  }

  Future reloadBooks() async {
    final UserLibraryModel? userLibraryModel = await _repository.loadLibrary(
      userId: userController.user.value!.$id,
    );
    if (userLibraryModel != null &&
        userLibraryModel.books.length != userLibrary.value.books.length) {
      userLibrary.value = userLibraryModel;
      return;
    }

    final UserLibraryModel? result = await _repository.updateLibrary(
      userId: userController.user.value!.$id,
    );

    if (result != null) {
      userLibrary.value = result;
    }
  }

  bool hasBook(BookModel book) {
    return userLibrary.value.books.contains(book);
  }
}
