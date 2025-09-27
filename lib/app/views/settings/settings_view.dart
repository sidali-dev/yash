import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yash/app/controllers/settings/settings_controller.dart';
import 'package:yash/app/views/settings/widgets/app_settings_card.dart';
import 'package:yash/app/views/settings/widgets/profile_pic.dart';
import 'package:yash/app/views/settings/widgets/settings_header.dart';
import 'package:yash/app/views/settings/widgets/signout_button.dart';
import 'package:yash/generated/l10n.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    S s = S.of(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SettingsHeader(s: s),
              ProfilePic(controller: controller),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  spacing: 32,
                  children: [
                    AppSettingsCard(s: s),
                    SignoutButton(s: s),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
