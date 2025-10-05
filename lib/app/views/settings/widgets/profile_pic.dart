import 'package:flutter/material.dart';
import 'package:yash/app/controllers/settings/settings_controller.dart';
import 'package:yash/app/theme/app_colors.dart';
import 'package:yash/app/widgets/custom_box_shadow.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({super.key, required this.controller});

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -72),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(boxShadow: [CustomBoxShadow(context)]),
            child: controller.userController.image == null
                ? CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 72,
                    child: Icon(
                      Icons.person,
                      size: 80,
                      color: AppColors.primary(context),
                    ),
                  )
                : CircleAvatar(
                    backgroundImage: MemoryImage(
                      controller.userController.image!,
                    ),
                    radius: 72,
                  ),
          ),
          Text(
            controller.userController.googleUser.value.name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
