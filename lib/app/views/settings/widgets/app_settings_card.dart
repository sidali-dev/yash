import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/route_manager.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:yash/app/const/enums.dart';
import 'package:yash/app/controllers/settings/settings_controller.dart';
import 'package:yash/app/theme/app_colors.dart';
import 'package:yash/app/views/settings/widgets/profile_info_row.dart';
import 'package:yash/app/views/settings/widgets/profile_switch_row.dart';
import 'package:yash/app/widgets/custom_box_shadow.dart';
import 'package:yash/generated/l10n.dart';

class AppSettingsCard extends GetView<SettingsController> {
  const AppSettingsCard({super.key, required this.s});
  final S s;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.background(context),
        borderRadius: BorderRadius.circular(36),
        boxShadow: [CustomBoxShadow(context)],
      ),
      child: Column(
        children: [
          ProfileInfoRow(
            iconData: Icons.g_translate_outlined,
            title: s.language,
            subTitle: Language.values
                .byName(controller.languageController.getCurrentLanguage())
                .displayName,
            onTap: () => _updateLanguageBottomSheet(
              context: context,
              initValue: Language.values.byName(
                controller.languageController.getCurrentLanguage(),
              ),
              onTap: (value) => controller.languageController
                  .changeCurrentLanguage(value.name),
            ),
          ),
          Divider(),
          ProfileSwitchRow(
            title: s.theme,
            subTitle: controller.themeController.isDark.value
                ? s.dark_mode
                : s.light_mode,
            iconData: Iconsax.moon_outline,
            value: controller.themeController.isDark.value,

            onTap: () => controller.themeController.switchTheme(),
          ),
        ],
      ),
    );
  }

  void _updateLanguageBottomSheet({
    required BuildContext context,
    required Language initValue,
    required Function(Language) onTap,
  }) {
    final Rx<Language> selectedValue = initValue.obs;

    final S s = S.of(context);

    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: AppColors.background(context),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.g_translate_outlined),
                  SizedBox(width: 8),
                  Text(
                    s.select_language,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: Language.values.map((lang) {
                  return GestureDetector(
                    onTap: () => selectedValue.value = lang,
                    child: Obx(
                      () => Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: AppColors.background(context),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            width: 2,
                            color: selectedValue.value == lang
                                ? AppColors.primary(context)
                                : AppColors.border(context),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 8,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(lang.flag),
                            Text(
                              lang.displayName,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: selectedValue.value == lang
                                        ? AppColors.primary(context)
                                        : AppColors.secondary(context),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  onTap(selectedValue.value);
                  Get.back();
                },
                child: Text(
                  s.confirm,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
