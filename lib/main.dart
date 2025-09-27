import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/instance_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yash/app/controllers/app/language_controller.dart';
import 'package:yash/app/controllers/app/theme_controller.dart';
import 'package:yash/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await dotenv.load(fileName: ".env");

  await GetStorage.init();

  Get.put(LanguageController());
  Get.put(ThemeController());

  runApp(MyApp());
}
