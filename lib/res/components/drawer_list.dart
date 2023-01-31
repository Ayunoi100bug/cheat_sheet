import 'package:flutter/material.dart';

import '../colors.dart';
import '../typo.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  CustomListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.primary600,
      ),
      title: Medium20px(
        text: title,
        color: AppColors.primary600,
      ),
      onTap: onTap,
    );
  }
}
