import 'package:flutter/material.dart';
import 'package:yash/app/theme/app_colors.dart';

class ProfileSwitchRow extends StatelessWidget {
  const ProfileSwitchRow({
    super.key,
    required this.iconData,
    required this.title,
    required this.subTitle,
    required this.onTap,
    required this.value,
  });

  final IconData iconData;
  final String title;
  final String subTitle;
  final VoidCallback onTap;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.secondaryBackground(context),
            ),
            child: Icon(iconData, color: AppColors.icon(context)),
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              Text(subTitle, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
          Spacer(),
          Switch(
            value: value,
            onChanged: (value) {
              onTap();
            },
          ),
        ],
      ),
    );
  }
}
