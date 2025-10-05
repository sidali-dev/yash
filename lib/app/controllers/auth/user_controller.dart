import 'dart:typed_data';

import 'package:appwrite/models.dart';
import 'package:get/get.dart';
import 'package:yash/app/model/google_user_model.dart';
import 'package:yash/app/services/user_cache_service.dart';

class UserController extends GetxController {
  late Rx<User?> user;
  late Rx<UserModel> googleUser;

  final Rx<Uint8List?> _image = Rx<Uint8List?>(null);
  Uint8List? get image => _image.value;

  void initUser(User user) {
    this.user = user.obs;
  }

  Future initGoogleUser(UserModel googleUser) async {
    this.googleUser = googleUser.obs;

    await displayImage();
  }

  Future<Uint8List?> displayImage() async {
    if (googleUser.value.picture == null) {
      return null;
    }

    if (_image.value != null) {
      return _image.value;
    }

    UserCacheService cacheService = UserCacheService();

    _image.value = await cacheService.getUserAvatar(googleUser.value.picture!);

    return _image.value!;
  }

  void clearImage() {
    _image.value = null;
  }
}
