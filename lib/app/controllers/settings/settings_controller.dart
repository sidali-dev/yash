import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:yash/app/controllers/app/language_controller.dart';
import 'package:yash/app/controllers/app/theme_controller.dart';
import 'package:yash/app/controllers/auth/user_controller.dart';

class SettingsController extends GetxController {
  late final UserController userController;
  late final LanguageController languageController;
  late final ThemeController themeController;

  @override
  void onInit() {
    super.onInit();
    userController = Get.find();
    languageController = Get.find();
    themeController = Get.find();
  }
}
