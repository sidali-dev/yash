import 'package:get/get.dart';
import 'package:yash/app/controllers/auth/user_controller.dart';
import 'package:yash/app/model/google_user_model.dart';
import 'package:yash/app/services/appwrite_service.dart';
import 'package:yash/app/routes/app_routes.dart';
import 'package:yash/app/services/user_cache_service.dart';
import 'package:yash/generated/l10n.dart';

class AuthController extends GetxController {
  late final AppwriteService _appwriteService;
  late final S _s;
  final RxBool isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;

  @override
  onInit() {
    super.onInit();
    _s = S.of(Get.context!);
    _appwriteService = AppwriteService();
  }

  Future<void> checkLoginStatus() async {
    isLoggedIn.value = await _appwriteService.isLoggedIn();
    if (isLoggedIn.value) {
      UserController userController = Get.find();
      userController.initUser(_appwriteService.currentUser!);
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      isLoading.value = true;
      await _appwriteService.createAccount(
        email: email,
        password: password,
        name: name,
      );

      await signIn(email: email, password: password, newUser: true);
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
    required bool newUser,
  }) async {
    try {
      isLoading.value = true;
      await _appwriteService.login(email: email, password: password);

      if (newUser) {
        try {
          await _appwriteService.createUserLibrary();
          await Future.delayed(Duration(milliseconds: 500));
        } catch (_) {}
      }

      isLoggedIn.value = true;

      UserController userController = Get.find();
      userController.initUser(_appwriteService.currentUser!);
      await userController.initGoogleUser(
        UserModel(
          id: _appwriteService.currentUser!.$id,
          email: _appwriteService.currentUser!.email,
          name: _appwriteService.currentUser!.name,
          picture: null,
        ),
      );

      Get.offAllNamed(Routes.NAVIGATION);
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      await _appwriteService.loginWithGoogle();
      isLoggedIn.value = true;

      UserController userController = Get.find();
      userController.initUser(_appwriteService.currentUser!);

      try {
        await Future.delayed(Duration(milliseconds: 500));
        await _appwriteService.createUserLibrary();
      } catch (_) {}

      final response = await _appwriteService.getGoogleUserProfile();

      UserCacheService cacheService = UserCacheService();
      cacheService.setUserProfile(response);
      cacheService.setAvatarFromUrl(response.picture!);

      await userController.initGoogleUser(response);

      Get.offAllNamed(Routes.NAVIGATION);
    } catch (_) {
      await _appwriteService.logout();

      Get.snackbar(
        _s.error,
        _s.something_went_wrong,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      isLoading.value = true;
      UserController userController = Get.find();
      await _appwriteService.logout();

      userController.clearImage();
      isLoggedIn.value = false;
      Get.offAllNamed(Routes.AUTH);
    } catch (e) {
      Get.snackbar(
        _s.error,
        _s.something_went_wrong,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> loadUserProfile() async {
    UserController userController = Get.find();

    UserCacheService cacheService = UserCacheService();
    UserModel? googleUserModel = await cacheService.getUserProfile(
      userController.user.value!.$id,
    );

    if (googleUserModel == null) {
      googleUserModel = UserModel(
        id: userController.user.value!.$id,
        email: userController.user.value!.email,
        name: userController.user.value!.name,
        picture: null,
      );

      cacheService.setUserProfile(googleUserModel);
    }

    try {
      await userController.initGoogleUser(googleUserModel);
      return true;
    } catch (e) {
      return false;
    }
  }
}
