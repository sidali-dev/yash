import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yash/app/const/enums.dart';

class LanguageController {
  final GetStorage box = GetStorage();
  final String selectedLanguageKey = "selectedLanguage";

  String getCurrentLanguage() {
    return box.read(selectedLanguageKey) ?? Language.en.name;
  }

  void changeCurrentLanguage(String language) {
    box.write(selectedLanguageKey, language);
    Get.updateLocale(Locale(language));
  }

  String getLanguageTitle(Language language) {
    switch (language) {
      case Language.en:
        return "English";
      case Language.fr:
        return "Francais";
      case Language.ar:
        return "العربية";
    }
  }
}
