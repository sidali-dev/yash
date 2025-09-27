import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final GetStorage box = GetStorage();
  late RxBool isDark;
  final String themeModeKey = 'themeMode';

  @override
  onInit() {
    super.onInit();
    isDark = isDarkMode().obs;
  }

  Future<void> _saveThemeMode(bool isDarkMode) async {
    await box.write(themeModeKey, isDarkMode);
  }

  bool isDarkMode() {
    return box.read(themeModeKey) ?? false;
  }

  Future<void> switchTheme() async {
    bool isDarkModeVar = isDarkMode();
    Get.changeThemeMode(isDarkModeVar ? ThemeMode.light : ThemeMode.dark);

    await _saveThemeMode(!isDarkModeVar);
    isDark.value = !isDarkModeVar;
    update();
  }
}
