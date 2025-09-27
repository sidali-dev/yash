import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:yash/app/controllers/app/language_controller.dart';
import 'package:yash/app/controllers/app/theme_controller.dart';
import 'package:yash/app/routes/app_pages.dart';
import 'package:yash/app/theme/app_theme.dart';
import 'package:yash/generated/l10n.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeController themeController = Get.find();
  final LanguageController languageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Yash',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeController.isDarkMode()
          ? ThemeMode.dark
          : ThemeMode.light,
      locale: Locale(languageController.getCurrentLanguage()),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
